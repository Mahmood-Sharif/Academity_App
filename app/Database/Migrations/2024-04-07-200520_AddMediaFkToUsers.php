<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddMediaFkToUsers extends Migration
{
    public function up()
    {
        // Adding a column for the foreign key in 'users' table
        $this->forge->addColumn('users', [
            'media_id' => [
                'type' => 'INT',
                'unsigned' => true,
                'null' => true,
                'after' => 'parent_id', 
            ],
        ]);

        // Adding a foreign key constraint
        $this->forge->addForeignKey('media_id', 'media', 'media_id', 'CASCADE', 'SET NULL');
    }

    public function down()
    {
        // Dropping the foreign key
        $this->forge->dropForeignKey('users', 'users_media_id_foreign');

        // Removing the column
        $this->forge->dropColumn('users', 'media_id');
    }
}
