<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddProfileImageColumn extends Migration
{
    public function up(): void
    {
        $this->forge->addColumn('users', [
            'profile_image' => ['type' => 'INT', 'unsigned' => true, 'null' => true],
        ]);
        $this->forge->addForeignKey('profile_image', 'media', 'media_id');
        $this->forge->processIndexes('users');
    }

    public function down(): void
    {
        $this->forge->dropColumn('users', 'profile_image');
    }
}
