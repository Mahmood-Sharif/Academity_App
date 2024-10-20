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

    public function select($select = 'enrollments.*'): EnrollmentModel
    {
        return parent::select($select);
    }

    public function includeStudentName(): EnrollmentModel
    {
        return $this
            ->join('users', 'enrollments.student_id = users.id')
            ->select('users.name as student_name')  
        ;
    }

    public function includeStudentDetails(): EnrollmentModel
    {
        return $this
            ->join('users', 'enrollments.student_id = users.id')
            ->select('users.name as student_name')  
            // ->select('users.email as email')   
            // ->select('users.name as student_name')       
            ->select('users.dob as student_dob')         
            ->select('users.gender as student_gender')   
            ->select('users.phone as student_phone') 
        ;
    }

    public function includeClassName(): EnrollmentModel
    {
        return $this
            ->join('classes', 'enrollments.class_id = classes.class_id')
            ->select('classes.class_name')
        ;
    }

    public function isEnrolled(
        int $studentId,
        int $classId,
        DateTimeImmutable $datetime = new DateTimeImmutable('now', new DateTimeZone('Asia/Bahrain')),
        string|null $regCode = null,
    ): bool {
        if ($regCode !== null) {
            $class = (new ClassModel())
                ->where('reg_code', $regCode)
                ->first();
            $classId = $class->class_id;
        }

        return $this
            ->where('student_id', $studentId)
            ->where('class_id', $classId)
            ->where("end_date >= '{$datetime->format('Y-m-d')}'")
            ->first() !== null;
    }

    public function enrolWithCode(int $studentId, string $regCode): bool
    {
        $class = (new ClassModel())
            ->includeClassesPerWeek()
            ->where('reg_code', $regCode)
            ->first();

        $numEnrollments = (new ClassModel())
            ->includeNumEnrollments()
            ->where('reg_code', $regCode)
            ->first()
            ->num_enrollments;

        if ($class == null || $numEnrollments >= $class->max_capacity) {
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
