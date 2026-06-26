<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class UpdateProcedures extends Migration
{
    public function up()
    {
        $this->db->simpleQuery("DROP PROCEDURE IF EXISTS getStudentSchedule;");
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
    ) DAY as date,
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
    AND en.student_id = student
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
    ) DAY BETWEEN from_date AND to_date;
            ");

        $this->db->simpleQuery("DROP PROCEDURE IF EXISTS getCoachSchedule;");
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
    ) DAY as date,
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
where
    users.id = coach
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
    ) DAY BETWEEN from_date AND to_date;");
    }

    public function down()
    {
        //
    }
}
