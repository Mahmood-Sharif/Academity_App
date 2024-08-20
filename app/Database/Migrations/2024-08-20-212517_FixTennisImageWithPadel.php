<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class FixTennisImageWithPadel extends Migration
{
    public function up()
    {
        $this->db->table('media')->update(['url' => 'images/Padel.jpg'], ['media_id' => 6]);
    }

    public function down()
    {
        //
    }
}
