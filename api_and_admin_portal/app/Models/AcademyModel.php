<?php

namespace App\Models;

use CodeIgniter\Model;

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
          ->select('academies.*, media.url as image_url');
    }

    public function findAcademiesForOwner(int $userId): array
    {
        return $this->where('owner_id', $userId)->includeImageUrl()->findAll();
    }

}
