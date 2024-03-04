<?php

namespace App\Database\Seeds;

use App\Entities\User;
use App\Models\EnrollmentModel;
use CodeIgniter\Database\Seeder;

class EnrollmentsSeeder extends Seeder
{
    public function run(): void
    {
        $users = auth()->getProvider();

        $user1 = new User([
          'username' => null,
          'email'    => '',
          'password' => '',
          'name'     => 'Wld Mahmood',
          'dob'      => '2014-01-01',
          'gender'   => 'Male',
          'phone'    => '33333333',
        ]);
        $users->save($user1);
        $user1 = $users->findById($users->getInsertID());
        $user1->addGroup('user');

        $user2 = new User([
          'username' => null,
          'email'    => '',
          'password' => '',
          'name'     => 'Bnt Mahmood',
          'dob'      => '2014-01-01',
          'gender'   => 'Female',
          'phone'    => '33333333',
        ]);
        $users->save($user2);
        $user2 = $users->findById($users->getInsertID());
        $user2->addGroup('user');

        $model = new EnrollmentModel();
        $model->insertBatch([
            [
                'start_date' => '2024-02-12',
                'end_date'   => '2024-04-15',
                'student_id' => 1,
                'class_id' => 1,
            ],
            [
                'start_date' => '2024-02-12',
                'end_date'   => '2024-04-15',
                'student_id' => 1,
                'class_id' => 3,
            ],

            [
                'start_date' => '2024-02-12',
                'end_date'   => '2024-04-15',
                'student_id' => $user1->id,
                'class_id' => 1,
            ],
            [
                'start_date' => '2024-02-12',
                'end_date'   => '2024-04-15',
                'student_id' => $user1->id,
                'class_id' => 5,
            ],

            [
                'start_date' => '2024-02-12',
                'end_date'   => '2024-04-15',
                'student_id' => $user2->id,
                'class_id' => 2,
            ],

        ]);

    }
}
