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
      <h1>
        <?=lang('App.enrol_student')?>
      </h1>
    </div>
  </div>

  <form hx-post="<?=url_to('AdminPortal\Enrollment::enrollUserWithoutEmail')?>" hx-swap="outerHTML" class="col-12 col-md col-lg-7">
    <?=csrf_field()?>

    <?php if (session('error')): ?>
    <div class="alert alert-danger mb-4">
      <?=session('error')?>
    </div>
    <?php endif ?>


    <div class="row">
      <div class="mb-4 col-12">
        <?=validated_form_input(
            'student_name',
            'student_name',
            lang('App.student_name'),
            set_value('name'),
            'text'
        )?>
      </div>
      <div class="mb-4 col-6">
        <?=validated_form_input(
            'student_phone',
            'student_phone',
            lang('App.student_phone'),
            set_value('student_phone'),
            'number'
        )?>
      </div>
      
      <div class="mb-4 col-6">
        <?=validated_form_input(
            'student_dob',
            'student_dob',
            lang('Auth.dob'),
            set_value('dob'),
            'date',
        )?>
      </div>
      <div class="mb-4 col-12">
          <legend class="text-body fs-6 mb-2">
            <?=lang('Auth.gender')?>
          </legend>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="student_gender" id="inlineRadio1" value="Male" checked="checked" required>
            <label class="form-check-label" for="inlineRadio1">
              <?=lang('Auth.gender.male')?>
            </label>
          </div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="student_gender" id="inlineRadio2" value="Female" required>
            <label class="form-check-label" for="inlineRadio2">
              <?=lang('Auth.gender.female')?>
            </label>
          </div>
      </div>
    </div>
          
    <div class="mb-3"></div>
    <span class="col-12"><?=lang('App.optional'); echo ':'?></span>
    
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
      <duration-input id="min_duration" name="min_duration" data-classes-per-week="<?=$numTimings ?>"
        data-label="<?=lang('App.enrol_duration')?>" <?=$enrolDuration ?>>
      </duration-input>
    </div>

    <button class="btn btn-success ms-auto" type="submit">
      <?= lang('App.enrol_student')?>
    </button>
  </form>



</div>

<script src="/js/class_duration.js"></script>
<script>
  function updateNumClasses(elem) {
    const classesPerWeek = document.querySelector(`#class_id option[value="${elem.value}"]`).dataset.classesPerWeek;
    document.querySelector('#min_duration').dataset.classesPerWeek = classesPerWeek;
  }
</script>

<?= $this->endSection('content'); ?>
