<?php

namespace App\Models;

use CodeIgniter\Model;

class MediaModel extends Model
{
    protected $table = 'media';
    protected $primaryKey = 'media_id';

    protected $allowedFields = [
      'mime_type',
      'url',
    ];

}
