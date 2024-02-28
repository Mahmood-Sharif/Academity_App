<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

// Root route. for now redirect to admin portal
$routes->addRedirect('/', 'en/admin-portal');
$routes->addRedirect('admin-portal', 'en/admin-portal');

// Auth routes: login*, register, logout, auth/a*
$routes->group('{locale}/admin-portal', static function ($routes) {
    service('auth')->routes($routes);
});

// Admin portal routes
$routes->group('{locale}/admin-portal', ['filter' => 'session'], static function ($routes) {

    $routes->get('/', 'AdminPortal\Controller::dashboard');
    $routes->presenter('my-academies', ['controller' => 'AdminPortal\Academy']);
});

// API Routes all routes inside the function are prefixed with 'api'.
// e.g. /api/test, /api/login
$routes->group('api', static function ($routes) {

    // example route generates all HTTP verbs (get, post, put, patch, delete)
    $routes->resource('test', ['controller' => 'Api\Test']);

    // login api
    $routes->post('login', 'Api\Login::loginUser');

});
