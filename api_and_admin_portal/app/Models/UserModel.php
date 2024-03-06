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

          'name',
          'dob',
          'phone',

          // student fields
          'gender',
          'medical_condition',
          'parent_id',
        ];
    }

}
