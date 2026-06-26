<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CascadeForeignKeyConstraints extends Migration
{
    public function up(): void
    {
        $this->forge->dropForeignKey('class_timings', 'class_timings_class_id_foreign');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'RESTRICT', 'CASCADE');
        $this->forge->processIndexes('class_timings');

        $this->forge->dropForeignKey('enrollments', 'enrollments_class_id_foreign');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'RESTRICT', 'CASCADE');
        $this->forge->processIndexes('enrollments');

        $this->forge->dropForeignKey('offer_classes', 'offer_classes_class_id_foreign');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'RESTRICT', 'CASCADE');
        $this->forge->processIndexes('offer_classes');

        $this->forge->dropForeignKey('academy_coaches', 'academy_coaches_academy_id_foreign');
        $this->forge->addForeignKey('academy_id', 'academies', 'academy_id', 'RESTRICT', 'CASCADE');
        $this->forge->processIndexes('academy_coaches');
    }

    public function down(): void
    {
    }
}
