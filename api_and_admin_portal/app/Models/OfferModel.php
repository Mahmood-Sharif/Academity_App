<?php

namespace App\Models;

use CodeIgniter\Model;

class OfferModel extends Model
{
    protected $table = 'offers';
    protected $primaryKey = 'offer_id';

    protected $allowedFields = [
      'description',
    ];

    protected $returnType = \App\Entities\Offer::class;

}
