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
      <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#importModal">
        <?=lang('App.import_students')?>
      </button>
    </div>
  </form>

  <!-- Import Modal -->
  <div class="modal fade" id="importModal" tabindex="-1" aria-labelledby="importModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <form action="<?=url_to('AdminPortal\Enrollment::importStudents')?>" method="post" enctype="multipart/form-data">
          <?=csrf_field()?>
          <div class="modal-header">
            <h5 class="modal-title" id="importModalLabel"><?=lang('App.import_students')?></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="excelFile" class="form-label"><?=lang('App.select_excel_file')?></label>
              <input type="file" class="form-control" id="excelFile" name="excel_file" accept=".xlsx, .xls" required>
            </div>
            <div class="mb-3">
              <label for="classDropdown" class="form-label"><?=lang('App.select.class')?></label>
              <select class="form-select" id="classDropdown" name="class_id" required>
                <?php foreach ($classes as $classId => $className): ?>
                  <option value="<?=$classId?>" <?= $classId == ($selectedClassId ?? '') ? 'selected' : '' ?>>
                  <?=$className?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>
            <div class="mb-3">
              <label for="durationWeeks" class="form-label"><?=lang('App.duration_in_weeks')?></label>
              <div class="input-group">
                <input type="number" class="form-control" id="durationWeeks" name="min_duration" min="1" required>
                <span class="input-group-text"><?=lang('App.weeks')?></span>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><?=lang('App.close')?></button>
            <button type="submit" class="btn btn-primary"><?=lang('App.import')?></button>
          </div>
        </form>
      </div>
    </div>
  </div>

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

<script>
  document.querySelector('#importModal form').addEventListener('submit', function (e) {
    e.preventDefault();

    const formData = new FormData(this);
    const url = this.action;

    fetch(url, {
      method: 'POST',
      body: formData,
    })
      .then(response => response.json())
      .then(data => {
        if (data.error) {
          alert(data.error); // Display error message
        } else {
          alert(data.message); // Display success message
          location.reload(); // Reload the page to reflect changes
        }
      })
      .catch(error => {
        console.error('Error:', error);
        alert('An unexpected error occurred.');
      });
  });
</script>

<?= $this->endSection('content'); ?>
