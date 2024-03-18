<?php

namespace App\Controllers\AdminPortal;

use App\Entities\User as AppUser;
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

        if (! auth()->user()->can('students.access')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        if ($classId !== null) {
            $academyId = null;
        }

        $students = $this->users;

        $academy = null;
        $class = null;
        if ($academyId !== null) {
            $academy = (new AcademyModel())->find($academyId);
        } elseif ($classId !== null) {
            $class = (new ClassModel())->includeOwnerId()->find($classId);
        }

        $userId = auth()->id();
        if (($class?->owner_id ?? $userId) !== $userId || ($academy?->owner_id ?? $userId) !== $userId) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        if ($classId !== null) {
            $students = $students->whereEnrolledInClass($classId);
        } elseif ($academyId !== null) {
            $students = $students->whereEnrolledInAcademy($academyId);
        } else {
            $students = $students->whereInOwnerAcademies($userId);
        }

        $students = $students->findAll();

        return view('user/students', ['students' => $students]);
    }

    public function indexCoaches(): string
    {
        if (! auth()->user()->can('coaches.access')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $coaches = $this->users->coaches()->where('academies.owner_id', auth()->id())->findAll();

        return view('user/coaches', ['coaches' => $coaches]);
    }
    /**
     * @param ?int $academyId
     */
    public function academyCoachesInput(): string
    {
        $academyId = $this->request->getGet('academy_id');
        $academy = (new AcademyModel())->find($academyId);
        if (! auth()->user()->can('coaches.access') || $academy?->owner_id !== auth()->id()) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $coaches = key_array(
            fn ($coach) => [$coach->id, $coach->name],
            $this->users->coaches()->where('academies.academy_id', $academyId)->findAll()
        );
        helper('form');
        return '<div id="academyCoaches" class="mb-3 d-flex align-items-center gap-3">'
            . validated_form_select(
                'coach',
                'coach_id',
                lang('App.main_coach'),
                empty($coaches) ? ['' => lang('App.empty.coaches')] : $coaches,
                null,
                'flex-fill'
            )
            .
            (
                empty($coaches)
            ? '<a href="'.url_to('register_new_coach') . '?academy_id=' . $academyId . '"
                class="btn btn-secondary">'.lang('App.register_coach').'</a>'
            : ''
            ) .'</div>';
    }

    // POST
    public function registerCoach(): ResponseInterface|string
    {
        if (! auth()->user()->can('coaches.register')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $academyId = $this->request->getPost('academy_id');
        $academy = (new AcademyModel())->find($academyId);

        if (auth()->id() !== $academy?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
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
    /**
     * @param mixed $id
     */
    public function showOwner($id = null): string
    {
        if (auth()->id() != $id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $user = $this->users->find($id);

        return view('user/profile', [
            'user' => $user,
            'type' => 'owner'
        ]);
    }

    /**
     * @param mixed $id
     */
    public function showStudent($id = null): string
    {
        if (! auth()->user()->can('students.access')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $user = $this->users->find($id);

        return view('user/profile', [
            'user' => $user,
            'type' => 'student'
        ]);
    }

    /**
     * @param mixed $id
     */
    public function showCoach($id = null): string
    {
        /** @var AppUser $user */
        $user = $this->users->coaches()->find($id);

        if (! auth()->user()->can('coaches.access') || !$user->inGroup('coach')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        return view('user/profile', [
            'user' => $user,
            'type' => 'coach'
        ]);
    }

    public function edit($id = null): string
    {
        throw new Exception("Unimplemented", 1);
    }

}
