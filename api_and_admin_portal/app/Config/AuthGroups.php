<?php

declare(strict_types=1);

/**
 * This file is part of CodeIgniter Shield.
 *
 * (c) CodeIgniter Foundation <admin@codeigniter.com>
 *
 * For the full copyright and license information, please view
 * the LICENSE file that was distributed with this source code.
 */

namespace Config;

use CodeIgniter\Shield\Config\AuthGroups as ShieldAuthGroups;

class AuthGroups extends ShieldAuthGroups
{
    /**
     * --------------------------------------------------------------------
     * Default Group
     * --------------------------------------------------------------------
     * The group that a newly registered user is added to.
     */
    public string $defaultGroup = 'user';

    /**
     * --------------------------------------------------------------------
     * Groups
     * --------------------------------------------------------------------
     * An associative array of the available groups in the system, where the keys
     * are the group names and the values are arrays of the group info.
     *
     * Whatever value you assign as the key will be used to refer to the group
     * when using functions such as:
     *      $user->addGroup('superadmin');
     *
     * @var array<string, array<string, string>>
     *
     * @see https://codeigniter4.github.io/shield/quick_start_guide/using_authorization/#change-available-groups for more info
     */
    public array $groups = [
        'superadmin' => [
            'title'       => 'Super Admin',
            'description' => 'Complete control of the site.',
        ],
        'admin' => [
            'title'       => 'Admin',
            'description' => 'Academy Owners',
        ],
        'developer' => [
            'title'       => 'Developer',
            'description' => 'Site programmers.',
        ],
        'coach' => [
            'title'       => 'Coach',
            'description' => 'General users of the site. Often customers.',
        ],
        'user' => [
            'title'       => 'User',
            'description' => 'General users of the site. Often customers.',
        ],
        'beta' => [
            'title'       => 'Beta User',
            'description' => 'Has access to beta-level features.',
        ],
    ];

    /**
     * --------------------------------------------------------------------
     * Permissions
     * --------------------------------------------------------------------
     * The available permissions in the system.
     *
     * If a permission is not listed here it cannot be used.
     */
    public array $permissions = [
        'superadmin.settings'  => 'Can access the main site settings',
        'users.manage-admins'  => 'Can manage other admins',
        'users.create'         => 'Can create new non-admin users',
        'users.edit'           => 'Can edit existing non-admin users',
        'users.delete'         => 'Can delete existing non-admin users',
        'beta.access'          => 'Can access beta-level features',

        'admin.access'         => 'Can access the admin portal',

        'academies.create'     => 'Can create (register) academies in the system',
        'academies.access'     => 'Can access (own) academies details',
        'academies.edit'       => 'Can edit (own) academies details',
        'academies.delete'     => 'Can delete (own) academies from the system',

        'classes.register'     => 'Can register in classes',
        'classes.create'       => 'Can create classes in (own) academies',
        'classes.access'       => 'Can access admin details of classes in (own) academies',
        'classes.edit'         => 'Can edit classes in (own) academies',
        'classes.delete'       => 'Can delete classes from (own) academies',

        'enrollments.create'   => 'Can enrol a student in a class',
        'enrollments.access'   => 'Can access enrollment details of student in (own) academies',
        'enrollments.edit'     => 'Can edit enrollment in (own) academies',
        'enrollments.unenrol'  => 'Can unenrol student from (own) academies',

        'students.create'      => 'Can create student profiles',
        'students.access'      => 'Can access details of student in (own) academies',
        'students.edit'        => 'Can edit student profiles in (own) academies',
        'students.delete'      => 'Can delete student profiles from (own) academies',

        'coaches.register'     => 'Can register a coach in (own) academies',
        'coaches.access'       => 'Can access details of coaches in (own) academies',
        'coaches.unregister'   => 'Can unregister coaches from (own) academies',

        'announcements.access' => 'Can access announcements for (own) academies',
        'analytics.access'     => 'Can access analytics for (own) academies',
        'offers.access'        => 'Can access offers for (own) academies',
        'accounting.access'    => 'Can access accounting for (own) academies',
    ];

    /**
     * --------------------------------------------------------------------
     * Permissions Matrix
     * --------------------------------------------------------------------
     * Maps permissions to groups.
     *
     * This defines group-level permissions.
     */
    public array $matrix = [
        'superadmin' => [
            'admin.*',
            'users.*',
            'beta.*',
            'academies.*',
            'classes.*',
            'enrollments.*',
            'students.*',
            'coaches.*',
            'announcements.*',
            'analytics.*',
            'offers.*',
            'accounting.*',
        ],
        'admin' => [
            'admin.access',
            'beta.access',

            'academies.access',
            'academies.create',
            'academies.edit',
            'academies.delete',

            'classes.*',
            'enrollments.*',
            'students.*',

            'coaches.*',

            'announcements.access',
            'analytics.access',
            'offers.access',
            'accounting.access',
        ],
        'developer' => [
            'admin.access',
            'admin.settings',
            'users.create',
            'users.edit',
            'beta.access',
        ],
        'user' => [
            'students.create',
            'classes.register',
        ],
        'beta' => [
            'beta.access',
        ],
    ];
}
