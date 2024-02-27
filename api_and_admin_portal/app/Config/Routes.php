<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

// Root route. for now redirect to admin portal
$routes->addRedirect('/', 'admin-portal');

// Admin portal routes
$routes->group('admin-portal', static function ($routes) {
    // Auth routes: login*, register, logout, auth/a*
    service('auth')->routes($routes);

    $routes->get('/', 'AdminPortal\Home::index');
});

// API Routes all routes inside the function are prefixed with 'api'.
// e.g. /api/test, /api/login
$routes->group('api', static function ($routes) {

    // example route generates all HTTP verbs (get, post, put, patch, delete)
    $routes->resource('test', ['controller' => 'Api\Test']);

    // login api
    $routes->post('login', 'Api\Login::loginUser');

});
