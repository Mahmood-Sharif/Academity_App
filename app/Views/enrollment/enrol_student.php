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

  <form hx-post="<?=url_to('AdminPortal\Enrollment::create')?>" hx-swap="outerHTML" class="col-12 col-md col-lg-7">
    <?=csrf_field()?>

    <?php if (session('error')): ?>
    <div class="alert alert-danger mb-4">
      <?=session('error')?>
    </div>
    <?php endif ?>


    <div class="mb-4">
      <?=validated_form_input(
          'studentEmail',
          'email',
          lang('App.student_email'),
          set_value('email'),
          'email'
      )?>
    </div>

    <div class="row mb-4">
      <div class="col">
        <?php
                                                                                                                                                                                                                                    $url = url_to('AdminPortal\Classes::selectInput');
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
