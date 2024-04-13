<?php

namespace App\Entities;

use CodeIgniter\Shield\Entities\User as CodeIgniterUser;

class User extends CodeIgniterUser
{
    protected $casts = [
      'id'            => '?integer',
      'active'        => 'int_bool',
      'permissions'   => 'array',
      'groups'        => 'array',
      // 'dob'           => 'datetime',
      'profile_image' => '?integer',

      // joined attributes
      'enrollment_id' => 'integer',
      'class_id'      => 'integer',
      'student_id'    => 'integer',
    ];

}
