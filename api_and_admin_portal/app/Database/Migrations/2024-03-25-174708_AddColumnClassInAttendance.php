<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddColumnClassInAttendance extends Migration
{
    public function up(): void
    {
        $this->forge->addColumn('attendance', [
            'class_id' => ['type' => 'INT', 'unsigned' => true, 'null' => true]
        ]);
        $this->forge->addForeignKey('class_id', 'classes', 'class_id');
        $this->forge->processIndexes('attendance');
    }

    public function down(): void
    {
        $this->forge->dropColumn('attendance', 'class_id');
    }
}
