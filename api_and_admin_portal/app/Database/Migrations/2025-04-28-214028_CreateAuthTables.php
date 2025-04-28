<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateAuthTables extends Migration
{
    public function up()
    {
              // Users Table
              $this->forge->addField([
                'id' => ['type' => 'INT', 'unsigned' => true, 'auto_increment' => true],
                'email' => ['type' => 'VARCHAR', 'constraint' => 255],
                'username' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
                'password_hash' => ['type' => 'VARCHAR', 'constraint' => 255],
                'reset_hash' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
                'reset_at' => ['type' => 'DATETIME', 'null' => true],
                'reset_expires' => ['type' => 'DATETIME', 'null' => true],
                'activate_hash' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
                'status' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
                'status_message' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
                'active' => ['type' => 'BOOLEAN', 'default' => false],
                'force_pass_reset' => ['type' => 'BOOLEAN', 'default' => false],
                'created_at' => ['type' => 'DATETIME', 'null' => true],
                'updated_at' => ['type' => 'DATETIME', 'null' => true],
                'deleted_at' => ['type' => 'DATETIME', 'null' => true],
            ]);
            $this->forge->addPrimaryKey('id');
            $this->forge->addUniqueKey('email');
            $this->forge->createTable('users', true);
    
            // Auth Identities Table
            $this->forge->addField([
                'id' => ['type' => 'INT', 'unsigned' => true, 'auto_increment' => true],
                'user_id' => ['type' => 'INT', 'unsigned' => true],
                'type' => ['type' => 'VARCHAR', 'constraint' => 255],
                'secret' => ['type' => 'VARCHAR', 'constraint' => 255],
                'secret2' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
                'expires' => ['type' => 'DATETIME', 'null' => true],
                'extra' => ['type' => 'TEXT', 'null' => true],
            ]);
            $this->forge->addPrimaryKey('id');
            $this->forge->addForeignKey('user_id', 'users', 'id', 'CASCADE', 'CASCADE');
            $this->forge->createTable('auth_identities', true);
    
            // Auth Logins Table
            $this->forge->addField([
                'id' => ['type' => 'BIGINT', 'unsigned' => true, 'auto_increment' => true],
                'ip_address' => ['type' => 'VARBINARY', 'constraint' => 16],
                'email' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
                'user_id' => ['type' => 'INT', 'unsigned' => true, 'null' => true],
                'date' => ['type' => 'DATETIME', 'null' => true],
                'success' => ['type' => 'BOOLEAN'],
            ]);
            $this->forge->addPrimaryKey('id');
            $this->forge->createTable('auth_logins', true);
    
            // Auth Remember Tokens
            $this->forge->addField([
                'id' => ['type' => 'BIGINT', 'unsigned' => true, 'auto_increment' => true],
                'selector' => ['type' => 'VARCHAR', 'constraint' => 255],
                'hashedValidator' => ['type' => 'VARCHAR', 'constraint' => 255],
                'user_id' => ['type' => 'INT', 'unsigned' => true],
                'expires' => ['type' => 'DATETIME'],
            ]);
            $this->forge->addPrimaryKey('id');
            $this->forge->addForeignKey('user_id', 'users', 'id', 'CASCADE', 'CASCADE');
            $this->forge->createTable('auth_remember_tokens', true);
        }

    public function down()
    {
        $this->forge->dropTable('auth_remember_tokens');
        $this->forge->dropTable('auth_logins');
        $this->forge->dropTable('auth_identities');
        $this->forge->dropTable('users');

    }
}
