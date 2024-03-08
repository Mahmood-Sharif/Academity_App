<?php

use CodeIgniter\HTTP\URI;
use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

// Root route. for now redirect to admin portal
$routes->addRedirect('/', 'en/admin-portal');
$routes->addRedirect('admin-portal', 'en/admin-portal');

// Admin portal Auth routes: login*, register, logout, auth/a*
$routes->group('{locale}/admin-portal', static function ($routes) {
    service('auth')->routes($routes);
});

// Admin portal routes
$routes->group('{locale}/admin-portal', ['filter' => 'group:admin,superadmin'], static function ($routes) {
    $routes->get('/', 'AdminPortal\Controller::dashboard', ['as' => 'dashboard']);
    $routes->presenter('my-academies', ['controller' => 'AdminPortal\Academy']);
});

$routes->get('change-locale/(:segment)', static function ($locale) {
    $url = new URI(previous_url());
    if ($url->getSegment(1) == 'en' || $url->getSegment(1) == 'ar') {
        $url = $url->setSegment(1, $locale);
    }
    return redirect()->to($url);
});

// API Routes
$routes->post('api/login', 'Api\Login::loginUser'); // does not require token

// all routes inside the function are prefixed with 'api'.
// e.g. /api/test, /api/login
$routes->group('api', /*['filter' => 'tokens'],*/ static function ($routes) {

    // example route generates all HTTP verbs (get, post, put, patch, delete)
    $routes->resource('test', ['controller' => 'Api\Test']);

    // login api
    $routes->get('login-test', 'Api\Login::loginTest');
    // sports api
    $routes->resource('sport', ['controller' => 'Api\Sport']);
    // New route for fetching academies by sport ID
    $routes->get('academies/sport/(:num)', 'Api\Academy::academiesBySport/$1');
    // Academy API
    $routes->resource('academies', ['controller' => 'Api\Academy']);
    // app/Config/Routes.php
    $routes->get('academies', ['controller' => 'Api\Academy']);
    // app/Config/Routes.php
    $routes->get('academy/(:num)/classes', 'Api\Academy::classes/$1');


});
