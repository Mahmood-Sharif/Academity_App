<?php

namespace App\Controllers\AdminPortal;

use App\Controllers\BaseController;

class Controller extends BaseController
{
    public function dashboard(): string
    {
        return view('dashboard');
    }

}
