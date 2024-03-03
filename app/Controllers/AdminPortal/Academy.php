<?php

namespace App\Controllers\AdminPortal;

use App\Models\AcademyModel;
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

        if (!$academy) {
            return view('errors/html/error_404', [
              'message' => lang('App.not_found.academy')
            ]);
        }

        return view('academy/academy', ['academy' => $academy]);
    }

    // show edit form
    public function edit($id = null): string
    {
        $academy = $this->model->includeImageUrl()->find($id);

        if (!$academy) {
            return view('errors/html/error_404', [
              'message' => lang('App.not_found.academy')
            ]);
        }

        return view('academy/edit', ['academy' => $academy]);
    }

    // perform update
    public function update($id = null): string
    {
        $data = [
          'name'        => $this->request->getPost('academy_name'),
          'phone'       => $this->request->getPost('academy_phone'),
          'location'    => $this->request->getPost('academy_location'),
          'description' => $this->request->getPost('academy_description'),
        ];

        $result = $this->model->update($id, $data);
        if ($result) {
            session()->setFlashdata('message', lang('App.academy_update.success'));
        } else {
            session()->setFlashdata('error', lang('App.academy_update.error'));
        }

        $academy = $this->model->includeImageUrl()->find($id);
        return view('academy/academy', ['academy' => $academy]);
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
            return view('academy/ajax_message_modal', [
              'title' => lang('App.delete_academy'),
              'body'  => lang('Security.disallowedAction')
            ]);
        }

        /* @var string $error */ $error;
        $result = false;
        if ($this->request->getVar('academyNameConfirm') !== $academy->name) {
            // user didn't confirm academy name correctly
            $error = lang('App.delete_academy.name_error');
        } else {
            $result = $this->model->delete($id);
            $error = lang('App.delete_academy.error');
        }

        if ($result) {
            return view('academy/ajax_message_modal', [
              'title'     => lang('App.delete_academy'),
              'body'      => lang('App.delete_academy.success', [$academy->name]),
              'action'    => lang('App.back.academies'),
              'actionUrl' => url_to('AdminPortal\Academy::index'),
            ]);
        } else {
            return view('academy/ajax_message_modal', [
              'title' => lang('App.delete_academy'),
              'body'  => $error,
            ]);
        }
    }
}
