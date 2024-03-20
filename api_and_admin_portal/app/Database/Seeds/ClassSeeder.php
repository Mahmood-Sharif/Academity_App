<?php

namespace App\Database\Seeds;

use App\Models\ClassModel;
use App\Models\ClassTimingModel;
use App\Models\PriceModel;
use CodeIgniter\Database\Seeder;

class ClassSeeder extends Seeder
{
    public function run(): void
    {
        $classModel = new ClassModel();
        $classModel->insertBatch(
            [
                [
                    'class_id'     => 1,
                    'class_name'   => 'U16 Class',
                    'min_age'      => 12,
                    'max_age'      => 16,
                    'academy_id'   => 1,
                    'max_capacity' => 20,
                    'min_duration' => 8,
                    'max_duration' => 8,
                    'coach_id'     => 2,
                    'reg_code'     => ClassModel::generateRegCode(),
                ],
                [
                    'class_id'     => 2,
                    'class_name'   => 'U12 Class',
                    'min_age'      => 8,
                    'max_age'      => 12,
                    'academy_id'   => 1,
                    'max_capacity' => 20,
                    'min_duration' => 8,
                    'max_duration' => 8,
                    'coach_id'     => 2,
                    'reg_code'     => ClassModel::generateRegCode(),
                ],
                [
                    'class_id'     => 3,
                    'class_name'   => 'U12 Class',
                    'min_age'      => 8,
                    'max_age'      => 12,
                    'academy_id'   => 2,
                    'max_capacity' => 20,
                    'min_duration' => 8,
                    'max_duration' => 8,
                    'coach_id'     => 3,
                    'reg_code'     => ClassModel::generateRegCode(),
                ],
                [
                    'class_id'     => 4,
                    'class_name'   => 'U12 Class',
                    'min_age'      => 8,
                    'max_age'      => 12,
                    'academy_id'   => 2,
                    'max_capacity' => 20,
                    'min_duration' => 8,
                    'max_duration' => 8,
                    'coach_id'     => 3,
                    'reg_code'     => ClassModel::generateRegCode(),
                ],
                [
                    'class_id'     => 5,
                    'class_name'   => 'U12 Class',
                    'min_age'      => 8,
                    'max_age'      => 12,
                    'academy_id'   => 3,
                    'max_capacity' => 20,
                    'min_duration' => 8,
                    'max_duration' => 8,
                    'coach_id'     => 4,
                    'reg_code'     => ClassModel::generateRegCode(),
                ],
            ]
        );

        $classModel->db->table('academy_coaches')->insertBatch([
            ['academy_id' => 1, 'coach_id' => 2],
            ['academy_id' => 2, 'coach_id' => 3],
            ['academy_id' => 3, 'coach_id' => 4],
        ]);

        $priceModel = new PriceModel();
        $priceModel->insertBatch(
            [
                [
                    'class_id'   => 1,
                    'price'      => '40.0',
                    'start_time' => '2024-02-10 10:10:10',
                    'end_time'   => null,
                ],
                [
                    'class_id'   => 2,
                    'price'      => '30.0',
                    'start_time' => '2020-02-10 10:10:10',
                    'end_time'   => null,
                ],
                [
                    'class_id'   => 3,
                    'price'      => '30.0',
                    'start_time' => '2020-02-10 10:10:10',
                    'end_time'   => null,
                ],
                [
                    'class_id'   => 4,
                    'price'      => '50.0',
                    'start_time' => '2020-02-10 10:10:10',
                    'end_time'   => '2020-02-12 10:10:10',
                ],
                [
                    'class_id'   => 4,
                    'price'      => '30.0',
                    'start_time' => '2020-02-12 10:10:10',
                    'end_time'   => null,
                ],
            ]
        );


        $time = new ClassTimingModel();
        $time->insertBatch(
            [
                [
                    'class_id' => 1,
                    'day_of_week' => 'SUN',
                    'start_time' => '5:30',
                    'end_time' => '7:00',
                ],
                [
                    'class_id' => 1,
                    'day_of_week' => 'TUE',
                    'start_time' => '4:30',
                    'end_time' => '6:00',
                ],
                [
                    'class_id' => 2,
                    'day_of_week' => 'WED',
                    'start_time' => '5:30',
                    'end_time' => '7:00',
                ],
                [
                    'class_id' => 2,
                    'day_of_week' => 'TUE',
                    'start_time' => '4:30',
                    'end_time' => '6:00',
                ],
                [
                    'class_id' => 3,
                    'day_of_week' => 'WED',
                    'start_time' => '5:30',
                    'end_time' => '7:00',
                ],
                [
                    'class_id' => 3,
                    'day_of_week' => 'MON',
                    'start_time' => '4:30',
                    'end_time' => '6:00',
                ],
                [
                    'class_id' => 4,
                    'day_of_week' => 'SUN',
                    'start_time' => '5:30',
                    'end_time' => '7:00',
                ],
                [
                    'class_id' => 4,
                    'day_of_week' => 'THU',
                    'start_time' => '4:30',
                    'end_time' => '6:00',
                ],
            ]
        );
    }
}
