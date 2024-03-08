<?php

namespace App\Controllers\AdminPortal;

use App\Models\AcademyModel;
use App\Models\ClassModel;
use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourcePresenter;
use Exception;

class User extends ResourcePresenter
{
    /* protected $modelName = '\App\Models\User'; */
    protected UserModel $users;

    public function __construct()
    {
        $this->users = auth()->getProvider();
    }

    public function index(): string
    {
        throw new Exception("Not Implemented", 1);
    }

    public function indexStudents(): string
    {
        $academyId = $this->request->getGet('academy');
        $classId = $this->request->getGet('class');

        if (! auth()->user()->can('students.access') || ($academyId === null && $classId === null)) {
            return view('errors/html/error_404', [
              'message' => lang('App.not_found.class1')
            ]);
        }

        if ($classId !== null) {
            $academyId = null;
        }

        $students = $this->users;

        $academy = null;
        if ($academyId !== null) {
            $academy = (new AcademyModel())->find($academyId);
        }
        $class = null;
        if ($classId !== null) {
            $class = (new ClassModel())->includeOwnerId()->find($classId);
        }

        $userId = auth()->id();
        if (($class?->owner_id ?? $userId) !== $userId || ($academy?->owner_id ?? $userId) !== $userId) {
            return view('errors/html/error_404', [
              'message' => lang('App.not_found.class2')
            ]);
        }

        if ($classId === null) {
            $students = $students->whereEnrolledInAcademy($academyId);
        } else {
            $students = $students->whereEnrolledInClass($classId);
        }

        $students = $students->findAll();

        return view('user/students', ['students' => $students]);
    }

    public function indexCoaches(): string
    {
        if (! auth()->user()->can('coaches.access')) {
            return view('errors/html/error_404', [
              'message' => lang('App.not_found.class1')
            ]);
        }

        $coaches = $this->users->coaches()->where('academies.owner_id', auth()->id())->findAll();

        return view('user/coaches', ['coaches' => $coaches]);
    }

    // POST
    public function registerCoach(): ResponseInterface|string
    {
        if (! auth()->user()->can('coaches.register')) {
            return view('errors/html/error_404', [
              'message' => lang('App.not_found.class1')
            ]);
        }

        $academyId = $this->request->getPost('academy_id');
        $academy = (new AcademyModel())->find($academyId);

        if (auth()->id() !== $academy->owner_id) {
            return view('errors/html/error_404', [
              'message' => lang('App.not_found.class1')
            ]);
        }

        $coachEmail = $this->request->getPost('email');
        $coach = $this->users->findByCredentials(['email' => $coachEmail]);
        if ($coach !== null) {
            // coach user exists, register it in this academy

            $sql = $this->users->db->table('academy_coaches')->setData([
              'academy_id' => $academyId,
              'coach_id' => $coach->id,
            ])->getCompiledUpsert();
            log_message('debug', "sql: $sql");
            $result =
              $this->users->db->table('academy_coaches')->ignore()->insert([
                'academy_id' => $academyId,
                'coach_id' => $coach->id,
              ]);

            if ($result) {
                return redirect()
                    ->setHeader('HX-Redirect', url_to('AdminPortal\User::indexCoaches'))
                    ->with('message', lang(
                        'App.register_coach.success',
                        [$coach->name, $academy->name]
                    ));
            } else {
                return redirect()
                    ->setHeader('HX-Redirect', url_to('AdminPortal\User::indexCoaches'))
                    ->with('error', lang(
                        'App.register_coach.error'
                    ), [$coach->name, $academy->name]);
            }

        } else {
            // coach user does not exist, register new user

            return view('user/ajax_register_coach', [ 'register' => true, 'coach' => null]);
        }
    }

    public function show($id = null): string
    {
        throw new Exception("Not Implemented", 1);
    }


}
