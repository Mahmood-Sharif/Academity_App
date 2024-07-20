<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class ChangeFencingSportName extends Migration
{
    public function up()
    {
        $this->db->table('sports')->update('Swimming', 3);
    }

    public function down()
    {
        //
    }
}
