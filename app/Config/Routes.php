<?php

use CodeIgniter\HTTP\URI;
use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

// Root route. Academity website
$routes->addRedirect('/', '/en/');
$routes->group('{locale}', static function ($routes) {
    $routes->view('/', 'home/index', ['as' => 'home']);
    $routes->view('about', 'home/about', ['as' => 'home_about']);
    $routes->view('privacy-policy', 'home/privacy', ['as' => 'home_privacy']);
    $routes->view('contact-us', 'home/contact', ['as' => 'home_contact']);
});

$routes->group('{locale}/admin-portal', static function ($routes) {
    // Admin portal Auth routes: login*, register, logout, auth/a*
    service('auth')->routes($routes);

    $routes->group('', ['filter' => 'group:admin,superadmin'], static function ($routes) {
        $routes->get('/', 'AdminPortal\Academy::index', ['as' => 'admin_portal_home']);
        $routes->presenter('my-academies', ['controller' => 'AdminPortal\Academy']);
        $routes->get('classes/by-academy/(:num)', 'AdminPortal\Classes::index/$1');
        $routes->presenter('classes', ['controller' => 'AdminPortal\Classes']);
        $routes->get('class-reg-code/(:num)', 'AdminPortal\Classes::registrationCode/$1');
        $routes->presenter('students', ['controller' => 'AdminPortal\Enrollment']);
        $routes->get('coaches/', 'AdminPortal\User::indexCoaches');
        $routes->get('academy-coaches/', 'AdminPortal\User::academyCoachesInput');
        $routes->post('register-coach/', 'AdminPortal\User::registerCoach');
        $routes->view('register-coach/', 'user/register_coach', ['as' => 'register_new_coach']);
        $routes->get('remove-coach/', 'AdminPortal\User::removeCoach');
        $routes->get('user-profile/(:num)', 'AdminPortal\User::showOwner/$1');
        $routes->get('student-profile/(:num)', 'AdminPortal\User::showStudent/$1');
        $routes->get('coach-profile/(:num)', 'AdminPortal\User::showCoach/$1');
        $routes->get('edit-profile/(:num)', 'AdminPortal\User::edit/$1');
        $routes->get('ajax-class-input', 'AdminPortal\Classes::selectInput');
    });
});

$routes->get('change-locale/(:segment)', static function ($locale) {
    $url = new URI(previous_url());
    if ($url->getSegment(1) == 'en' || $url->getSegment(1) == 'ar') {
        $url = $url->setSegment(1, $locale);
    }
    return redirect()->to($url);
});


// API Routes
// all routes inside the function are prefixed with 'api'.
// e.g. /api/test, /api/login
$routes->group('api', static function ($routes) {

    // no token required
    $routes->post('login', 'Api\Login::loginUser');
    $routes->post('register', 'Api\Login::registerUser');

    $routes->group('', ['filter' => 'tokens'], static function ($routes) {
        // example resource route generates all HTTP verbs (get, post, put, patch, delete)
        $routes->resource('test', ['controller' => 'Api\Test']);

        // user profiles api
        $routes->get('login-test', 'Api\Login::loginTest');
        $routes->post('logout', 'Api\Login::logoutUser');
        $routes->get('user-profile', 'Api\Login::getUserProfile');
        $routes->post('profile-edit', 'Api\Login::updateUserProfile');

        // users app academies api
        $routes->get('sport', 'Api\Sport::index');
        $routes->get('academies/sport/(:num)', 'Api\Academy::academiesBySport/$1');
        $routes->get('enrolled/academy', 'Api\Academy::getEnrolledAcademiesDetails');
        $routes->get('academy/(:num)/classes', 'Api\Academy::getClassDetails/$1');
        $routes->get('class/prices/(:num)', 'Api\Classes::getClassesWithPrices/$1');
        $routes->post('enrol', 'Api\Classes::enrollWithCode');

        $routes->get('schedule/student', 'Api\Schedule::getScheduleForStudent');
        $routes->get('schedule/coach', 'Api\Schedule::getScheduleForCoach');

        $routes->get('attendance/(:num)', 'Api\Attendance::getAttendanceForClassNow/$1');
        // log attendace qr code
        $routes->post('log-attendance/', 'Api\Attendance::logAttendance');
        // log attendace coaches app
        $routes->post('post-attendance/', 'Api\Attendance::postAttendance');

        // coaches app classes api
        $routes->get('classes/bai', 'Api\Classes::getByAcademyId');
        $routes->get('classes/bci', 'Api\Classes::getByCoachId');
        $routes->resource('classes', ['controller' => 'Api\Classes']);

        // coaches app enrollments api
        $routes->get('enrollments/bci', 'Api\Enrollments::getStudentsByClassId');
        $routes->resource('enrollments', ['controller' => 'Api\Enrollments']);

        // coaches app students api
        $routes->resource('students', ['controller' => 'Api\Students']);

        // coaches app academies api
        $routes->get('academies/bci', 'Api\Academies::byCoach');
        // $routes->resource('academies', ['controller' => 'Api\Academies']);

    });
});
