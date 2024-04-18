<?php

namespace App\Controllers\AdminPortal\Shield;

use Cassandra\Exception\ValidationException;
use CodeIgniter\Events\Events;
use CodeIgniter\HTTP\RedirectResponse;
use CodeIgniter\Shield\Controllers\RegisterController;

class Register extends RegisterController
{
    /**
     * Displays the registration form.
     *
     * @return RedirectResponse|string
     */
    public function registerView(): RedirectResponse|string
    {
        // Only superadmin (us) can register owner users for now.
        if (!auth()->user()->inGroup('superadmin')) {
            return redirect()->to('/' + $this->request->getLocale());
        }

        // Check if registration is allowed
        if (! setting('Auth.allowRegistration')) {
            return redirect()->back()->withInput()
                ->with('error', lang('Auth.registerDisabled'));
        }

        /** @var Session $authenticator */
        $authenticator = auth('session')->getAuthenticator();

        // If an action has been defined, start it up.
        if ($authenticator->hasAction()) {
            return redirect()->route('auth-action-show');
        }

        return $this->view(setting('Auth.views')['register']);
    }

    /**
     * Attempts to register the user.
     */
    public function registerAction(): RedirectResponse
    {
        // Only superadmin (us) can register owner users for now.
        if (!auth()->user()->inGroup('superadmin')) {
            return redirect()->to('/' + $this->request->getLocale());
        }

        // Check if registration is allowed
        if (! setting('Auth.allowRegistration')) {
            return redirect()->back()->withInput()
                ->with('error', lang('Auth.registerDisabled'));
        }

        $users = $this->getUserProvider();

        // Validate here first, since some things,
        // like the password, can only be validated properly here.
        $rules = $this->getValidationRules();

        if (! $this->validateData($this->request->getPost(), $rules, [], config('Auth')->DBGroup)) {
            return redirect()->back()->withInput()->with('errors', $this->validator->getErrors());
        }

        // Save the user
        $allowedPostFields = array_keys($rules);
        $user              = $this->getUserEntity();
        $user->fill($this->request->getPost($allowedPostFields));

        // Workaround for email only registration/login
        if ($user->username === null) {
            $user->username = null;
        }

        try {
            $users->save($user);
        } catch (ValidationException $e) {
            return redirect()->back()->withInput()->with('errors', $users->errors());
        }

        // To get the complete user object with ID, we need to get from the database
        $user = $users->findById($users->getInsertID());

        // Add to default group
        // WARN: Add to owner group
        $user->addGroup('user', 'coach', 'admin');

        Events::trigger('register', $user);

        // Set the user active
        $user->activate();

        // Success!
        return redirect()->route('register')->with('message', lang('Auth.registerSuccess'));
    }

}
