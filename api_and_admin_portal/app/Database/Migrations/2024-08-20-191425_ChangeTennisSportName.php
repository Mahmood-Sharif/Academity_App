<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddPadelToSportsAndMedia extends Migration
{
    public function up()
    {
        $this->db->table('sports')->update(['name' => 'Padel'], ['sport_id' => 3]);
    }

    public function down()
    {
        //
    }
}
