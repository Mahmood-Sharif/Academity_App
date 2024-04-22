<?php

namespace App\Models;

use CodeIgniter\Shield\Models\UserModel as CodeIgniterUserModel;
use DateTimeImmutable;
use DateTimeZone;

class UserModel extends CodeIgniterUserModel
{
    protected $returnType = \App\Entities\User::class;

    protected function initialize(): void
    {
        parent::initialize();

        $this->allowedFields = [
          ...$this->allowedFields,

          'name',
          'dob',
          'phone',
          'profile_image',

          // student fields
          'gender',
          'medical_condition',
          'parent_id',
        ];
    }

    public function select($select = 'users.*'): UserModel
    {
        return parent::select($select);
    }

    public function includeImageUrl(): UserModel
    {
        $baseUrl = base_url();
        return $this
          ->join('media', 'media.media_id = users.profile_image')
          ->select()
          ->select("CONCAT('$baseUrl', url) as image_url");
    }

    public function whereEnrolledInClass(int $classId): UserModel
    {
        $date = (new DateTimeImmutable('now', new DateTimeZone('Asia/Bahrain')))->format('Y-m-d');
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id', 'inner')
            ->join('classes', 'enrollments.class_id = classes.class_id', 'left')
            ->where('classes.class_id', $classId)
            ->where("enrollments.end_date >= '$date'")
            ->select()
            ->select('enrollments.enrollment_id')
            ->select('enrollments.start_date')
            ->select('enrollments.end_date')
        ;
    }

    public function whereEnrolledInAcademy(int $academyId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id', 'left')
            ->join('classes', 'enrollments.class_id = classes.class_id', 'left')
            ->where('academy_id', $academyId)
            ->groupBy('users.id')
            ->select()
            ->select('group_concat(classes.class_name SEPARATOR ", ") as classes');
    }

    public function whereInOwnerAcademies(int $userId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id', 'left')
            ->join('classes', 'enrollments.class_id = classes.class_id', 'left')
            ->join('academies', 'academies.academy_id = classes.academy_id', 'left')
            ->where('academies.owner_id', $userId)
            ->groupBy('users.id')
            ->select()
            ->select('group_concat(classes.class_name SEPARATOR ", ") as classes');
    }

    public function coaches(): UserModel
    {
        return $this
            ->join('auth_groups_users', 'auth_groups_users.user_id = users.id', 'left')
            ->join('academy_coaches', 'academy_coaches.coach_id = users.id', 'left')
            ->join('academies', 'academy_coaches.academy_id = academies.academy_id', 'left')
            ->groupBy('users.id')
            ->select()
            ->select('group_concat(academies.name SEPARATOR ", ") as academies')
            ->where('group', 'coach');
    }

    public function academiesOfCoach(int $coachId, int $ownerId): array
    {
        return $this
            ->join('academy_coaches', 'academy_coaches.coach_id = users.id', 'right')
            ->join('academies', 'academy_coaches.academy_id = academies.academy_id', 'right')
            ->select('academies.*')
            ->where('users.id', $coachId)
            ->where('academies.owner_id', $ownerId)
            ->findAll();
    }

}
