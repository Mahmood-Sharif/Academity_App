<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class InitialMigration extends Migration
{
    public function up(): void
    {
        $this->forge->createDatabase('academity', true);

        // Owners table
        $this->forge->addField([
          'owner_id' => [
            'type'           => 'INT',
            'unsigned'       => true,
            'auto_increment' => true
          ],
          'email' => [
            'type'       => 'VARCHAR',
            'constraint' => '100'
          ],
          'name' => [
            'type'       => 'VARCHAR',
            'constraint' => '100'
          ],
          'password' => [
            'type'       => 'VARCHAR',
            'constraint' => '60'
          ],
        ]);
        $this->forge->addPrimaryKey('owner_id');
        $this->forge->createTable('owners', true);

        // Media table
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
          ]
        ]);
        $this->forge->addPrimaryKey('media_id');
        $this->forge->createTable('media', true);

        // Academies table
        $this->forge->addField([
          'academy_id' => [
            'type'           => 'INT',
            'unsigned'       => true,
            'auto_increment' => true,
          ],
          'location' => [
            'type'       => 'VARCHAR',
            'constraint' => '100'
          ],
          'name' => [
            'type'       => 'VARCHAR',
            'constraint' => '100'
          ],
          'phone' => [
            'type'       => 'INT',
            'constraint' => '20'
          ],
          'description' => [
            'type' => 'TEXT'
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
        $this->forge->addForeignKey('owner_id', 'owners', 'owner_id');
        $this->forge->addForeignKey('media_id', 'media', 'media_id');
        $this->forge->createTable('academies', true);

        // Classes table
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
            'type'       => 'INT',
            'constraint' => '5',
          ],
          'max_age' => [
            'type'       => 'INT',
            'constraint' => '5',
          ],
          'academy_id' => [
            'type'     => 'INT',
            'unsigned' => true,
          ]
        ]);
        $this->forge->addPrimaryKey('class_id');
        $this->forge->addForeignKey('academy_id', 'academies', 'academy_id');
        $this->forge->createTable('classes', true);

        // Class Timings table
        $this->forge->addField([
          'timing_id' => [
            'type' => 'INT',
            'unsigned' => true,
            'auto_increment' => true,
          ],
          'class_id' => [
            'type' => 'INT',
            'unsigned' => true,
          ],
          'day_of_week' => [
            'type' => ($this->db->getPlatform() == 'SQLite3')
              ? 'VARCHAR(3) CHECK( day_of_week IN ("SAT", "SUN", "MON", "TUE", "WED", "THU", "FRI") )'
              : 'ENUM("SAT", "SUN", "MON", "TUE", "WED", "THU", "FRI")'
          ],
          'start_time' => [
            'type' => 'TIME',
          ],
          'end_time' => [
            'type' => 'TIME',
          ],
        ]);
        $this->forge->addPrimaryKey('timing_id');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id');
        $this->forge->createTable('class_timings');
        $this->db->simpleQuery('CREATE INDEX class_timings_class_id ON class_timings (class_id, start_time)');

        // Offers table
        $this->forge->addField([
          'offer_id' => [
            'type'           => 'INT',
            'unsigned'       => true,
            'auto_increment' => true,
          ],
          'description' => [
            'type'       => 'VARCHAR',
            'constraint' => '200'
          ],
        ]);
        $this->forge->addPrimaryKey('offer_id');
        $this->forge->createTable('offers', true);

        // Classes applicable for Offer table
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
        $this->forge->addForeignKey('class_id', 'classes', 'class_id');
        $this->forge->addForeignKey('offer_id', 'offers', 'offer_id');
        $this->forge->createTable('offer_classes', true);

        // Prices table
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
            'null' => true
          ],
          'price' => [
            'type' => 'DECIMAL',
          ],
          'offer_id' => [
            'type'     => 'INT',
            'unsigned' => true,
            'null'     => true,
          ]
        ]);
        $this->forge->addPrimaryKey('price_id');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id');
        $this->forge->addForeignKey('offer_id', 'offers', 'offer_id');
        $this->forge->createTable('prices', true);
        $this->db->simpleQuery('CREATE INDEX prices_class_timed ON prices (class_id, start_time)');

        // Sports table
        $this->forge->addField([
          'sport_name' => [
            'type'       => 'VARCHAR',
            'constraint' => '50'
          ],
          'media_id' => [
            'type'     => 'INT',
            'unsigned' => true,
          ],
        ]);
        $this->forge->addPrimaryKey('sport_name');
        $this->forge->addForeignKey('media_id', 'media', 'media_id');
        $this->forge->createTable('offer_classes', true);

        // Students table
        $this->forge->addField([
          'student_id' => [
            'type'           => 'INT',
            'unsigned'       => true,
            'auto_increment' => true,
          ],
          'dob' => [
            'type' => 'DATE',
          ],
          'phone' => [
            'type'       => 'INT',
            'constraint' => '20',
          ],
          'emergency_contact' => [
            'type'       => 'INT',
            'constraint' => '20',
            'null' => true
          ],
          'first_name' => [
            'type'       => 'VARCHAR',
            'constraint' => '50'
          ],
          'last_name' => [
            'type'       => 'VARCHAR',
            'constraint' => '50'
          ],
          'gender' =>
          [
            'type' => ($this->db->getPlatform() == 'SQLite3')
              ? 'VARCHAR(7) CHECK( gender IN ("Male", "Female") )'
              : 'ENUM("Male", "Female")',
            'null' => true
          ],
          'medical_condition' => [
            'type'       => 'VARCHAR',
            'constraint' => '50',
            'null'       => true,
            'default'    => null,
          ],
        ]);
        $this->forge->addPrimaryKey('student_id');
        $this->forge->createTable('students', true);

        // Users table
        $this->forge->addField([
          'user_id' => [
            'type'           => 'INT',
            'unsigned'       => true,
            'auto_increment' => true,
          ],
          'dob' => [
            'type' => 'DATE',
          ],
          'phone' => [
            'type'       => 'INT',
            'constraint' => '20',
          ],
          'email' => [
            'type'       => 'VARCHAR',
            'constraint' => '100',
          ],
          'password' => [
            'type'       => 'VARCHAR',
            'constraint' => '100',
          ],
          'first_name' => [
            'type'       => 'VARCHAR',
            'constraint' => '50'
          ],
          'last_name' => [
            'type'       => 'VARCHAR',
            'constraint' => '50'
          ],
        ]);
        $this->forge->addPrimaryKey('user_id');
        $this->forge->createTable('users', true);

        // Enrollments table
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
          ]
        ]);
        $this->forge->addPrimaryKey('enrollment_id');
        $this->forge->addForeignKey('student_id', 'students', 'student_id');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id');
        $this->forge->createTable('enrollments', true);

        // Transactions table
        $this->forge->addField([
          'transaction_id' => [
            'type'           => 'INT',
            'unsigned'       => true,
            'auto_increment' => true
          ],
          'timestamp' => [
            'type' => 'DATETIME',
          ],
          'amount' => [
            'type' => 'DECIMAL'
          ],
          'transaction_method' =>
          [
            'type' => ($this->db->getPlatform() == 'SQLite3')
              ? 'VARCHAR(6) CHECK( transaction_method IN ("Debit", "Credit", "Tap") )'
              : 'ENUM("Debit", "Credit", "Tap")',
          ],
          'transaction_status' =>
          [
            'type' => ($this->db->getPlatform() == 'SQLite3')
              ? 'VARCHAR(10) CHECK( transaction_status IN ("Pending", "Processing", "Success", "Failure", "Refunded") )'
              : 'ENUM("Pending", "Processing", "Success", "Failure", "Refunded")',
          ],
          'enrollment_id' => [
            'type' => 'INT',
            'unsigned' => true
          ],
        ]);
        $this->forge->addPrimaryKey('transaction_id');
        $this->forge->addForeignKey('enrollment_id', 'enrollments', 'enrollment_id');
        $this->forge->createTable('transactions');
        $this->db->simpleQuery('CREATE INDEX transaction_time ON transactions (timestamp)');
    }

    public function down(): void
    {
        $this->forge->dropDatabase('academity');
    }
}
