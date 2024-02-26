<?php

namespace App\Models;

use CodeIgniter\Model;

class TransactionModel extends Model
{
    protected $table = 'transaction';
    protected $primaryKey = 'transaction_id';

    protected $allowedFields = [
      'timestamp',
      'amount',
      'transaction_method',
      'transaction_status',
      'enrollment_id',
    ];

}
