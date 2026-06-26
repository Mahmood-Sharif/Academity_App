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
            ->join('media', 'media.media_id = users.profile_image', 'left')
            ->select('users.*')
            ->select("CONCAT('$baseUrl', media.url) as image_url", false);
    }

    public function whereEnrolledInClass(int $classId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id', 'inner')
            ->join('classes', 'enrollments.class_id = classes.class_id', 'left')
            ->where('classes.class_id', $classId)
            ->select('users.*')
            ->select('MAX(enrollments.enrollment_id) AS enrollment_id', false)
            ->select('MAX(enrollments.start_date) AS start_date', false)
            ->select('MAX(enrollments.end_date) AS end_date', false)
            ->select('GROUP_CONCAT(DISTINCT classes.class_name SEPARATOR ", ") as classes', false)
            ->groupBy($this->userGroupByColumns());
    }

    public function whereEnrolledInAcademy(int $academyId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id', 'inner')
            ->join('classes', 'enrollments.class_id = classes.class_id', 'left')
            ->where('classes.academy_id', $academyId)
            ->select('users.*')
            ->select('MAX(enrollments.enrollment_id) AS enrollment_id', false)
            ->select('MAX(enrollments.start_date) AS start_date', false)
            ->select('MAX(enrollments.end_date) AS end_date', false)
            ->select('GROUP_CONCAT(DISTINCT classes.class_name SEPARATOR ", ") as classes', false)
            ->groupBy($this->userGroupByColumns());
    }

    public function whereInOwnerAcademies(int $userId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id', 'inner')
            ->join('classes', 'enrollments.class_id = classes.class_id', 'left')
            ->join('academies', 'academies.academy_id = classes.academy_id', 'left')
            ->where('academies.owner_id', $userId)
            ->select('users.*')
            ->select('MAX(enrollments.enrollment_id) AS enrollment_id', false)
            ->select('MAX(enrollments.start_date) AS start_date', false)
            ->select('MAX(enrollments.end_date) AS end_date', false)
            ->select('GROUP_CONCAT(DISTINCT classes.class_name SEPARATOR ", ") as classes', false)
            ->groupBy($this->userGroupByColumns());
    }

    public function coaches(): UserModel
    {
        return $this
            ->join('auth_groups_users', 'auth_groups_users.user_id = users.id', 'left')
            ->join('academy_coaches', 'academy_coaches.coach_id = users.id', 'left')
            ->join('academies', 'academy_coaches.academy_id = academies.academy_id', 'left')
            ->where('auth_groups_users.group', 'coach')
            ->select('users.*')
            ->select('GROUP_CONCAT(DISTINCT academies.name SEPARATOR ", ") as academies', false)
            ->groupBy($this->userGroupByColumns());
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

    private function userGroupByColumns(): array
    {
        return [
            'users.id',
            'users.username',
            'users.status',
            'users.status_message',
            'users.active',
            'users.last_active',
            'users.created_at',
            'users.updated_at',
            'users.deleted_at',
            'users.name',
            'users.dob',
            'users.phone',
            'users.profile_image',
            'users.gender',
            'users.medical_condition',
            'users.parent_id',
        ];
    }
}
