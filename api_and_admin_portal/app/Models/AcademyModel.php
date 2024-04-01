<?php

namespace App\Models;

use CodeIgniter\Model;

/* @method $this selectSubquery(BaseBuilder $subquery, string $as) */
/* @method $this distinct() */
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
      'sport_id'
    ];

    protected $validationRules = [
      'name'        => ['label' => 'App.academy_name',        'rules' => 'string|required|min_length[3]|max_length[100]'],
      'location'    => ['label' => 'App.academy_location',    'rules' => 'string|required|min_length[3]|max_length[100]'],
      'phone'       => ['label' => 'App.academy_phone',       'rules' => 'string|required|min_length[8]|max_length[100]'],
      'description' => ['label' => 'App.academy_description', 'rules' => 'string|required|min_length[3]|max_length[255]'],
      'sport_id'    => 'integer|is_natural_no_zero',
    ];
    protected $validationMessages = [
      'sport_id' => [
        'integer'            => 'Rules.academy.sport',
        'is_natural_no_zero' => 'Rules.academy.sport',
      ],
      'image' => [
        'uploaded' => 'Rules.academy.image',
      ]
    ];

    public function includeImageUrl(): AcademyModel
    {
        $baseUrl = base_url();
        return $this
          ->join('media', 'media.media_id = academies.media_id')
          ->select('academies.*')
          ->select("CONCAT('$baseUrl', url) as image_url");
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

    public function getAcademiesBySportId(int $sportId): array
    {
        return $this->where('sport_id', $sportId)->findAll();
    }

}
