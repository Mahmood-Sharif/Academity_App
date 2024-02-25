<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

// example rest api
$routes->resource('api/test', ['controller' => 'Api\Test']);
