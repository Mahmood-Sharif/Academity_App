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
        return view('academy/academy', ['academy' => $academy]);
    }
}
