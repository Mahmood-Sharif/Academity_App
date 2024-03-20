<?php

namespace App\Controllers\AdminPortal;

use App\Entities\ClassEntity;
use App\Models\AcademyModel;
use App\Models\ClassModel;
use App\Models\ClassTimingModel;
use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourcePresenter;

class Classes extends ResourcePresenter
{
    protected $modelName = '\App\Models\ClassModel';
    /* @var ClassModel $model */
    protected $model;

    public function index(int|null $academyId = null): string
    {
        $classes = $this->model->limitByOwner(auth()->id());

        if ($academyId !== null) {
            $classes = $classes->where('classes.academy_id', $academyId);
        }
        return view('class/classes', [
            'classes' => $classes->findAll(),
            'academy' => $academyId !== null ? ((new AcademyModel())->find($academyId)) : null,
        ]);
    }

    public function show($id = null): string
    {
        $class = $this->model->includeOwnerId()->includePrice()->find($id);

        if (! auth()->user()->can('classes.access') || auth()->id() != $class?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $coach = auth()->getProvider()->find($class->coach_id);
        $classTimings = (new ClassTimingModel())->getTimingsForClass($id);
        $classTimingsMap =
        array_group_by(array_map(
            fn ($timing) => [...$timing->toArray(), 'dow' => strtolower($timing->day_of_week)],
            $classTimings
        ), ['dow']);

        return view('class/class', [
            'class' => $class,
            'coach' => $coach,
            'classTimingsJson' => json_encode($classTimingsMap),
            'numTimings' => count($classTimings),
        ]);
    }

    // show edit form
    public function edit($id = null): string
    {
        $class = $this->model->includeOwnerId()->includePrice()->find($id);

        if (! auth()->user()->can('classes.edit') || auth()->id() != $class?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        /* @var UserModel $users */
        $users = auth()->getProvider() ;
        $coaches = $users->coaches()->where('academies.academy_id', $class->academy_id)->findAll();
        $classTimings = (new ClassTimingModel())->getTimingsForClass($id);
        $classTimingsMap =
        array_group_by(array_map(
            fn ($timing) => [...$timing->toArray(), 'dow' => strtolower($timing->day_of_week)],
            $classTimings
        ), ['dow']);

        return view('class/create_edit', [
            'type' => 'edit',
            'class' => $class,
            'coaches' => key_array(fn ($coach) => [$coach->id, $coach->name], $coaches),
            'classTimingsJson' => json_encode($classTimingsMap),
            'numTimings' => count($classTimings),
            'errors' => [],
        ]);
    }

    // perform update
    public function update($id = null): ResponseInterface|string
    {
        $class = $this->model->includeOwnerId()->includePrice()->find($id);
        if (! auth()->user()->can('classes.edit') || auth()->id() != $class?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        if (! $this->validate(
            [
                ...$this->model->getValidationRules(),
                'timings' => 'required|valid_json',
                'price' => 'required|decimal',
            ],
            $this->model->getValidationMessages()
        )) {
            $classTimings = (new ClassTimingModel())->getTimingsForClass($id);
            $classTimingsMap =
            array_group_by(array_map(
                fn ($timing) => [...$timing->toArray(), 'dow' => strtolower($timing->day_of_week)],
                (new ClassTimingModel())->getTimingsForClass($id)
            ), ['dow']);
            /* @var UserModel $users */
            $users = auth()->getProvider() ;
            $coaches = $users->coaches()->where('academies.academy_id', $class->academy_id)->findAll();
            return view('class/create_edit', [
                'type' => 'edit',
                'class' => $class,
                'coaches' => key_array(fn ($coach) => [$coach->id, $coach->name], $coaches),
                'classTimingsJson' => json_encode($classTimingsMap),
                'numTimings' => count($classTimings),
                'errors' => $this->validator->getErrors(),
            ]);
        }

        $editedClass = new ClassEntity($this->validator->getValidated());

        // NOTE: only one enrollment duration for now
        $editedClass->max_duration = $editedClass->min_duration;

        // update timings
        $classTimings = json_decode($editedClass->timings, true);
        $classTimingsModel = new ClassTimingModel();
        $result = $classTimingsModel->replaceTimings($id, $classTimings);

        // update price
        $this->model->upsertPrice($id, $editedClass->price);

        $result = $result && $this->model->update($id, $editedClass);
        $flashData = [];
        if ($result) {
            $flashData = ['message', lang('App.class_update.success')];
        } else {
            $flashData = ['error', lang('App.class_update.error')];
        }

        sleep(1);
        return redirect()->route('AdminPortal\Classes::show', [$id])->with(...$flashData);
    }

    // show create form
    public function new(): string
    {
        if (!auth()->user()->can('classes.create')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $academyId = $this->request->getGet('academy_id');

        /* @var UserModel $users */
        $users = auth()->getProvider() ;
        $coaches = $users->coaches()->where('academies.academy_id', $academyId)->findAll();
        $academies = (new AcademyModel())->findAcademiesForOwner(auth()->id());

        return view('class/create_edit', [
            'type' => 'create',
            'academyId' => $academyId,
            'coaches' => key_array(fn ($coach) => [$coach->id, $coach->name], $coaches),
            'academies' => key_array(fn ($academy) => [$academy->academy_id, $academy->name], $academies),
            'class' => null,
            'classTimingsJson' => null,
            'numTimings' => null,
            'errors' => [],
        ]);
    }

    // perform create
    public function create(): ResponseInterface|string
    {
        if (!auth()->user()->can('classes.create')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        if (! $this->validate([
            ...$this->model->getValidationRules(),
            'academy_id' => 'required|integer',
            'timings' => 'required|valid_json',
            'price' => 'required|decimal',
        ])) {
            $academyId = $this->request->getPost('academy_id');
            /* @var UserModel $users */
            $users = auth()->getProvider() ;
            $coaches = $users->coaches()->where('academies.academy_id', $academyId)->findAll();
            $academies = (new AcademyModel())->findAcademiesForOwner(auth()->id());

            return view('class/create_edit', [
                'type' => 'create',
                'academy_id' => $academyId,
                'coaches' => key_array(fn ($coach) => [$coach->id, $coach->name], $coaches),
                'academies' => key_array(fn ($academy) => [$academy->academy_id, $academy->name], $academies),
                'class' => null,
                'classTimingsJson' => null,
                'numTimings' => null,
                'errors' => $this->validator->getErrors(),
            ]);
        }

        $class = new ClassEntity($this->validator->getValidated());

        $insertId = $this->model->insert($class->toArray(), true);

        $result = $insertId != null;

        // insert timings
        $classTimings = json_decode($class->timings, true);
        $classTimingsModel = new ClassTimingModel();
        $result = $result && $classTimingsModel->replaceTimings($insertId, $classTimings);

        // insert price
        $result = $result && $this->model->upsertPrice($insertId, $class->price);

        sleep(1);
        return redirect()->route('AdminPortal\Classes::show', [$insertId]);
    }

    /** AJAX remove confirm modal */
    public function remove($id = null): string
    {
        $class = $this->model->includeOwnerId()->find($id);
        if (auth()->user()->can('classes.delete') && $class?->owner_id === auth()->id()) {
            return view('class/ajax_remove_modal', [
              'error'   => false,
              'class' => $class
            ]);
        } else {
            return view('ajax_message_modal', [
              'title'     => lang('App.delete_class'),
              'body'      => lang('Security.disallowedAction'),
            ]);
        }
    }

    /** AJAX delete and respond with modal */
    public function delete($id = null): string
    {
        $class = $this->model->includeOwnerId()->find($id);

        if (!auth()->user()->can('classes.delete') || $class?->owner_id !== auth()->id()) {
            return view('ajax_message_modal', [
              'title' => lang('App.delete_class'),
              'body'  => lang('Security.disallowedAction')
            ]);
        }

        $academyId = $class->academy_id;
        $result = $this->model->delete($id);

        if ($result) {
            return view('ajax_message_modal', [
              'title'     => lang('App.delete_class'),
              'body'      => lang('App.delete_class.success', [$class->class_name]),
              'action'    => lang('App.back.classes'),
              'actionUrl' => url_to('AdminPortal\Classes::index', $academyId),
            ]);
        } else {
            return view('ajax_message_modal', [
                'title' => lang('App.delete_class'),
                'body'  => lang('App.delete_class.error'),
            ]);
        }
    }

    /**
     * @param mixed $id
     */
    public function registrationCode($id = null): string
    {
        $class = $this->model->includeOwnerId()->find($id);
        if (!auth()->user()->can('classes.access') || $class?->owner_id !== auth()->id()) {
            return view('ajax_message_modal', [
              'title' => lang('App.registration_code'),
              'body'  => lang('Security.disallowedAction')
            ]);
        }

        return view('ajax_message_modal', [
            'title' => lang('App.registration_code'),
            'body'  => view('class/reg_code_modal', ['class' => $class]),
        ]);
    }
}
