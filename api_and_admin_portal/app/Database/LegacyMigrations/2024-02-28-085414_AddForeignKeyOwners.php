<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddForeignKeyOwners extends Migration
{
    public function up(): void
    {
        $this->forge->addForeignKey('owner_id', 'users', 'id');
        $this->forge->processIndexes('academies');
        $this->forge->addForeignKey('student_id', 'users', 'id');
        $this->forge->processIndexes('enrollments');
    }

    public function down(): void
    {
        $this->forge->dropForeignKey('academies', 'academies_owner_id_foreign');
        $this->forge->dropForeignKey('enrollments', 'enrollments_student_id_foreign');
    }
}
