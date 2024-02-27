<?php

namespace App\Database\Seeds;

use App\Models\MediaModel;
use App\Models\SportModel;
use CodeIgniter\Database\Seeder;

class SportsSeeder extends Seeder
{
    public function run()
    {
        $mediaModel = new MediaModel();
        $mediaModel->insertBatch([
            ['mime_type' => 'image/jpeg', 'url' => 'images/Academy.jpg'],
            ['mime_type' => 'image/jpeg', 'url' => 'images/Basketball.jpg'],
            ['mime_type' => 'image/jpeg', 'url' => 'images/Boxing.jpg'],
            ['mime_type' => 'image/jpeg', 'url' => 'images/Fencing.jpg'],
            ['mime_type' => 'image/jpeg', 'url' => 'images/Football.jpg'],
            ['mime_type' => 'image/jpeg', 'url' => 'images/Taekowndo.jpg'],
            ['mime_type' => 'image/jpeg', 'url' => 'images/Tennis.jpg'],

        ]);

        $sports = new SportModel();
        $sports->insertBatch([
            ['name' => 'Basketball', 'media_id' => 2],
            ['name' => 'Boxing', 'media_id' => 3],
            ['name' => 'Fencing', 'media_id' => 4],
            ['name' => 'Football', 'media_id' => 5],
            ['name' => 'Taekowndo', 'media_id' => 6],
            ['name' => 'Tennis', 'media_id' => 7],
        ]);
    }
}
