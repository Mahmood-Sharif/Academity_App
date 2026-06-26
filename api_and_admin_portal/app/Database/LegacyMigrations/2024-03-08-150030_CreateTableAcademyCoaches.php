<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateTableAcademyCoaches extends Migration
{
    public function up(): void
    {
        $this->forge->addField([
             'academy_id' => ['type' => 'INT', 'unsigned' => true],
             'coach_id'   => ['type' => 'INT', 'unsigned' => true],
        ]);
        $this->forge->addForeignKey('academy_id', 'academies', 'academy_id');
        $this->forge->addForeignKey('coach_id', 'users', 'id');
        $this->forge->addPrimaryKey(['academy_id', 'coach_id']);
        $this->forge->createTable('academy_coaches');
    }

    public function down(): void
    {
        $this->forge->dropTable('academy_coaches');
    }
}
