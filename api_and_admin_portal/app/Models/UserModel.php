<?php

namespace App\Models;

use CodeIgniter\Shield\Models\UserModel as CodeIgniterUserModel;

class UserModel extends CodeIgniterUserModel
{
    protected $returnType = \App\Entities\User::class;

    protected function initialize(): void
    {
        parent::initialize();

        $this->allowedFields = [
          ...$this->allowedFields,
          'first_name',
          'last_name',
          'dob',
          'phone',
        ];
    }

}
