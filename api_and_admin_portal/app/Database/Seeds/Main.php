<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class Main extends Seeder
{
    public function run(): void
    {
        $this->call('UserSeeder');
        $this->call('SportsSeeder');
        $this->call('AcademySeeder');
        $this->call('ClassSeeder');
        $this->call('EnrollmentsSeeder');
    }
}
