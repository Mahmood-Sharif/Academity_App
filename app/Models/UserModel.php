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

    public function saveUser($user)
    {
        // Assuming $user is an entity with an 'id' property
        if (isset($user->id)) {
            return $this->userModel->update($user->id, $user);
        } else {
            return $this->userModel->insert($user);
        }
    }

    public function whereEnrolledInClass(int $classId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id', 'left')
            ->join('classes', 'enrollments.class_id = classes.class_id', 'left')
            ->where('classes.class_id', $classId)
            ->groupBy('users.id')
            ->select('users.*')
            ->select('group_concat(classes.class_name SEPARATOR ", ") as classes');
    }

    public function whereEnrolledInAcademy(int $academyId): UserModel
    {
        return $this
            ->join('enrollments', 'enrollments.student_id = users.id', 'left')
            ->join('classes', 'enrollments.class_id = classes.class_id', 'left')
            ->where('academy_id', $academyId)
            ->groupBy('users.id')
            ->select('users.*')
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
            ->select('users.*')
            ->select('group_concat(classes.class_name SEPARATOR ", ") as classes');
    }

    public function coaches(): UserModel
    {
        return $this
            ->join('auth_groups_users', 'auth_groups_users.user_id = users.id', 'left')
            ->join('academy_coaches', 'academy_coaches.coach_id = users.id', 'left')
            ->join('academies', 'academy_coaches.academy_id = academies.academy_id', 'left')
            ->groupBy('users.id')
            ->select('users.*')
            ->select('group_concat(academies.name SEPARATOR ", ") as academies')
            ->where('group', 'coach');
    }

}
