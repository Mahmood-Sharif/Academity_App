<?php

namespace App\Controllers\AdminPortal;

use App\Models\ClassModel;
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

        return view('class/create_edit', [
          'type' => 'edit',
          'class' => $class,
          'coaches' => key_array(fn ($coach) => [$coach->id, $coach->name], $coaches),
          'errors' => [],
        ]);
    }

    // perform update
    public function update($id = null): ResponseInterface|string
    {
        $class = $this->model->find($id);
        if (! auth()->user()->can('classes.edit') || auth()->id() != $class?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $result = $this->model->update($id, $this->validator->getValidated());
        $flashData = [];
        if ($result) {
            $flashData = ['message', lang('App.class_update.success')];
        } else {
            $flashData = ['error', lang('App.class_update.error')];
        }

        return redirect()->route('AdminPortal\class::show', [$id])->with(...$flashData);
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
