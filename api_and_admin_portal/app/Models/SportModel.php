<?php

namespace App\Models;

use App\Entities\Sport;
use CodeIgniter\Database\RawSql;
use CodeIgniter\Model;

class SportModel extends Model
{
    protected $table = 'sports';
    protected $primaryKey = 'sport_id';

    protected $allowedFields = [
      'name',
      'media_id',
    ];

    protected $returnType = \App\Entities\Sport::class;

    public function findAll(int $limit = 0, int $offset = 0): array
    {

        $siteUrl = site_url();
        return $this->builder()
          ->join('media', 'sports.media_id = media.media_id')
          ->select(new RawSql("sport_id, name, CONCAT('$siteUrl', url) as image_url"))
          ->limit($limit, $offset)->get()->getResult(Sport::class);
    }
}
