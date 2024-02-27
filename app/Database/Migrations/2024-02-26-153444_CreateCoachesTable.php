<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateCoachesTable extends Migration
{
    public function up(): void
    {
        $this->forge->addField([
          'coach_id' => ['type' => 'INT', 'unsigned' => true, 'auto_increment' => true],
          'name' => ['type' => 'VARCHAR', 'constraint' => '100'],
        ]);
        $this->forge->addPrimaryKey('coach_id');
        $this->forge->createTable('coaches');
    }

    public function down(): void
    {
        $this->forge->dropTable('coaches');
    }
}
