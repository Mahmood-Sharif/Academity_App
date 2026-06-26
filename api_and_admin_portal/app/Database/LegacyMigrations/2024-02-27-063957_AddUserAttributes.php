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
        $usersTable = $this->tables['users'];

        $fields = [
            'name' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
                'null'       => true,
            ],
            'dob' => [
                'type' => 'DATE',
                'null' => true,
            ],
            'phone' => [
                'type'       => 'VARCHAR',
                'constraint' => '20',
                'null'       => true,
            ],
            'profile_image' => [
                'type'     => 'INT',
                'unsigned' => true,
                'null'     => true,
            ],
            'gender' => [
                'type' => $this->db->getPlatform() === 'SQLite3'
                    ? 'VARCHAR(7) CHECK( gender IN ("Male", "Female") )'
                    : 'ENUM("Male", "Female")',
                'null' => true,
            ],
            'medical_condition' => [
                'type'       => 'VARCHAR',
                'constraint' => '100',
                'null'       => true,
            ],
            'parent_id' => [
                'type'     => 'INT',
                'unsigned' => true,
                'null'     => true,
            ],
        ];

        foreach (array_keys($fields) as $field) {
            if ($this->db->fieldExists($field, $usersTable)) {
                unset($fields[$field]);
            }
        }

        if ($fields !== []) {
            $this->forge->addColumn($usersTable, $fields);
        }

        if ($this->db->fieldExists('profile_image', $usersTable)) {
            $this->forge->addForeignKey('profile_image', 'media', 'media_id', 'SET NULL', 'CASCADE');
        }

        if ($this->db->fieldExists('parent_id', $usersTable)) {
            $this->forge->addForeignKey('parent_id', $usersTable, 'id', 'SET NULL', 'CASCADE');
        }

        $this->forge->processIndexes($usersTable);
    }

    public function down(): void
    {
        $usersTable = $this->tables['users'];

        foreach ([
            "{$usersTable}_profile_image_foreign",
            "{$usersTable}_parent_id_foreign",
        ] as $foreignKey) {
            try {
                $this->forge->dropForeignKey($usersTable, $foreignKey);
            } catch (\Throwable) {
                // Older local databases may have this migration recorded before these FKs existed.
            }
        }

        $fields = array_filter([
            'name',
            'dob',
            'phone',
            'profile_image',
            'gender',
            'medical_condition',
            'parent_id',
        ], fn (string $field): bool => $this->db->fieldExists($field, $usersTable));

        if ($fields !== []) {
            $this->forge->dropColumn($usersTable, $fields);
        }
    }
}
