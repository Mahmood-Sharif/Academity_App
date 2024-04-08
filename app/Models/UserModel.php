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

          // student fields
          'gender',
          'medical_condition',
          'parent_id',
        ];
    }

    public function addUserImage(int $userId, $imageFile): bool
    {
        if (!$imageFile->isValid() || $imageFile->hasMoved()) {
            return false; // Handle file upload errors or already moved files.
        }

        // Define your path where images should be stored. Adjust as needed.
        $targetPath = WRITEPATH . 'uploads/user_images/';
        
        $imageName = $imageFile->getRandomName(); // Generates a random name for the image.
        if ($imageFile->move($targetPath, $imageName)) {
            // Assuming you have a MediaModel to handle media records.
            $mediaModel = new \App\Models\MediaModel();
            $mediaData = [
                'url' => '/uploads/user_images/' . $imageName, // Adjust based on your needs.
                // Add other necessary fields for the media table.
            ];
            
            if ($mediaModel->insert($mediaData)) {
                $mediaId = $mediaModel->getInsertID();
                return $this->update($userId, ['media_id' => $mediaId]);
            }
        }

        return false; // Return false if any step fails.
    }

    public function includeImageUrl(): self
    {
        $baseUrl = base_url();
        return $this
            ->join('media', 'users.media_id = media.media_id') 
            ->select('users.*')
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
            ->select('users.*')
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
