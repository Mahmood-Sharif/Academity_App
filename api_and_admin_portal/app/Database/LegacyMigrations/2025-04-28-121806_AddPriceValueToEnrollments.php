<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddPriceValueToEnrollments extends Migration
{
    public function up()
    {
        $this->forge->addColumn('enrollments', [
            'price_value' => [
                'type'       => 'DECIMAL',
                'constraint' => '10,2',
                'null'       => true,
                'after'      => 'class_id' // optional: place after class_id field
            ],
        ]);
    }    

    public function down()
    {
        $this->forge->dropColumn('enrollments', 'price_value');
    }
    
}
