<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class ReplaceTennisImageWithPadel extends Migration
{
    public function up()
    {
        $this->db->table('media')->update(['url' => 'images/Tennis.jpg'], ['sport_id' => 6]);
    }

    public function down()
    {
        //
    }
}
