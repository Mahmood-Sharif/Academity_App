<?php

use CodeIgniter\Pager\Pager;

use App\Entities\User;

/* @var CodeIgniter\View\View $this */
/* @var User[] $students */
/* @var array $academies */
/* @var array $classes */
/* @var Pager $pager */
/* @var int|null $academyId */
/* @var int|null $classId */
/* @var bool $past */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
echo lang('App.students');
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'students';
$this->endSection('sidebarTab');
?>

<?= $this->section('content'); ?>

<div class="container">
  <div class="d-flex align-items-first-baseline">
    <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
      <i class="bi bi-arrow-left-short fs-1"></i>
    </a>
    <div>
      <h1>
        <?=lang('App.students')?>
      </h1>
    </div>
  </div>

  <form action="" method="get">
    <div class="hstack gap-3 mb-3">
      <?=validated_form_select(
          'academy',
          'academy',
          lang('App.academy'),
          $academies,
          $academyId ?? -1,
          '',
          "onchange=\"document.querySelector('#class').value=''; event.target.closest('form').submit();\""
      )?>
      <?=validated_form_select(
          'class',
          'class',
          lang('App.class'),
          $classes,
          $classId ?? -1,
          '',
          "onchange=\"event.target.closest('form').submit();\""
      )?>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" value="true" id="past" name="past"
          onchange="event.target.closest('form').submit();" <?=$past ? 'checked' : '' ?>>
        <label class="form-check-label" for="past">
          <?=lang('App.show_past')?>
        </label>
      </div>
      <?php if ($pager->getPageCount() > 0): ?>
      <div class="hstack gap-2 ms-auto">
        <span>Page:</span>
        <?=$pager->links()?>
      </div>
      <?php endif ?>
      <a href="<?=url_to('AdminPortal\Enrollment::new') . '?class_id=' . $classId  ?>"
        class="btn btn-outline-success ms-auto">
        <?=lang('App.enrol_student')?>
      </a>
    </div>
  </form>

  <table class="table">
    <thead>
      <th scope="col">
        <?=lang('App.student_name')?>
      </th>
      <th scope="col">
        <?=lang('App.classes')?>
      </th>
      <th scope="col">
        <?=lang('App.enrollment_duration')?>
      </th>
      <th scope="col">
        <?=lang('App.actions')?>
      </th>
    </thead>
    <tbody>
      <?php foreach ($students as $student):  ?>
      <tr>
        <td>
          <?= $student->name ?>
        </td>
        <td><?=$student->classes?></td>
        <td><?=$student->start_date . '&ensp;' . lang('App.to') . '&ensp;' . $student->end_date?></td>
        <td>
          <a href="<?=url_to('AdminPortal\Enrollment::show', $student->enrollment_id)?>"
            class="btn btn-outline-success ms-auto">
            <?=lang('App.view')?>
          </a>
        </td>
      </tr>
      <?php endforeach ?>

    </tbody>
  </table>

  <?php if (empty($students)): ?>
  <p class="text-center fs-3 py-3 text-muted">
    <?=lang('App.empty.students')?>
  </p>
  <?php endif ?>


</div>

<?= $this->endSection('content'); ?>
