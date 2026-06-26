<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddRegistrationCodeColumn extends Migration
{
    public function up(): void
    {
        $this->forge->addColumn('classes', [
           'reg_code' => [
                'type'       => 'VARCHAR',
                'constraint' => '10',
                'unique'     => true,
                'null'       => false,
           ]
        ]);

    }

    public function down(): void
    {
        $this->forge->dropColumn('classes', 'reg_code');
    }
}
