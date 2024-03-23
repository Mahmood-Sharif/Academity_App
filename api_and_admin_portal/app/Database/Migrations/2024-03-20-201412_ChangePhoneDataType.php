<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class ChangePhoneDataType extends Migration
{
    public function up(): void
    {
        $this->forge->modifyColumn('users', ['phone' => [
            'type' => 'VARCHAR',
            'constraint' => '15',
            'null' => false,
        ]]);
    }

    public function down(): void
    {
        //
    }
}
