<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;
use CodeIgniter\Database\RawSql;

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
                'default'    => new RawSql('(UUID())'),
           ]
        ]);

        $this->forge->modifyColumn('classes', [
           'reg_code' => [
                'type'       => 'VARCHAR',
                'constraint' => '10',
                'null'       => false,
           ]
        ]);

        $this->forge->modifyColumn('prices', [
           'price' => [
                'type'       => 'DECIMAL',
                'constraint' => '10,3',
                'null'       => false,
           ]
        ]);
    }

    public function down(): void
    {
        $this->forge->dropColumn('classes', 'reg_code');
    }
}
