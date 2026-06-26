<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateGalleryTable extends Migration
{
    public function up(): void
    {
        $this->forge->addField([
            'academy_id' => ['type' => 'INT', 'unsigned' => true, 'null' => false],
            'media_id' => ['type' => 'INT', 'unsigned' => true, 'null' => false],
            'index' => ['type' => 'INT', 'unsigned' => true, 'null' => false, 'default' => 0],
        ]);
        $this->forge->addPrimaryKey(['academy_id', 'media_id']);
        $this->forge->addForeignKey('academy_id', 'academies', 'academy_id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('media_id', 'media', 'media_id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('gallery');
    }

    public function down(): void
    {
        $this->forge->dropTable('gallery');
    }
}
