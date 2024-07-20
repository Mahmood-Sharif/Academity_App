<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class ChangeFencingSportName extends Migration
{
    public function up()
    {
        $this->db->table('sports')->update(['name' => 'Swimming'], ['sport_id' => 3]);
    }

    public function down()
    {
        //
    }
}
