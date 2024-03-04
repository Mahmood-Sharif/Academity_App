<?php

namespace App\Database\Seeds;

use App\Models\AcademyModel;
use CodeIgniter\Database\Seeder;

class AcademySeeder extends Seeder
{
    public function run(): void
    {
        $academy = new AcademyModel();
        $academy->insertBatch(
            [
                [
                    'academy_id'  => 1,
                    'name'        => 'BasketStars Academy',
                    'description' => '🏀 Welcome to BasketStars Academy in Isa Town! 📍 We are a basketball academy dedicated to nurturing the skills of aspiring players. 🌟 #BasketStarsAcademy🏀💫',
                    'location'    => 'Isa Town',
                    'phone'       => '34563456',
                    'media_id'    => 1,
                    'owner_id'    => 3,
                    'sport_id'    => 1
                ],
                [
                    'academy_id'  => 2,
                    'name'        => 'SoccerStars Academy',
                    'description' => '⚽ Welcome to SoccerStars Academy in Isa Town! 📍 We are a premier soccer academy focused on developing the skills of passionate players. ⚽🌟 #SoccerStarsAcademy⚽💫',
                    'location'    => 'Isa Town',
                    'phone'       => '34563456',
                    'media_id'    => 4,
                    'owner_id'    => 3,
                    'sport_id'    => 4
                ],
                [
                    'academy_id'  => 3,
                    'name'        => 'The Ring Academy',
                    'description' => '🥊 Welcome to The Ring Academy for Boxing in Manama! 📍 We are a top-notch boxing academy dedicated to teaching the art of boxing to enthusiasts of all ages and skill levels. 🥋💪 #TheRingAcademy🥊💫',
                    'location'    => 'Manama',
                    'phone'       => '37893789',
                    'media_id'    => 2,
                    'owner_id'    => 4,
                    'sport_id'    => 2
                ]
            ]
        );
    }
}
