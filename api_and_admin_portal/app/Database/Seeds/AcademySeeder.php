<?php

namespace App\Database\Seeds;

use App\Models\AcademyModel;
use App\Models\MediaModel;
use App\Models\AcademyModelModel;
use App\Models\OwnerModel;
use CodeIgniter\Database\Seeder;

class AcademySeeder extends Seeder
{
    public function run()
    {
        // inserted in sports seeder, id = 1
        // $mediaModel = new MediaModel();
        // $mediaModel->insert([
        //     ['mime_type' => 'image/jpeg', 'url' => 'images/Academy.jpg'],
        // ]);



        $academy = new AcademyModel();
        $academy->insertBatch(
            [
                [
                    'name' => 'Basketball Academy',
                    'media_id' => 1,
                    'owner_id' => 3,
                    'sport_id' => 1
                ],
                [
                    'name' => 'Football Academy',
                    'media_id' => 1,
                    'owner_id' => 3,
                    'sport_id' => 4
                ]
            ]
        );
    }
}
