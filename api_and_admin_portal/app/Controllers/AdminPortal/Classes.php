<?php

namespace App\Controllers\AdminPortal;

use App\Entities\ClassEntity;
use App\Models\ClassModel;
use App\Models\ClassTimingModel;
use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourcePresenter;
use Exception;

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
        return view('class/classes', ['classes' => $classes->findAll()]);
    }

    public function show($id = null): string
    {
        $class = $this->model->includeOwnerId()->find($id);

        if (! auth()->user()->can('classes.access') || auth()->id() != $class?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        return view('class/class', ['class' => $class]);
    }

    // show edit form
    public function edit($id = null): string
    {
        $class = $this->model->includeOwnerId()->find($id);

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
        $class = $this->model->includeOwnerId()->find($id);
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

        // TODO: update price

        $result = $result && $this->model->update($id, $editedClass);
        $flashData = [];
        if ($result) {
            $flashData = ['message', lang('App.class_update.success')];
        } else {
            $flashData = ['error', lang('App.class_update.error')];
        }

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

        return view('class/create_edit', [
          'type' => 'create' ,
          'coaches' => key_array(fn ($coach) => [$coach->id, $coach->name], $coaches),
          'errors' => [],
        ]);
    }

    // perform create
    public function create(): ResponseInterface|string
    {
        throw new Exception("Not Implemented", 1);
    }
}
