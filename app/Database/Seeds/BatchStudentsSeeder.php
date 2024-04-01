<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;
use CodeIgniter\Test\Fabricator;

class BatchStudentsSeeder extends Seeder
{
    public function run(): void
    {
        $users = auth()->getProvider();

        $fabricator = new Fabricator($users, [
            'name' => 'name',
            'email' => 'email',
            'phone' => 'phoneNumber',
            'dob' => 'date',
        ]);

        for ($i = 0; $i < 100; $i++) {
            $user = $fabricator->make();
            $user->username = null;
            $user->gender = random_int(0, 1) ? 'Male' : 'Female';
            $user->password = '123';

            $users->save($user);
            $user = $users->findById($users->getInsertID());
            $users->addToDefaultGroup($user);
        }

    }
}
