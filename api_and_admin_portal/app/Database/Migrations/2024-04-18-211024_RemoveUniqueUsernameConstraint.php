<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class RemoveUniqueUsernameConstraint extends Migration
{
    public function up(): void
    {
        // $this->forge->dropKey('users', 'username');
    }

    public function down(): void
    {
    }
}
