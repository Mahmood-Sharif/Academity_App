<?php

namespace App\Controllers\AdminPortal;

use App\Entities\User as AppUser;
use App\Models\AcademyModel;
use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourcePresenter;
use CodeIgniter\Shield\Validation\ValidationRules;
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

    public function indexCoaches(): string
    {
        if (! auth()->user()->can('coaches.access')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $coaches = $this->users->coaches()->where('academies.owner_id', auth()->id())->findAll();
        foreach ($coaches as $coach) {
            $coach->academiesObj = $this->users->academiesOfCoach($coach->id, auth()->id());
        }

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
                        'App.register_coach.error',
                        [$coach->name, $academy->name]
                    ));
            }

        } else {
            // coach user does not exist, register new user
            // $coach = $this->request->getPost(auth()->getProvider()->getValidationRules());
            return view('user/ajax_register_coach', [
                // 'coach' => $coach,
            ]);
        }
    }

    // GET
    public function removeCoach(): ResponseInterface|string
    {
        // TODO: check classes the coach is assigned to

        $coachId = $this->request->getGet('coach_id');
        $academyId = $this->request->getGet('academy_id');

        $academy = (new AcademyModel())->find($academyId);
        $coach = $this->users->find($coachId);

        if (auth()->id() !== $academy?->owner_id) {
            return $this->response->setHeader('HX-Retarget', 'html')->setBody(
                view('errors/html/production', [
                    'errorCode' => lang('App.unauthorized'),
                    'message' => lang('Security.disallowedAction')
                ])
            );
        }

        $result = $this->users->db->table('academy_coaches')->delete([
            'coach_id' => $coachId,
            'academy_id' => $academyId,
        ]);

        if ($result) {
            return redirect()
                ->route('AdminPortal\User::indexCoaches')
                ->with('message', lang(
                    'App.remove_coach.success',
                    [$coach->name, $academy->name]
                ));
        } else {
            return redirect()
                ->route('AdminPortal\User::indexCoaches')
                ->with('error', lang(
                    'App.remove_coach.error',
                    [$coach->name, $academy->name]
                ));
        }
    }

    /**
     * @param mixed $id
     */
    public function showOwner(): string
    {
        $user = auth()->user();

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

    public function changePassword(): ResponseInterface
    {
        $oldPassword = $this->request->getPost('password');
        $newPassword = $this->request->getPost('new_password');
        $newPasswordConfirm = $this->request->getPost('confirm_password');

        $user = auth()->user();
        $users = auth()->getProvider();

        $validation = auth()->check(['email' => $user->getEmail(), 'password' => $oldPassword]);
        if (!$validation->isOK()) {
            return redirect()->route('change_password')->with('error', lang('Auth.error.cred'));
        }

        if ($newPassword != $newPasswordConfirm) {
            return redirect()->route('change_password')->with('error', lang('Auth.error.new_match'));
        }

        if (!$this->validateData(
            ['password' => $newPassword],
            ['password' => (new ValidationRules())->getRegistrationRules()['password']],
        )) {
            return redirect()->route('change_password')->with('error', $this->validator->getError('password'));
        }

        try {
            $user->setPassword($newPassword);
            $users->save($user);
            return redirect()->route('AdminPortal\User::showOwner')->with('message', lang('Auth.password_success'));
        } catch (\Throwable $th) {
            return redirect()->route('change_password')->with('error', lang('Auth.error.change'));
        }
    }

}
