<?php

namespace App\Controllers\AdminPortal;

use App\Controllers\BaseController;

class Home extends BaseController
{
    public function index(): string
    {
        return view('welcome_message');
    }
}
