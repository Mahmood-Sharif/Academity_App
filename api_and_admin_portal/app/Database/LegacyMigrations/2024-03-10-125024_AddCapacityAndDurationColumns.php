<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddCapacityAndDurationColumns extends Migration
{
    public function up(): void
    {
        $this->forge->addColumn('classes', [
              'max_capacity' => ['type' => 'int', 'default' => 0],
              'min_duration' => ['type' => 'int', 'default' => 0],
              'max_duration' => ['type' => 'int', 'default' => 0],
        ]);
    }

    public function down(): void
    {
        $this->forge->dropColumn('classes', [
          'max_capacity',
          'min_duration',
          'max_duration'
        ]);
    }
}
