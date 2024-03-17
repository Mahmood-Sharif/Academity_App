<?php

// app/Models/PriceModel.php

namespace App\Models;

use CodeIgniter\Model;

class PriceModel extends Model
{
    protected $table = 'prices';
    protected $primaryKey = 'price_id';
    protected $allowedFields = [
      'class_id',
      'price',
      'start_time',
      'end_time',
      'offer_id',
    ];

}
