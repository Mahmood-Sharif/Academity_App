<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateSportsTable extends Migration
{
    public function up(): void
    {
        $this->forge->addField([
          'sport_id' => ['type' => 'INT', 'unsigned' => true, 'auto_increment' => true],
          'name' => ['type' => 'VARCHAR', 'constraint' => '100'],
          'media_id' => ['type' => 'INT', 'unsigned' => true],
        ]); 
        $this->forge->addPrimaryKey('sport_id');
        $this->forge->addForeignKey('media_id', 'media', 'media_id');
        $this->forge->createTable('sports');
    }

    public function down(): void
    {
        $this->forge->dropTable('sports');
    }
}
