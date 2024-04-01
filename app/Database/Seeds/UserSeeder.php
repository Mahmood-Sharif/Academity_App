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
          'email'    => 'm',
          'password' => '1',
          'name'     => 'Mahmood Al-Mahmood',
          'dob'      => '2024-01-01',
          'gender'   => 'Male',
          'phone'    => '33333333',
        ]);
        $users->save($user);
        $user = $users->findById($users->getInsertID());
        $user->addGroup('user');

        // coach user
        $user = new User([
          'username' => null,
          'email'    => 'coach@coach.com',
          'password' => 'asdasd123',
          'name'     => 'Coach Ali',
          'dob'      => '1990-01-01',
          'gender'   => 'Male',
          'phone'    => '33334444',
        ]);
        $users->save($user);
        $user = $users->findById($users->getInsertID());
        $user->addGroup('user', 'coach');

        // academy owner user
        $user = new User([
          'username' => null,
          'email'    => 'owner@owner.com',
          'password' => 'asdASD123',
          'name'     => 'Anwar Acadi',
          'dob'      => '1980-01-01',
          'gender'   => 'Male',
          'phone'    => '33337777',
        ]);
        $users->save($user);
        $user = $users->findById($users->getInsertID());
        $user->addGroup('user', 'admin');

        // super admin
        $user = new User([
          'username' => null,
          'email'    => 'admin@academity.com',
          'password' => 'asdASD123',
          'name'     => 'Ameen Al Admin',
          'dob'      => '2024-01-01',
          'gender'   => 'Male',
          'phone'    => '33335555',
        ]);
        $users->save($user);
        $user = $users->findById($users->getInsertID());
        $user->addGroup('superadmin', 'admin', 'developer', 'user', 'coach');
    }
}
