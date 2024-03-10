<?php

namespace App\Models;

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

    public function includeImageUrl(): SportModel
    {
        $siteUrl = site_url();
        return $this
                ->join('media', 'sports.media_id = media.media_id')
                ->select('sports.*')
                ->select("CONCAT('$siteUrl', url) as image_url");
    }

}
