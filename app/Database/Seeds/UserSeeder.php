<?php

namespace App\Database\Seeds;

use App\Entities\User;
use CodeIgniter\Database\Seeder;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $users = auth()->getProvider();

        // normal user
        $user = new User([
          'username' => null,
          'email' => 'm',
          'password' => '1',
          'first_name' => 'Mahmood',
          'last_name' => 'AlMahmood',
          'dob' => '2024-01-01',
          'phone' => 33333333,
        ]);
        $users->save($user);
        $user = $users->findById($users->getInsertID());
        $user->addGroup('user');

        // coach user
        $user = new User([
          'username' => null,
          'email' => 'coach',
          'password' => '1',
          'first_name' => 'Coach',
          'last_name' => 'Ali',
          'dob' => '1970-01-01',
          'phone' => 33334444,
        ]);
        $users->save($user);
        $user = $users->findById($users->getInsertID());
        $user->addGroup('user', 'coach');

        // super admin
        $user = new User([
          'username' => null,
          'email' => 'admin@academity.com',
          'password' => 'aoeAOE123',
          'first_name' => 'Ameen',
          'last_name' => 'Al Admin',
          'dob' => '2024-01-01',
          'phone' => 33335555,
        ]);
        $users->save($user);
        $user = $users->findById($users->getInsertID());
        $user->addGroup('superadmin', 'admin', 'developer', 'user', 'coach');
    }
}
