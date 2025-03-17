<?php

use App\Entities\ClassEntity;

use App\Entities\Academy;

/* @var CodeIgniter\View\View $this */

/* @var int|null $classId */
/* @var int|null $academyId */
/* @var integer $numTimings */
/* @var Academy[] $academies */
/* @var ClassEntity[] $classes */

$academyId = request()->getGet('academy_id');

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
echo lang('App.enrol_student');
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'students';
$this->endSection('sidebarTab');

$enrolDuration = set_value('min_duration') ? ('value="'.set_value('min_duration').'"') : '' ;
?>

<?= $this->section('content'); ?>

<div class="container">
  <div class="d-flex align-items-start">
    <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
      <i class="bi bi-arrow-left-short fs-1"></i>
    </a>
    <div>
      <h1><?=lang('App.enrol_student')?></h1>
    </div>
  </div>

  <form hx-post="<?=url_to('AdminPortal\Enrollment::enrollUserWithoutEmail')?>" hx-swap="outerHTML" class="col-12 col-md col-lg-7">
    <?=csrf_field()?>

    <?php if (session('error')): ?>
    <div class="alert alert-danger mb-4">
      <?=session('error')?>
    </div>
    <?php endif ?>

    <div id="students-container">
      <div class="student-form mb-4">
        <h5><?=lang('App.student_details')?></h5>
        <div class="row">
          <div class="mb-4 col-12">
            <?=validated_form_input('students[0][student_name]', 'student_name', lang('App.student_name'), '', 'text')?>
          </div>
          <div class="mb-4 col-6">
            <?=validated_form_input('students[0][student_phone]', 'student_phone', lang('App.student_phone'), '', 'number')?>
          </div>
          <div class="mb-4 col-6">
            <?=validated_form_input('students[0][student_dob]', 'student_dob', lang('Auth.dob'), '', 'date')?>
          </div>
          <div class="mb-4 col-12">
            <legend class="text-body fs-6 mb-2"><?=lang('Auth.gender')?></legend>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="students[0][student_gender]" value="Male" checked required>
              <label class="form-check-label"><?=lang('Auth.gender.male')?></label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="students[0][student_gender]" value="Female" required>
              <label class="form-check-label"><?=lang('Auth.gender.female')?></label>
            </div>
          </div>
        </div>
      </div>
    </div>

    <button type="button" class="btn btn-secondary mb-4" onclick="addStudentForm()">
      <?=lang('App.add_student')?>
    </button>

    <div class="row mt-2 mb-4">
      <div class="col">
        <?php                                                                                                                                                                                                               $url = url_to('AdminPortal\Classes::selectInput');
          echo validated_form_select(
              'academy_id',
              'academy_id',
              lang('App.select.academy'),
              $academies,
              $academyId ?? set_value('academy_id'),
              attributes: "hx-get='$url' hx-vals=\"js:{academy_id: event.target.value}\" hx-target='#class_id' hx-swap='innerHTML'"
          )?>
      </div>
      <div class="col">
        <?=validated_form_select(
            'class_id',
            'class_id',
            lang('App.select.class'),
            $classes,
            $classId ?? set_value('class_id'),
            attributes: 'onchange="updateNumClasses(this)"',
            optionsType: 'ko'
        )?>
      </div>
    </div>

    <div class="mb-5">
      <duration-input id="min_duration" name="min_duration" data-classes-per-week="<?=$numTimings ?>" data-label="<?=lang('App.enrol_duration')?>"></duration-input>
    </div>

    <button class="btn btn-success ms-auto" type="submit">
      <?= lang('App.enrol_student')?>
    </button>
  </form>
</div>

<script src="/js/class_duration.js"></script>
<script>
  let studentIndex = 1;

  function addStudentForm() {
    const container = document.getElementById('students-container');
    const newForm = document.createElement('div');
    newForm.classList.add('student-form', 'mb-4');
    newForm.innerHTML = `
      <h5><?=lang('App.student_details')?> (${studentIndex + 1})</h5>
      <div class="row">
        <div class="mb-4 col-12">
          <?=validated_form_input('students[${studentIndex}][student_name]', 'student_name', lang('App.student_name'), '', 'text')?>
        </div>
        <div class="mb-4 col-6">
          <?=validated_form_input('students[${studentIndex}][student_phone]', 'student_phone', lang('App.student_phone'), '', 'number')?>
        </div>
        <div class="mb-4 col-6">
          <?=validated_form_input('students[${studentIndex}][student_dob]', 'student_dob', lang('Auth.dob'), '', 'date')?>
        </div>
        <div class="mb-4 col-12">
          <legend class="text-body fs-6 mb-2"><?=lang('Auth.gender')?></legend>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="students[${studentIndex}][student_gender]" value="Male" checked required>
            <label class="form-check-label"><?=lang('Auth.gender.male')?></label>
          </div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="students[${studentIndex}][student_gender]" value="Female" required>
            <label class="form-check-label"><?=lang('Auth.gender.female')?></label>
          </div>
        </div>
      </div>
    `;
    container.appendChild(newForm);
    studentIndex++;
  }
</script>

<?= $this->endSection('content'); ?>
