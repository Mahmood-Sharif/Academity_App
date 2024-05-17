<?php

namespace App\Database\Seeds;

use App\Models\MediaModel;
use App\Models\SportModel;
use CodeIgniter\Database\Seeder;

class SportsSeeder extends Seeder
{
    public function run(): void
    {
        $mediaModel = new MediaModel();
        $mediaModel->insertBatch([
            ['media_id' => 1, 'mime_type' => 'image/jpeg', 'url' => 'images/Basketball.jpg'],
            ['media_id' => 2, 'mime_type' => 'image/jpeg', 'url' => 'images/Boxing.jpg'],
            ['media_id' => 3, 'mime_type' => 'image/jpeg', 'url' => 'images/Fencing.jpg'],
            ['media_id' => 4, 'mime_type' => 'image/jpeg', 'url' => 'images/Football.jpg'],
            ['media_id' => 5, 'mime_type' => 'image/jpeg', 'url' => 'images/Taekwondo.jpg'],
            ['media_id' => 6, 'mime_type' => 'image/jpeg', 'url' => 'images/Tennis.jpg'],
        ]);

        $sports = new SportModel();
        $sports->insertBatch([
            ['sport_id' => 1, 'name' => 'Basketball', 'media_id' => 1],
            ['sport_id' => 2, 'name' => 'Boxing',     'media_id' => 2],
            ['sport_id' => 3, 'name' => 'Swimming',   'media_id' => 3],
            ['sport_id' => 4, 'name' => 'Football',   'media_id' => 4],
            ['sport_id' => 5, 'name' => 'Taekwondo',  'media_id' => 5],
            ['sport_id' => 6, 'name' => 'Tennis',     'media_id' => 6],
        ]);
    }
}
