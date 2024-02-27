<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;
use Exception;

class DropUsersTable extends Migration
{
    public function up()
    {
        $this->forge->dropTable('users');
    }

    public function down()
    {
        throw new Exception("Not Implemented", 1);
    }
}
