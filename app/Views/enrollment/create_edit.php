<?php

use App\Entities\Enrollment;

/* @var CodeIgniter\View\View $this */
/* @var array $classes */
/* @var Enrollment|null $enrollment */
/* @var string $type 'create' || 'edit' */
/* @var array $errors */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
$title = match ($type) {
    'create' => lang('App.enrollment.create') ,
    'edit'   => lang('App.enrollment.edit'),
};
echo $title;
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'students';
$this->endSection('sidebarTab');

$url = match($type) {
    'create' => url_to('AdminPortal\Enrollment::new'),
    'edit' => url_to('AdminPortal\Enrollment::edit', $enrollment->enrollment_id),
};
?>

<?= $this->section('content'); ?>

<div class="container">
  <form action="<?= match($type) {
      'create' => url_to('AdminPortal\Enrollment::create'),
      'edit' => url_to('AdminPortal\Enrollment::update', $enrollment->enrollment_id),
  }?>" method="post">
    <?= csrf_field() ?>

    <div class="d-flex align-items-center mb-3">
      <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
        <i class="bi bi-arrow-left-short fs-1"></i>
      </a>
      <h1>
        <?= $title ?>
      </h1>
      <?php if ($type === 'create'): ?>
      <?= validated_form_select(
          'class_id',
          'class_id',
          lang('App.class'),
          $classes,
          request()->getGet('class_id') ?? set_value('class_id'),
          'ms-auto',
      ) ?>
      <?php endif ?>
    </div>

    <div class="row">
      <div class="col">

        <div class="mb-3">
          <?=validated_form_input('student_id', 'student_id', lang('App.student_name'), $enrollment->student_name, 'text', [], true)?>
        </div>

        <div class="mb-3">
          <?=validated_form_input('class_id', 'class_id', lang('App.class_name'), $enrollment->class_name, 'text', [], true)?>
        </div>

        <div class="row mb-4">
          <div class="col">
            <?=validated_form_input('start_date', 'start_date', lang('App.enrollment_start'), $enrollment->start_date, 'text', [], true)?>
          </div>
          <div class="col">
            <?=validated_form_input('end_date', 'end_date', lang('App.enrollment_end'), $enrollment->end_date ?? set_value('end_date'), 'date', [])?>
          </div>
        </div>

        <div class="d-flex gap-3">
          <button class="btn btn-success ms-auto" type="submit">
            <?=lang('App.submit')?>
          </button>
          <button class="btn btn-secondary" type="reset">
            <?=lang('App.reset')?>
          </button>
        </div>

      </div>
    </div>
  </form>

</div>

<div id="modals-here" class="modal modal-blur fade" style="display: none" aria-hidden="false" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content"></div>
  </div>
</div>

<?php if($type == 'edit'): ?>
<script>
  (() => {
    window.history.replaceState(
      null,
      '',
      '<?= esc($url, 'js') ?>',
    );
  })();
</script>
<?php endif ?>

<?= $this->endSection('content'); ?>
