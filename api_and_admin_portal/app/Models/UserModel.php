<?php

namespace App\Models;

use CodeIgniter\Shield\Models\UserModel as CodeIgniterUserModel;

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

          // student fields
          'gender',
          'medical_condition',
          'parent_id',
        ];
    }

    public function whereEnrolledInClass(int $classId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id')
            ->where('class_id', $classId)
            ->select('users.*');
    }

    public function whereEnrolledInAcademy(int $academyId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id')
            ->join('classes', 'enrollments.class_id = classes.class_id')
            ->where('academy_id', $academyId)
            ->select('users.*');
    }

    public function whereInOwnerAcademies(int $userId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id')
            ->join('classes', 'enrollments.class_id = classes.class_id')
            ->join('academies', 'academies.academy_id = classes.academy_id')
            ->where('academies.owner_id', $userId)
            ->select('users.*');
    }

    public function coaches(): UserModel
    {
        return $this
            ->join('auth_groups_users', 'auth_groups_users.user_id = users.id')
            ->join('academy_coaches', 'academy_coaches.coach_id = users.id')
            ->join('academies', 'academy_coaches.academy_id = academies.academy_id')
            ->groupBy('users.id')
            ->select('users.*')
            ->select('group_concat(academies.name SEPARATOR ", ") as academies')
            ->where('group', 'coach');
    }

}
