<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

// root route
$routes->get('/', 'Home::index');

$routes->resource('test', ['controller' => 'Api\Test']);
service('auth')->routes($routes);

// API Routes all routes inside the function are prefixed with 'api'.
// e.g. /api/test, /api/login
$routes->group('api', static function ($routes) {

    // example route generates all HTTP verbs (get, post, put, patch, delete)
    $routes->resource('test', ['controller' => 'Api\Test']);

    // login api
    $routes->post('login', 'Api\Login::loginUser');

});
