<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateAttendanceTable extends Migration
{
    public function up(): void
    {
        $this->forge->addField([
            'attendance_id'   => ['type' => 'INT', 'unsigned' => true, 'auto_increment' => true],
            'student_id'      => ['type' => 'INT', 'unsigned' => true],
            'date_time'       => ['type' => 'DATETIME'],
            'status'          => [
                'type' => $this->db->getPlatform() == 'SQLite3'
                        ? 'VARCHAR CHECK (status in ("Absent", "Present"))'
                        : 'ENUM("Absent", "Present")',
                'default' => 'Absent'
            ],
        ]);
        $this->forge->addPrimaryKey('attendance_id');
        $this->forge->addForeignKey('student_id', 'users', 'id');
        $this->forge->addKey('date_time');
        $this->forge->createTable('attendance');

        if ($this->db->getPlatform() != 'MySQLi') {
            return;
        }

        $this->db->simpleQuery("
            CREATE OR REPLACE FUNCTION DOW(
                day_of_week ENUM('SUN','MON','TUE','WED','THU','FRI','SAT')
            ) RETURNS int(11)
            RETURN day_of_week+0;");

        $this->db->simpleQuery(
            "
CREATE OR REPLACE PROCEDURE getAttendance (
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
    WHERE
    d <= to_date
)
SELECT
    ci.d + INTERVAL DOW(ct.day_of_week) DAY + INTERVAL ct.start_time HOUR_SECOND as date_time,
    en.student_id,
    st.name as student_name,
    IFNULL(at.status, 'Absent') as status
FROM calendar_w as ci
CROSS JOIN class_timings as ct
CROSS JOIN enrollments as en ON (en.class_id = l_class_id)
LEFT JOIN users as st ON (st.id = en.student_id)
LEFT JOIN attendance as at ON (at.student_id = en.student_id AND at.date_time = ci.d + INTERVAL DOW(ct.day_of_week) DAY + INTERVAL ct.start_time HOUR_SECOND )
where
    ci.d  + INTERVAL DOW(ct.day_of_week) DAY BETWEEN en.start_date AND en.end_date
    AND ct.class_id = l_class_id
    AND ci.d  + INTERVAL DOW(ct.day_of_week) DAY BETWEEN from_date AND to_date;"
        );
    }

    public function down(): void
    {
        $this->forge->dropTable('attendance');
    }
}
