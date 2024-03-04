<?php

namespace App\Database\Seeds;

use App\Entities\ClassTiming;
use App\Models\ClassModel;
use App\Models\ClassTimingModel;
use App\Models\PriceModel;
use CodeIgniter\Database\Seeder;

class ClassSeeder extends Seeder
{
    public function run()
    {
        // inserted in sports seeder, id = 1
        // $mediaModel = new MediaModel();
        // $mediaModel->insert([
        //     ['mime_type' => 'image/jpeg', 'url' => 'images/Academy.jpg'],
        // ]);



        $class = new ClassModel();
        $class->insertBatch(
            [
                [
                    'class_id' => 1,
                    'class_name' => 'U16 Class',
                    'min_age' => 12,
                    'max_age' => 16,
                    'academy_id' => 4
                ],
                [
                    'class_id' => 2,
                    'class_name' => 'U112 Class',
                    'min_age' => 18,
                    'max_age' => 12,
                    'academy_id' => 4
                ]
            ]
        );

        $price = new PriceModel();
        $price->insertBatch(
            [
                [
                    'price' => '40.0',
                    'class_id' => '1',
                    'start_time' => '2024-12-10 10:10:10',
                ],
                [
                    'price' => '30.0',
                    'class_id' => '2',
                    'start_time' => '2020-12-10 10:10:10',
                ]
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
                ]
            ]
        );
    }
}
