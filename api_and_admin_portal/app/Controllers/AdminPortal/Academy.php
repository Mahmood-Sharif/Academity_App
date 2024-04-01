<?php

namespace App\Controllers\AdminPortal;

use App\Controllers\BaseController;
use App\Entities\Academy as AppAcademy;
use App\Models\AcademyModel;
use App\Models\SportModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourcePresenter;

class Academy extends ResourcePresenter
{
    protected $modelName = '\App\Models\AcademyModel';
    /* @var AcademyModel $model */
    protected $model;

    public function index(): string
    {
        $academies = $this->model->findAcademiesForOwner(auth()->id());
        return view('academy/academies', ['academies' => $academies]);
    }

    public function show($id = null): string
    {
        $academy = $this->model
                        ->includeImageUrl()
                        ->includeStatistics($id)
                        ->find($id);

        if (! auth()->user()->can('academies.access') || auth()->id() !== $academy?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        return view('academy/academy', ['academy' => $academy]);
    }

    // show edit form
    public function edit($id = null): string
    {
        $academy = $this->model->includeImageUrl()->find($id);

        if (! auth()->user()->can('academies.edit') || auth()->id() != $academy?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $sports = key_array(fn ($s) => [$s->sport_id, $s->name], (new SportModel())->findAll());

        return view('academy/create_edit', [
          'type' => 'edit',
          'academy' => $academy,
          'sports' => $sports,
          'errors' => [],
        ]);
    }

    // perform update
    public function update($id = null): ResponseInterface|string
    {
        $academy = $this->model->includeImageUrl()->find($id);
        if (! auth()->user()->can('academies.edit') || auth()->id() != $academy->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        if (! $this->validate([
          ...$this->model->validationRules,
          'image' => 'max_size[image,2048]|mime_in[image,image/png,image/jpeg,image/webp]',
        ], $this->model->validationMessages)) {
            $sports = key_array(fn ($s) => [$s->sport_id, $s->name], (new SportModel())->findAll());

            return view('academy/create_edit', [
              'type' => 'edit',
              'academy' => $academy,
              'sports' => $sports,
              'errors' => $this->validator->getErrors(),
            ]);
        }

        $editedAcademy = new AppAcademy($this->validator->getValidated());

        if (isset($_FILES['image']) && !empty($_FILES['image']['name'])) {
            $uploadedFile = $this->request->getFile('image');
            $upload = BaseController::uploadMedia($uploadedFile);
            $sports = key_array(fn ($s) => [$s->sport_id, $s->name], (new SportModel())->findAll());
            if (array_key_exists('errors', $upload)) {
                return view('academy/create_edit', [
                    'type' => 'edit',
                    'academy' => $academy,
                    'errors' => ['image' => $upload['errors']],
                    'sports' => (new SportModel())->findAll(),
                ]);
            }

            ['media_id' => $mediaId] = $upload;
            $editedAcademy->media_id = $mediaId;

        }

        $result = $this->model->update($id, $editedAcademy->toArray());
        $flashData = [];
        if ($result) {
            $flashData = ['message', lang('App.academy_update.success')];
        } else {
            $flashData = ['error', lang('App.academy_update.error')];
        }

        return redirect()->route('AdminPortal\Academy::show', [$id])->with(...$flashData);
    }

    /** AJAX remove confirm modal */
    public function remove($id = null): string
    {
        $academy = $this->model->find($id);
        if (auth()->user()->can('academies.delete') && $academy->owner_id === auth()->user()->id) {
            return view('academy/ajax_remove_modal', [
              'error'   => false,
              'academy' => $academy
            ]);
        } else {
            return view('academy/ajax_remove_modal', [
              'error' => lang('Security.disallowedAction')
            ]);
        }
    }

    /** AJAX delete and respond with modal */
    public function delete($id = null): string
    {
        $academy = $this->model->find($id);

        if (!auth()->user()->can('academies.delete') || $academy->owner_id !== auth()->user()->id) {
            // User can not delete academies or academy is not owned by user
            return view('ajax_message_modal', [
              'title' => lang('App.delete_academy'),
              'body'  => lang('Security.disallowedAction')
            ]);
        }

        /* @var string $error */ $error;
        $result = false;
        if ($this->request->getPost('academyNameConfirm') !== $academy->name) {
            // user didn't confirm academy name correctly
            $error = lang('App.delete_academy.name_error');
        } else {
            $result = $this->model->delete($id);
            $error = lang('App.delete_academy.error');
        }

        if ($result) {
            return view('ajax_message_modal', [
              'title'     => lang('App.delete_academy'),
              'body'      => lang('App.delete_academy.success', [$academy->name]),
              'action'    => lang('App.back.academies'),
              'actionUrl' => url_to('AdminPortal\Academy::index'),
            ]);
        } else {
            return view('ajax_message_modal', [
              'title' => lang('App.delete_academy'),
              'body'  => $error,
            ]);
        }
    }

    // show create form
    public function new(): string
    {
        if (!auth()->user()->can('academies.create')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $sports = key_array(fn ($s) => [$s->sport_id, $s->name], (new SportModel())->findAll());

        return view('academy/create_edit', [
          'type' => 'create' ,
          'sports' => [0 => lang('App.academy_sport.select'), ...$sports],
          'errors' => [],
        ]);
    }

    // perform create
    public function create(): ResponseInterface|string
    {
        if (! auth()->user()->can('academies.create')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $sports = key_array(fn ($s) => [$s->sport_id, $s->name], (new SportModel())->findAll());

        if (! $this->validate([
          ...$this->model->validationRules,
          'image' => 'uploaded[image]|max_size[image,2048]|mime_in[image,image/png,image/jpeg,image/webp]',
        ], $this->model->validationMessages)) {
            return view('academy/create_edit', [
                'type' => 'create',
                'errors' => $this->validator->getErrors(),
                'sports' => [0 => lang('App.academy_sport.select'), ...$sports],
            ]);
        }

        $academy = new AppAcademy($this->validator->getValidated());

        $upload = BaseController::uploadMedia($this->request->getFile('image'));

        if (array_key_exists('errors', $upload)) {
            return view('academy/create_edit', [
                'type' => 'create',
                'errors' => ['image' => $upload['errors']],
                'sports' => (new SportModel())->findAll(),
            ]);
        }

        ['media_id' => $mediaId] = $upload;

        $data = $academy->toArray();
        $data['owner_id'] = auth()->user()->id;
        $data['media_id'] = $mediaId;

        $insertId =  $this->model->insert($data, true);

        return redirect()->route('AdminPortal\Academy::show', [$insertId]);

    }
}
