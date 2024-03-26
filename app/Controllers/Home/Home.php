<?php

namespace App\Controllers\Home;

use App\Controllers\BaseController;

class Home extends BaseController
{
    public function index(): string
    {
        return view('home/index');
    }
}
