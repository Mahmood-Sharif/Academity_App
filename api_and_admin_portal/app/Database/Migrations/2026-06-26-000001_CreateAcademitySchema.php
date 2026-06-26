<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateAcademitySchema extends Migration
{
    private string $usersTable = 'users';

    public function up(): void
    {
        /** @var \Config\Auth $authConfig */
        $authConfig       = config('Auth');
        $this->usersTable = $authConfig->tables['users'];

        $this->createMediaTable();
        $this->addUserProfileColumns();
        $this->createSportsTable();
        $this->createAcademiesTable();
        $this->createClassesTable();
        $this->createClassTimingsTable();
        $this->createOffersTable();
        $this->createOfferClassesTable();
        $this->createPricesTable();
        $this->createEnrollmentsTable();
        $this->createTransactionsTable();
        $this->createAttendanceTable();
        $this->createAcademyCoachesTable();
        $this->createGalleryTable();
        $this->createScheduleRoutines();
    }

    public function down(): void
    {
        /** @var \Config\Auth $authConfig */
        $authConfig       = config('Auth');
        $this->usersTable = $authConfig->tables['users'];

        $this->dropScheduleRoutines();
        $this->dropUserProfileColumns();

        $this->db->disableForeignKeyChecks();

        foreach ([
            'gallery',
            'academy_coaches',
            'attendance',
            'transactions',
            'enrollments',
            'prices',
            'offer_classes',
            'offers',
            'class_timings',
            'classes',
            'academies',
            'sports',
            'media',
        ] as $table) {
            $this->forge->dropTable($table, true);
        }

        $this->db->enableForeignKeyChecks();
    }

    private function createMediaTable(): void
    {
        $this->forge->addField([
            'media_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'mime_type' => [
                'type'       => 'VARCHAR',
                'constraint' => 128,
            ],
            'url' => [
                'type'       => 'VARCHAR',
                'constraint' => 256,
            ],
        ]);
        $this->forge->addPrimaryKey('media_id');
        $this->forge->createTable('media');
    }

    private function addUserProfileColumns(): void
    {
        $this->forge->addColumn($this->usersTable, [
            'name' => [
                'type'       => 'VARCHAR',
                'constraint' => 100,
                'null'       => true,
            ],
            'dob' => [
                'type' => 'DATE',
                'null' => true,
            ],
            'phone' => [
                'type'       => 'VARCHAR',
                'constraint' => 20,
                'null'       => true,
            ],
            'profile_image' => [
                'type'     => 'INT',
                'unsigned' => true,
                'null'     => true,
            ],
            'gender' => [
                'type' => $this->db->getPlatform() === 'SQLite3'
                    ? 'VARCHAR(7) CHECK( gender IN ("Male", "Female") )'
                    : 'ENUM("Male", "Female")',
                'null' => true,
            ],
            'medical_condition' => [
                'type'       => 'VARCHAR',
                'constraint' => 100,
                'null'       => true,
            ],
            'parent_id' => [
                'type'     => 'INT',
                'unsigned' => true,
                'null'     => true,
            ],
        ]);

        $this->forge->addForeignKey('profile_image', 'media', 'media_id', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('parent_id', $this->usersTable, 'id', 'CASCADE', 'SET NULL');
        $this->forge->processIndexes($this->usersTable);
    }

    private function createSportsTable(): void
    {
        $this->forge->addField([
            'sport_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'name' => [
                'type'       => 'VARCHAR',
                'constraint' => 100,
            ],
            'media_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
        ]);
        $this->forge->addPrimaryKey('sport_id');
        $this->forge->addForeignKey('media_id', 'media', 'media_id', 'CASCADE', 'RESTRICT');
        $this->forge->createTable('sports');
    }

    private function createAcademiesTable(): void
    {
        $this->forge->addField([
            'academy_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'location' => [
                'type'       => 'VARCHAR',
                'constraint' => 100,
            ],
            'name' => [
                'type'       => 'VARCHAR',
                'constraint' => 100,
            ],
            'phone' => [
                'type'       => 'VARCHAR',
                'constraint' => 20,
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
            'sport_id' => [
                'type'     => 'INT',
                'unsigned' => true,
                'null'     => true,
            ],
        ]);
        $this->forge->addPrimaryKey('academy_id');
        $this->forge->addForeignKey('media_id', 'media', 'media_id', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('owner_id', $this->usersTable, 'id', 'CASCADE', 'RESTRICT');
        $this->forge->addForeignKey('sport_id', 'sports', 'sport_id', 'CASCADE', 'SET NULL');
        $this->forge->createTable('academies');
    }

    private function createClassesTable(): void
    {
        $this->forge->addField([
            'class_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'class_name' => [
                'type'       => 'VARCHAR',
                'constraint' => 100,
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
            'max_capacity' => [
                'type'    => 'INT',
                'default' => 0,
            ],
            'min_duration' => [
                'type'    => 'INT',
                'default' => 0,
            ],
            'max_duration' => [
                'type'    => 'INT',
                'default' => 0,
            ],
            'coach_id' => [
                'type'     => 'INT',
                'unsigned' => true,
                'null'     => true,
            ],
            'reg_code' => [
                'type'       => 'VARCHAR',
                'constraint' => 10,
                'null'       => true,
            ],
        ]);
        $this->forge->addPrimaryKey('class_id');
        $this->forge->addUniqueKey('reg_code');
        $this->forge->addForeignKey('academy_id', 'academies', 'academy_id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('coach_id', $this->usersTable, 'id', 'CASCADE', 'SET NULL');
        $this->forge->createTable('classes');
    }

    private function createClassTimingsTable(): void
    {
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
                'type' => $this->db->getPlatform() === 'SQLite3'
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
        $this->forge->addKey(['class_id', 'start_time'], false, false, 'class_timings_class_time');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('class_timings');
    }

    private function createOffersTable(): void
    {
        $this->forge->addField([
            'offer_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'description' => [
                'type'       => 'VARCHAR',
                'constraint' => 200,
            ],
        ]);
        $this->forge->addPrimaryKey('offer_id');
        $this->forge->createTable('offers');
    }

    private function createOfferClassesTable(): void
    {
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
        $this->forge->createTable('offer_classes');
    }

    private function createPricesTable(): void
    {
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
        $this->forge->addKey(['class_id', 'start_time'], false, false, 'prices_class_time');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('offer_id', 'offers', 'offer_id', 'CASCADE', 'SET NULL');
        $this->forge->createTable('prices');
    }

    private function createEnrollmentsTable(): void
    {
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
            'price_value' => [
                'type'       => 'DECIMAL',
                'constraint' => '10,2',
                'null'       => true,
            ],
        ]);
        $this->forge->addPrimaryKey('enrollment_id');
        $this->forge->addForeignKey('student_id', $this->usersTable, 'id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('enrollments');
    }

    private function createTransactionsTable(): void
    {
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
                'type' => $this->db->getPlatform() === 'SQLite3'
                    ? 'VARCHAR(6) CHECK( transaction_method IN ("Debit", "Credit", "Tap") )'
                    : 'ENUM("Debit", "Credit", "Tap")',
            ],
            'transaction_status' => [
                'type' => $this->db->getPlatform() === 'SQLite3'
                    ? 'VARCHAR(10) CHECK( transaction_status IN ("Pending", "Processing", "Success", "Failure", "Refunded") )'
                    : 'ENUM("Pending", "Processing", "Success", "Failure", "Refunded")',
            ],
            'enrollment_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
        ]);
        $this->forge->addPrimaryKey('transaction_id');
        $this->forge->addKey('timestamp', false, false, 'transactions_timestamp');
        $this->forge->addForeignKey('enrollment_id', 'enrollments', 'enrollment_id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('transactions');
    }

    private function createAttendanceTable(): void
    {
        $this->forge->addField([
            'attendance_id' => [
                'type'           => 'INT',
                'unsigned'       => true,
                'auto_increment' => true,
            ],
            'student_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
            'date_time' => [
                'type' => 'DATETIME',
            ],
            'status' => [
                'type' => $this->db->getPlatform() === 'SQLite3'
                    ? 'VARCHAR(7) CHECK( status IN ("Absent", "Present") )'
                    : 'ENUM("Absent", "Present")',
                'default' => 'Absent',
            ],
            'class_id' => [
                'type'     => 'INT',
                'unsigned' => true,
                'null'     => true,
            ],
        ]);
        $this->forge->addPrimaryKey('attendance_id');
        $this->forge->addKey('date_time');
        $this->forge->addForeignKey('student_id', $this->usersTable, 'id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('class_id', 'classes', 'class_id', 'CASCADE', 'SET NULL');
        $this->forge->createTable('attendance');
    }

    private function createAcademyCoachesTable(): void
    {
        $this->forge->addField([
            'academy_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
            'coach_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
        ]);
        $this->forge->addPrimaryKey(['academy_id', 'coach_id']);
        $this->forge->addForeignKey('academy_id', 'academies', 'academy_id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('coach_id', $this->usersTable, 'id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('academy_coaches');
    }

    private function createGalleryTable(): void
    {
        $this->forge->addField([
            'academy_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
            'media_id' => [
                'type'     => 'INT',
                'unsigned' => true,
            ],
            'index' => [
                'type'     => 'INT',
                'unsigned' => true,
                'default'  => 0,
            ],
        ]);
        $this->forge->addPrimaryKey(['academy_id', 'media_id']);
        $this->forge->addForeignKey('academy_id', 'academies', 'academy_id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('media_id', 'media', 'media_id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('gallery');
    }

    private function createScheduleRoutines(): void
    {
        if ($this->db->getPlatform() !== 'MySQLi') {
            return;
        }

        $this->dropScheduleRoutines();

        $dayOffset = $this->dayOffsetSql('ct.day_of_week');

        $this->db->simpleQuery("
CREATE PROCEDURE getAttendance (
  IN l_class_id INTEGER,
  IN from_date DATE,
  IN to_date DATE
)
READS SQL DATA
WITH RECURSIVE calendar_w (d) AS (
    SELECT from_date - INTERVAL (DAYOFWEEK(from_date)) DAY
    UNION ALL
    SELECT d + INTERVAL 1 WEEK
    FROM calendar_w
    WHERE d <= to_date
)
SELECT
    ci.d + INTERVAL ({$dayOffset}) DAY + INTERVAL ct.start_time HOUR_SECOND as date_time,
    en.student_id,
    st.name as student_name,
    IFNULL(at.status, 'Absent') as status,
    en.class_id
FROM calendar_w as ci
CROSS JOIN class_timings as ct
CROSS JOIN enrollments as en ON (en.class_id = l_class_id)
LEFT JOIN users as st ON (st.id = en.student_id)
LEFT JOIN attendance as at ON (
    at.student_id = en.student_id
    AND at.class_id = en.class_id
    AND at.date_time = ci.d + INTERVAL ({$dayOffset}) DAY + INTERVAL ct.start_time HOUR_SECOND
)
WHERE
    ci.d + INTERVAL ({$dayOffset}) DAY BETWEEN en.start_date AND en.end_date
    AND ct.class_id = l_class_id
    AND ci.d + INTERVAL ({$dayOffset}) DAY BETWEEN from_date AND to_date;");

        $this->db->simpleQuery("
CREATE PROCEDURE getStudentSchedule (
  IN student INTEGER,
  IN from_date DATE,
  IN to_date DATE
)
READS SQL DATA
WITH RECURSIVE calendar_w (d) AS (
    SELECT from_date - INTERVAL (DAYOFWEEK(from_date)) DAY
    UNION ALL
    SELECT d + INTERVAL 1 WEEK
    FROM calendar_w
    WHERE d <= to_date
)
SELECT
    ci.d + INTERVAL ({$dayOffset}) DAY as date,
    ct.start_time,
    ct.end_time,
    cl.class_id,
    cl.class_name,
    ac.name as academy_name,
    ac.location
FROM calendar_w as ci
CROSS JOIN class_timings as ct
CROSS JOIN enrollments as en ON (ct.class_id = en.class_id)
LEFT JOIN users as st ON (st.id = en.student_id)
LEFT JOIN classes as cl ON (cl.class_id = en.class_id)
LEFT JOIN academies as ac ON (ac.academy_id = cl.academy_id)
WHERE
    ci.d + INTERVAL ({$dayOffset}) DAY BETWEEN en.start_date AND en.end_date
    AND en.student_id = student
    AND ci.d + INTERVAL ({$dayOffset}) DAY BETWEEN from_date AND to_date;");

        $this->db->simpleQuery("
CREATE PROCEDURE getCoachSchedule (
  IN coach INTEGER,
  IN from_date DATE,
  IN to_date DATE
)
READS SQL DATA
WITH RECURSIVE calendar_w (d) AS (
    SELECT from_date - INTERVAL (DAYOFWEEK(from_date)) DAY
    UNION ALL
    SELECT d + INTERVAL 1 WEEK
    FROM calendar_w
    WHERE d <= to_date
)
SELECT
    ci.d + INTERVAL ({$dayOffset}) DAY as date,
    ct.start_time,
    ct.end_time,
    cl.class_id,
    cl.class_name,
    ac.name as academy_name,
    ac.location
FROM calendar_w as ci
CROSS JOIN class_timings as ct
LEFT JOIN classes as cl ON (cl.class_id = ct.class_id)
LEFT JOIN users ON (users.id = cl.coach_id)
LEFT JOIN academies as ac ON (ac.academy_id = cl.academy_id)
WHERE
    users.id = coach
    AND ci.d + INTERVAL ({$dayOffset}) DAY BETWEEN from_date AND to_date;");
    }

    private function dropScheduleRoutines(): void
    {
        if ($this->db->getPlatform() !== 'MySQLi') {
            return;
        }

        foreach (['getAttendance', 'getStudentSchedule', 'getCoachSchedule'] as $procedure) {
            $this->db->simpleQuery("DROP PROCEDURE IF EXISTS {$procedure};");
        }
    }

    private function dropUserProfileColumns(): void
    {
        foreach ([
            "{$this->usersTable}_profile_image_foreign",
            "{$this->usersTable}_parent_id_foreign",
        ] as $foreignKey) {
            try {
                $this->forge->dropForeignKey($this->usersTable, $foreignKey);
            } catch (\Throwable) {
            }
        }

        $fields = array_filter([
            'name',
            'dob',
            'phone',
            'profile_image',
            'gender',
            'medical_condition',
            'parent_id',
        ], fn (string $field): bool => $this->db->fieldExists($field, $this->usersTable));

        if ($fields !== []) {
            $this->forge->dropColumn($this->usersTable, $fields);
        }
    }

    private function dayOffsetSql(string $field): string
    {
        return "CASE {$field}
            WHEN 'SUN' THEN 1
            WHEN 'MON' THEN 2
            WHEN 'TUE' THEN 3
            WHEN 'WED' THEN 4
            WHEN 'THU' THEN 5
            WHEN 'FRI' THEN 6
            WHEN 'SAT' THEN 7
        END";
    }
}
