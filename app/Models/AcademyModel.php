<?php

namespace App\Models;

use CodeIgniter\Model;

/* @method $this selectSubquery(BaseBuilder $subquery, string $as) */
class AcademyModel extends Model
{
    protected $table = 'academies';
    protected $primaryKey = 'academy_id';
    protected $returnType = \App\Entities\Academy::class;

    protected $allowedFields = [
      'location',
      'name',
      'phone',
      'description',
      'media_id',
      'owner_id',
    ];

    public function includeImageUrl(): AcademyModel
    {
        return $this
          ->join('media', 'media.media_id = academies.media_id')
          ->select('academies.*')
          ->select('media.url as image_url');
    }

    public function includeStatistics(int $id): AcademyModel
    {
        $classes = $this->db->table('classes')
                            ->where('academy_id', $id)
                            ->selectCount('class_id');
        $students = $this->db->table('classes')
                             ->where('academy_id', $id)
                             ->join('enrollments', 'enrollments.class_id = classes.class_id')
                             ->selectCount('student_id');
        return $this
          ->select('academies.*')
          ->selectSubquery($classes, 'num_classes')
          ->selectSubquery($students, 'num_students');
    }

    public function findAcademiesForOwner(int $userId): array
    {
        return $this->where('owner_id', $userId)->includeImageUrl()->findAll();
    }

}
