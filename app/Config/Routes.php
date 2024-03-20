    <?php

    use CodeIgniter\HTTP\URI;
    use CodeIgniter\Router\RouteCollection;

    /**
     * @var RouteCollection $routes
     */

    // Root route. for now redirect to admin portal
    $routes->addRedirect('/', 'en/admin-portal');
    $routes->addRedirect('admin-portal', 'en/admin-portal');

    $routes->group('{locale}/admin-portal', static function ($routes) {
        // Admin portal Auth routes: login*, register, logout, auth/a*
        service('auth')->routes($routes);

        $routes->group('', ['filter' => 'group:admin,superadmin'], static function ($routes) {
            $routes->get('/', 'AdminPortal\Controller::dashboard', ['as' => 'dashboard']);
            $routes->presenter('my-academies', ['controller' => 'AdminPortal\Academy']);
            $routes->get('classes/by-academy/(:num)', 'AdminPortal\Classes::index/$1');
            $routes->presenter('classes', ['controller' => 'AdminPortal\Classes']);
            $routes->get('students/', 'AdminPortal\User::indexStudents');
            $routes->get('coaches/', 'AdminPortal\User::indexCoaches');
            $routes->post('register-coach/', 'AdminPortal\User::registerCoach');
            $routes->view('register-coach/', 'user/register_coach');
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
        // classes api
        $routes->get('classes/bai', 'Api\Classes::getByAcademyId');

        $routes->resource('classes', ['controller' => 'Api\Classes']);
        // enrollments api
        $routes->get('enrollments/bci', 'Api\Enrollments::getStudentsByClassId');

        $routes->resource('enrollments', ['controller'=> 'Api\Enrollments']);
        // students api
        $routes->resource('students', ['controller'=> 'Api\Students']);
        // academies api
        
        $routes->resource('academies', ['controller'=> 'Api\Academies']);


        $routes->group('', /*['filter' => 'tokens'],*/ static function ($routes) {
            // example resource route generates all HTTP verbs (get, post, put, patch, delete)
            $routes->resource('test', ['controller' => 'Api\Test']);

            $routes->get('login-test', 'Api\Login::loginTest');
            $routes->post('logout', 'Api\Login::logoutUser');
            $routes->resource('sport', ['controller' => 'Api\Sport']);
            $routes->get('academies/sport/(:num)', 'Api\Academy::academiesBySport/$1');
            $routes->resource('academies', ['controller' => 'Api\Academy']);
            $routes->get('academies', ['controller' => 'Api\Academy']);
            $routes->get('academy/(:num)/classes', 'Api\Academy::getClassDetails/$1');
            $routes->get('class/prices/(:num)', 'Api\ClassApi::getClassesWithPrices/$1');
            $routes->get('attendance/(:num)', 'Api\Attendance::getAttendanceForClassNow/$1');
            $routes->get('attendance/(:num)/(:segment)/(:segment)', 'Api\Attendance::getAttendanceBetween/$1/$2/$3');
            $routes->get('schedule/student', 'Api\Schedule::getScheduleForStudent');
            $routes->get('schedule/coach', 'Api\Schedule::getScheduleForCoach');
            $routes->post('attendance', 'Api\Attendance::insertAttendance');
            $routes->delete('attendance/(:num)/(:segment)', 'Api\Attendance::deleteAttendance/$1/$2');
        });
    });
