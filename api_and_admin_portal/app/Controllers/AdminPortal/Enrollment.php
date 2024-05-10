<?php

namespace App\Controllers\AdminPortal;

use App\Entities\Enrollment as AppEnrollment;
use App\Models\AcademyModel;
use App\Models\ClassModel;
use App\Models\EnrollmentModel;
use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourcePresenter;
use DateInterval;
use DateTime;
use DateTimeImmutable;
use DateTimeZone;

class Enrollment extends ResourcePresenter
{
    protected $modelName = '\App\Models\EnrollmentModel';
    /* @var EnrollmentModel $model */
    protected $model;

    public function index(): string
    {
        if (! auth()->user()->can('students.access')) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $academyId = $this->request->getGet('academy');
        $classId = $this->request->getGet('class');
        if (empty($academyId)) {
            $academyId = null;
        }
        if (empty($classId)) {
            $classId = null;
        }
        $showPast = $this->request->getGet('past') !== null;

        if ($classId !== null) {
            $academyId = null;
        }

        /** @var UserModel $users */
        $users = auth()->getProvider();
        $students = $users;

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
            $academyId = $class->academy_id;
        } elseif ($academyId !== null) {
            $students = $students->whereEnrolledInAcademy($academyId);
        } else {
            $students = $students->whereInOwnerAcademies($userId);
        }

        $students = $students->select('enrollments.enrollment_id, enrollments.start_date, enrollments.end_date');

        if (!$showPast) {
            $date = new DateTime('now', new DateTimeZone('Asia/Bahrain'));
            $students = $students->where("enrollments.end_date > '{$date->format('Y-m-d')}'");
        }

        $academies = key_array(
            fn ($a) => [$a['academy_id'], $a['name']],
            [
                ['academy_id' => null, 'name' => lang('App.all_academies')],
                ...(new AcademyModel())->asArray()->findAcademiesForOwner(auth()->id())
            ]
        );

        $classes = key_array(
            fn ($a) => [$a['class_id'], $a['class_name']],
            [
                ['class_id' => null, 'class_name' => lang('App.all_classes')],
                ...(new ClassModel())->includeOwnerId()
                    ->where('owner_id', auth()->id())
                    ->when($academyId !== null, fn ($builder) => $builder->where('classes.academy_id', $academyId))
                    ->asArray()
                    ->findAll()
            ]
        );

        return view('enrollment/students', [
            'students' => $students->paginate(20),
            'pager' => $students->pager,
            'academies' => $academies,
            'classes' => $classes,
            'academyId' => $academyId ?? $class?->academy_id,
            'classId' => $classId,
            'past' => $showPast,
        ]);
    }

    public function show($id = null): string
    {
        $enrollment = $this->model->select()->includeStudentName()->includeClassName()->find($id);
        return view('enrollment/enrollment', ['enrollment' => $enrollment]);
    }

    // show edit form
    public function edit($id = null): string
    {
        $enrollment = $this->model->select()->includeStudentName()->includeClassName()->find($id);
        $class = (new ClassModel())->includeOwnerId()->find($enrollment?->class_id);
        if (! auth()->user()->can('enrollments.edit') || auth()->id() !== $class?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $classes = (new ClassModel())->limitByOwner(auth()->id())->findAll();

        return view('enrollment/create_edit', [
            'type' => 'edit',
            'classes' => key_array(fn ($class) => [$class->class_id, $class->class_name], $classes),
            'enrollment' => $enrollment,
            'errors' => [],
        ]);
    }

    // perform update
    public function update($id = null): ResponseInterface|string
    {
        /** @var AppEnrollment $enrollment */
        $enrollment = $this->model->select()->includeStudentName()->includeClassName()->find($id);
        $class = (new ClassModel())->includeOwnerId()->find($enrollment?->class_id);
        if (! auth()->user()->can('enrollments.edit') || auth()->id() !== $class?->owner_id) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        if (! $this->validate(['end_date' => 'required|valid_date'])) {
            $classes = (new ClassModel())->limitByOwner(auth()->id())->findAll();

            return view('enrollment/create_edit', [
                'type' => 'edit',
                'classes' => key_array(fn ($class) => [$class->class_id, $class->class_name], $classes),
                'enrollment' => $enrollment,
                'errors' => $this->validator->getErrors(),
            ]);
        }

        $result = $this->model->update($id, [
            'end_date' => $this->validator->getValidated()['end_date']
        ]);

        $flashData = [];
        if ($result) {
            $flashData = ['message', lang('App.enrollment_upd.success')];
        } else {
            $flashData = ['error', lang('App.enrollment_upd.error')];
        }

        return redirect()->route('AdminPortal\Enrollment::show', [$id])->with(...$flashData);
    }

    // show create form
    public function new(): string
    {
        $classId = $this->request->getGet('class_id');
        $class = (new ClassModel())->includeOwnerId()->includeClassesPerWeek()->find((int)$classId);


        if (! auth()->user()->can('enrollments.create') || !empty($classId) && (auth()->id() !== $class?->owner_id)) {
            return view('errors/html/production', [
              'errorCode' => lang('App.unauthorized'),
              'message' => lang('Security.disallowedAction')
            ]);
        }

        $academies = key_array(
            fn ($academy) => [$academy->academy_id, $academy->name],
            (new AcademyModel())->findAcademiesForOwner(auth()->id())
        );

        $classes = (new ClassModel())->limitByOwner(auth()->id())->includeClassesPerWeek()->findAll();
        $classesMap = key_array(
            fn ($class) => [$class->class_id, [
                'text' => $class->class_name,
                'attributes' => "data-classes-per-week=\"$class->classes_per_week\"",
            ]],
            $classes
        );

        return view('enrollment/enrol_student', [
            'academies' => $academies,
            'classes' => $classesMap,
            'classId' => $classId,
            'academyId' => $class?->academy_id,
            'numTimings' => $class?->classes_per_week ?? $classes[0]->classes_per_week
        ]);
    }

    // perform create
    public function create(): ResponseInterface|string
    {
        $email = $this->request->getPost('email');
        $classId = $this->request->getPost('class_id');
        $enrollmentDuration = $this->request->getPost('min_duration');

        $class = (new ClassModel())
            ->includeOwnerId()
            ->includeClassesPerWeek()
            ->find((int)$classId);
        $numEnrollments = (new ClassModel())
            ->includeNumEnrollments()
            ->find((int)$classId)
            ->num_enrollments;

        if (!auth()->user()->can('enrollments.create') || $class === null || auth()->id() !== $class->owner_id) {
            return redirect()
                ->setHeader('HX-Redirect', url_to('AdminPortal\Enrollment::new') . '?class_id=' . $classId)
                ->withInput()
                ->with('error', lang('Security.disallowedAction'));
        }

        if ($numEnrollments >= $class->max_capacity) {
            return redirect()
                ->setHeader('HX-Redirect', url_to('AdminPortal\Enrollment::new') . '?class_id=' . $classId)
                ->withInput()
                ->with('error', lang('App.enrol_student.max'));
        }

        $student = auth()->getProvider()->findByCredentials(['email' => $email]);
        if ($student === null) {
            return redirect()
                ->setHeader('HX-Redirect', url_to('AdminPortal\Enrollment::new') . '?class_id=' . $classId)
                ->withInput()
                ->with('error', lang('App.enrol_student.help'));
        }

        $start_date = new DateTimeImmutable('now', new DateTimeZone('Asia/Bahrain'));
        $weeks = ceil($enrollmentDuration / $class->classes_per_week);
        $end_date = $start_date->add(new DateInterval("P{$enrollmentDuration}W"));

        $existingEnrollment = $this->model
        ->where('student_id', $student->id)
        ->where('class_id', $classId)
        ->where("end_date > '{$start_date->format(DateTimeImmutable::ATOM)}'")
        ->first();
        if ($existingEnrollment) {
            return redirect()
                ->setHeader('HX-Redirect', url_to('AdminPortal\Enrollment::show', $existingEnrollment->enrollment_id))
                ->with('error', lang('App.enrol_student.exists'));

        }

        $insertId = $this->model->insert([
            'student_id' => $student->id,
            'class_id' => $classId,
            'start_date' => $start_date->format(DateTimeImmutable::ATOM),
            'end_date' => $end_date->format(DateTimeImmutable::ATOM),
        ], true);

        if ($insertId) {
            return redirect()
                ->setHeader('HX-Redirect', url_to('AdminPortal\Enrollment::show', $insertId))
                ->with('message', lang('App.enrol_student.success', [$student->name, $class->class_name]));
        } else {
            return redirect()
                ->setHeader('HX-Redirect', url_to('AdminPortal\Enrollment::new') . '?class_id=' . $classId)
                ->withInput()
                ->with('error', lang('App.enrol_student.error'));
        }
    }

    /** AJAX remove confirm modal */
    public function remove($id = null): string
    {
        $enrollment = $this->model->select()->includeClassName()->includeStudentName()->find($id);
        $class = (new ClassModel())->includeOwnerId()->find($enrollment?->class_id);
        if (! auth()->user()->can('enrollments.unenrol') || $class?->owner_id !== auth()->id()) {
            return view('ajax_message_modal', [
                'title' => lang('App.unenrol'),
                'body'  => lang('Security.disallowedAction'),
            ]);
        }

        return view('enrollment/ajax_unenrol_modal', [
          'error'   => false,
          'enrollment' => $enrollment
        ]);
    }

    /** AJAX delete and respond with modal */
    public function delete($id = null): string
    {
        $enrollment = $this->model->select()->includeClassName()->includeStudentName()->find($id);
        $class = (new ClassModel())->includeOwnerId()->find($enrollment?->class_id);
        if (! auth()->user()->can('enrollments.unenrol') || $class?->owner_id !== auth()->id()) {
            return view('ajax_message_modal', [
              'title' => lang('App.unenrol'),
              'body'  => lang('Security.disallowedAction')
            ]);
        }

        $date = new DateTime('now', new DateTimeZone('Asia/Bahrain'));
        $result = $this->model->update($id, ['end_date' => $date->format('Y-m-d')]);

        if ($result) {
            return view('ajax_message_modal', [
              'title'     => lang('App.unenrol'),
              'body'      => lang('App.unenrol.success', [$enrollment->student_name, $enrollment->class_name]),
              'action'    => lang('App.back.students'),
              'actionUrl' => url_to('AdminPortal\Enrollment::index'),
            ]);
        } else {
            return view('ajax_message_modal', [
                'title' => lang('App.unenrol'),
                'body'  => lang('App.unenrol.error'),
            ]);
        }
    }
}
