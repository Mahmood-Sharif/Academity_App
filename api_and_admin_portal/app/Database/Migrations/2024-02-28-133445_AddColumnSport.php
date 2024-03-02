<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddColumnSport extends Migration
{
    public function up()
    {
        $this->forge->addColumn('academies', ['sport_id' => [
            'type' => 'INT',
            'unsigned' => true
        ]]);
        $this->forge->addForeignKey('sport_id', 'sports', 'sport_id');
        $this->forge->processIndexes('academies');
    }

    public function down()
    {
        //
    }
}
 