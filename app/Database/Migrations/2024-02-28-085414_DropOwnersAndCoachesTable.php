<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class DropOwnersAndCoachesTable extends Migration
{
    public function up()
    {
        $this->forge->dropForeignKey('academies','academies_owner_id_foreign');
        $this->forge->addForeignKey('owner_id', 'users', 'id');
        $this->forge->processIndexes('academies');
        $this->forge->dropTable('owners');
        $this->forge->dropTable('coaches');

    }

    public function down()
    {
        
    }
}
