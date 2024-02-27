<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Forge;
use CodeIgniter\Database\Migration;

class AddUserAttributes extends Migration
{
    /**
     * @var string[]
     */
    private array $tables;

    public function __construct(?Forge $forge = null)
    {
        parent::__construct($forge);

        /** @var \Config\Auth $authConfig */
        $authConfig   = config('Auth');
        $this->tables = $authConfig->tables;
    }

    public function up(): void
    {
        $fields = [
            'first_name' => ['type' => 'VARCHAR', 'constraint' => '50', 'null' => false],
            'last_name' => ['type' => 'VARCHAR', 'constraint' => '50', 'null' => false],
            'phone' => ['type' => 'INT', 'unsigned' => true, 'null' => false],
            'dob' => ['type' => 'DATE', 'null' => false],
        ];
        $this->forge->addColumn($this->tables['users'], $fields);
    }

    public function down(): void
    {
        $fields = ['first_name', 'last_name', 'phone', 'dob'];
        $this->forge->dropColumn($this->tables['users'], $fields);
    }
}
