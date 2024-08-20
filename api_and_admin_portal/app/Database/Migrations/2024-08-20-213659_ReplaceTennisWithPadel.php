<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class ReplaceTennisWithPadel extends Migration
{
    public function up()
    {
        $this->db->table('sports')->update(['name' => 'Swimming'], ['sport_id' => 3]);
        $this->db->table('sports')->update(['name' => 'Padel'], ['sport_id' => 6]);
        $this->db->table('media')->update(['url' => 'images/Padel.jpg'], ['media_id' => 6]);
    }

    public function down()
    {
        //
    }
}
