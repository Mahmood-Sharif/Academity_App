<?php

namespace App\Models;

use App\Entities\Enrollment;
use CodeIgniter\Model;
use DateInterval;
use DateTimeImmutable;
use DateTimeZone;

class EnrollmentModel extends Model
{
    protected $table = 'enrollments';
    protected $primaryKey = 'enrollment_id';

    protected $allowedFields = [
      'start_date',
      'end_date',
      'student_id',
      'class_id',
    ];

    protected $returnType = \App\Entities\Enrollment::class;

    public function enrolWithCode(int $studentId, string $regCode): bool
    {
        $class = (new ClassModel())
            ->includeClassesPerWeek()
            ->includeNumEnrollments()
            ->where('reg_code', $regCode)
            ->first();

        if ($class == null || $class->num_enrollments >= $class->max_capacity) {
            return false;
        }

        $date = new DateTimeImmutable('now', new DateTimeZone('Asia/Bahrain'));
        // TODO: enrollment duration
        // TODO: more rigorous calculation?
        // TODO: what if classes_per_week changed?
        $weeks = ceil($class->min_duration / $class->classes_per_week);
        $enrollment = new Enrollment([
            'start_date' => $date->format('Y-m-d'),
            'end_date' => $date->add(new DateInterval("P{$weeks}W"))->format('Y-m-d'),
            'student_id' => $studentId,
            'class_id' => $class->class_id,
        ]);
        return $this->insert($enrollment->toArray(), false);
    }

}
