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

        $this->db->simpleQuery("DROP PROCEDURE IF EXISTS getAttendance;");
        $this->db->simpleQuery(
            "
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
    WHERE
    d <= to_date
)
SELECT
    ci.d + INTERVAL (
        CASE ct.day_of_week
            WHEN 'SUN' THEN 1
            WHEN 'MON' THEN 2
            WHEN 'TUE' THEN 3
            WHEN 'WED' THEN 4
            WHEN 'THU' THEN 5
            WHEN 'FRI' THEN 6
            WHEN 'SAT' THEN 7
        END
    ) DAY + INTERVAL ct.start_time HOUR_SECOND as date_time,
    en.student_id,
    st.name as student_name,
    IFNULL(at.status, 'Absent') as status
FROM calendar_w as ci
CROSS JOIN class_timings as ct
CROSS JOIN enrollments as en ON (en.class_id = l_class_id)
LEFT JOIN users as st ON (st.id = en.student_id)
LEFT JOIN attendance as at ON (
    at.student_id = en.student_id
    AND at.date_time = ci.d + INTERVAL (
        CASE ct.day_of_week
            WHEN 'SUN' THEN 1
            WHEN 'MON' THEN 2
            WHEN 'TUE' THEN 3
            WHEN 'WED' THEN 4
            WHEN 'THU' THEN 5
            WHEN 'FRI' THEN 6
            WHEN 'SAT' THEN 7
        END
    ) DAY + INTERVAL ct.start_time HOUR_SECOND
)
where
    ci.d + INTERVAL (
        CASE ct.day_of_week
            WHEN 'SUN' THEN 1
            WHEN 'MON' THEN 2
            WHEN 'TUE' THEN 3
            WHEN 'WED' THEN 4
            WHEN 'THU' THEN 5
            WHEN 'FRI' THEN 6
            WHEN 'SAT' THEN 7
        END
    ) DAY BETWEEN en.start_date AND en.end_date
    AND ct.class_id = l_class_id
    AND ci.d + INTERVAL (
        CASE ct.day_of_week
            WHEN 'SUN' THEN 1
            WHEN 'MON' THEN 2
            WHEN 'TUE' THEN 3
            WHEN 'WED' THEN 4
            WHEN 'THU' THEN 5
            WHEN 'FRI' THEN 6
            WHEN 'SAT' THEN 7
        END
    ) DAY BETWEEN from_date AND to_date;"
        );
    }

    public function down(): void
    {
        $this->forge->dropTable('attendance');
    }
}
