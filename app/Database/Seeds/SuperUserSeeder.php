<?php

namespace App\Database\Seeds;

use App\Entities\User;
use CodeIgniter\Database\Seeder;

class SuperUserSeeder extends Seeder
{
    public function run(): void
    {
        $users = auth()->getProvider();
        // seed super admin
        $user = new User([
          'username' => null,
          'email'    => 'admin@academity.com',
          'password' => 'asdASD123',
          'name'     => 'Academity Admin',
          'dob'      => '2024-02-18',
          'gender'   => 'Male',
          'phone'    => '33333333',
        ]);
        $users->save($user);
        $user = $users->findById($users->getInsertID());
        $user->addGroup('superadmin', 'admin', 'developer', 'user', 'coach');
    }
}
