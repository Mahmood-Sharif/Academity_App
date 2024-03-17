<?php

namespace App\Models;

use CodeIgniter\Database\RawSql;
use CodeIgniter\Model;

class ClassModel extends Model
{
    protected $table = 'classes';
    protected $primaryKey = 'class_id';

    protected $allowedFields = [
        'class_name',
        'min_age',
        'max_age',
        'academy_id',
        'max_capacity',
        'min_duration',
        'max_duration',
        'coach_id'
    ];

    protected $validationRules = [
      'class_name'   => 'string|required|min_length[3]|max_length[100]',
      'min_age'      => 'integer|required|is_natural_no_zero',
      'max_age'      => 'integer|required|is_natural_no_zero',
      'max_capacity' => 'integer|required|is_natural_no_zero',
      'min_duration' => 'integer|required|is_natural_no_zero',
      // 'max_duration' => 'integer|required|is_natural_no_zero',
      'coach_id'     => 'integer|required|is_natural_no_zero',
    ];
    protected $validationMessages = [
      'timings' => [
        'valid_json' => 'Rules.class.timings',
      ]
    ];

    protected $returnType = \App\Entities\ClassEntity::class;

    public function includePrice(): ClassModel
    {
        return $this
            ->join('prices', 'classes.class_id = prices.class_id AND prices.end_time IS NULL', 'left')
            ->where('IFNULL(prices.start_time, 0) < CURRENT_TIMESTAMP')
            ->select('classes.*')
            ->select('prices.price');
    }

    public function upsertPrice(int $classId, string $price, int|null $offerId = null): bool
    {
        $this->db->transStart();
        // close previous price
        $this->db->table('prices')
            ->where('class_id', $classId)
            ->where('end_time', null)
            ->update(['end_time' => new RawSql('CURRENT_TIMESTAMP')]);
        // insert new price
        $this->db->table('prices')->insert([
            'class_id' => $classId,
            'price'    => $price,
            'offer_id' => $offerId,
            'start_time' => new RawSql('CURRENT_TIMESTAMP'),
            'end_time' => null,
        ]);
        $this->db->transComplete();

        return $this->db->transStatus();
    }

    public function includeOwnerId(): ClassModel
    {
        return $this->join('academies', 'classes.academy_id = academies.academy_id')
                    ->select('classes.*')
                    ->select('academies.owner_id');
    }

    public function limitByOwner(int $id): ClassModel
    {
        return $this->join('academies', 'classes.academy_id = academies.academy_id')
                    ->where('academies.owner_id', $id)
                    ->select('classes.*')
                    ->select('academies.owner_id');
    }
}
