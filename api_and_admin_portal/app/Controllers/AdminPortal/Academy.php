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
        $academy = $this->model->includeImageUrl()->find($id);
        $academy->num_classes = $this->model->getStatistics($id);
        return view('academy/academy', ['academy' => $academy]);
    }

    public function edit($id = null): string
    {
        $academy = $this->model->includeImageUrl()->find($id);
        return view('academy/edit', ['academy' => $academy]);
    }

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
}
