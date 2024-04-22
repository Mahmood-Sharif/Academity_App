<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class FixCoachesForeignKey extends Migration
{
    public function up(): void
    {
        // Why TH did this happen?
        $this->forge->dropForeignKey('academy_coaches', 'academy_coaches_academy_id_foreign');
        $this->forge->addForeignKey('academy_id', 'academies', 'academy_id');
        $this->forge->processIndexes('academy_coaches');
    }

    public function down(): void
    {
    }
}
