<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class InitialMigration extends Migration
{
    public function up(): void
    {
        // Auth tables, including users, are owned by CodeIgniter Shield.
        // Run migrations with --all so Shield creates those before the later
        // app migrations add profile columns and foreign keys.

        $this->forge->addField([
            'media_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'mime_type' => [
                'type'       => 'VARCHAR',
                'constraint' => '128',
            ],
            'url' => [
                'type'       => 'VARCHAR',
                'constraint' => '256',
            ],
        ]);
        $this->forge->addPrimaryKey('media_id');
        $this->forge->createTable('media', true);

        $this->forge->addField([
            'academy_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'location' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'name' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'phone' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
            ],
            'description' => [
                'type' => 'TEXT',
            ],
            'media_id' => [
                'type'     => 'INT',
                'unsigned' => true,
                'null'     => true,
            ],
            'owner_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
        ]);
        $this->forge->addPrimaryKey('academy_id');
        $this->forge->addForeignKey('media_id', 'media', 'media_id', 'SET NULL', 'CASCADE');
        $this->forge->createTable('academies', true);

        $this->forge->addField([
            'class_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'class_name' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
            ],
            'min_age' => [
                'type' => 'INT',
            ],
            'max_age' => [
                'type' => 'INT',
            ],
            'academy_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
        ]);
        $this->forge->addPrimaryKey('class_id');
        $this->forge->addForeignKey('academy_id', 'academies', 'academy_id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('classes', true);

        $this->forge->addField([
            'timing_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'class_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
            'day_of_week' => [
                'type' => ($this->db->getPlatform() === 'SQLite3')
                    ? 'VARCHAR(3) CHECK( day_of_week IN ("SAT", "SUN", "MON", "TUE", "WED", "THU", "FRI") )'
                    : 'ENUM("SAT", "SUN", "MON", "TUE", "WED", "THU", "FRI")',
            ],
            'start_time' => [
                'type' => 'TIME',
            ],
            'end_time' => [
                'type' => 'TIME',
            ],
        ]);
        $this->forge->addPrimaryKey('timing_id');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'CASCADE', 'CASCADE');
        $this->forge->addKey(['class_id', 'start_time'], false, false, 'class_timings_class_id');
        $this->forge->createTable('class_timings', true);

        $this->forge->addField([
            'offer_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'description' => [
                'type'       => 'VARCHAR',
                'constraint' => '200',
            ],
        ]);
        $this->forge->addPrimaryKey('offer_id');
        $this->forge->createTable('offers', true);

        $this->forge->addField([
            'class_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
            'offer_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
        ]);
        $this->forge->addPrimaryKey(['class_id', 'offer_id']);
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('offer_id', 'offers', 'offer_id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('offer_classes', true);

        $this->forge->addField([
            'price_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'class_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
            'start_time' => [
                'type' => 'DATETIME',
            ],
            'end_time' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'price' => [
                'type'       => 'DECIMAL',
                'constraint' => '10,2',
            ],
            'offer_id' => [
                'type'     => 'INT',
                'unsigned' => true,
                'null'     => true,
            ],
        ]);
        $this->forge->addPrimaryKey('price_id');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('offer_id', 'offers', 'offer_id', 'SET NULL', 'CASCADE');
        $this->forge->addKey(['class_id', 'start_time'], false, false, 'prices_class_timed');
        $this->forge->createTable('prices', true);

        $this->forge->addField([
            'enrollment_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'start_date' => [
                'type' => 'DATE',
            ],
            'end_date' => [
                'type' => 'DATE',
            ],
            'student_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
            'class_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
        ]);
        $this->forge->addPrimaryKey('enrollment_id');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'RESTRICT', 'CASCADE');
        $this->forge->createTable('enrollments', true);

        $this->forge->addField([
            'transaction_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'timestamp' => [
                'type' => 'DATETIME',
            ],
            'amount' => [
                'type'       => 'DECIMAL',
                'constraint' => '10,2',
            ],
            'transaction_method' => [
                'type' => ($this->db->getPlatform() === 'SQLite3')
                    ? 'VARCHAR(6) CHECK( transaction_method IN ("Debit", "Credit", "Tap") )'
                    : 'ENUM("Debit", "Credit", "Tap")',
            ],
            'transaction_status' => [
                'type' => ($this->db->getPlatform() === 'SQLite3')
                    ? 'VARCHAR(10) CHECK( transaction_status IN ("Pending", "Processing", "Success", "Failure", "Refunded") )'
                    : 'ENUM("Pending", "Processing", "Success", "Failure", "Refunded")',
            ],
            'enrollment_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
        ]);
        $this->forge->addPrimaryKey('transaction_id');
        $this->forge->addForeignKey('enrollment_id', 'enrollments', 'enrollment_id', 'RESTRICT', 'CASCADE');
        $this->forge->addKey('timestamp', false, false, 'transaction_time');
        $this->forge->createTable('transactions', true);
    }

    public function down(): void
    {
        $this->db->disableForeignKeyChecks();

        foreach ([
            'transactions',
            'enrollments',
            'prices',
            'offer_classes',
            'offers',
            'class_timings',
            'classes',
            'academies',
            'media',
        ] as $table) {
            $this->forge->dropTable($table, true);
        }

        $this->db->enableForeignKeyChecks();
    }
}
