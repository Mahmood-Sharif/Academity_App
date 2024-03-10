<?php
use App\Entities\ClassEntity;

/* @var CodeIgniter\View\View $this */
/* @var array $coaches */
/* @var Class|null $class */
/* @var string $type 'create' || 'edit' */
/* @var array $errors */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
$title = match ($type) {
    'create' => lang('App.class.create') ,
    'edit'   => lang('App.class.edit', [$class?->name ?? '']),
};
echo $title;
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'academies';
$this->endSection('sidebarTab');

$url = match($type) {
    'create' => url_to('AdminPortal\Classes::new'),
    'edit' => url_to('AdminPortal\Classes::edit', $class->class_id),
}

?>

<?= $this->section('content'); ?>

<div class="container">
  <div class="d-flex align-items-center mb-3">
    <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
      <i class="bi bi-arrow-left-short fs-1"></i>
    </a>
    <h1>
      <?= $title ?>
    </h1>
  </div>

  <div class="row">
    <div class="col col-lg-8 col-md-10 col-sm-12">

      <form action="<?= match($type) {
          'create' => url_to('AdminPortal\Academy::create'),
          'edit' => url_to('AdminPortal\Academy::update', $class->class_id),
      }?>" method="post" enctype="multipart/form-data">
        <?= csrf_field() ?>

        <div class="mb-3">
          <?=validated_form_input('className', 'class_name', lang('App.class_name'), $class?->class_name ?? set_value('class_name'))?>
        </div>

        <!-- TODO: search select -->
        <div class="mb-3">
          <?=validated_form_select('coach', 'coach_id', lang('App.main_coach'), $coaches, $class?->coach_id ?? set_value('coach_id'))?>
        </div>

        <?php /*
        TODO: Class sscheduling

        <!-- TODO: time input? -->

        <div class="d-flex gap-2 mb-3">
          <?=validated_form_input('startTime', 'start_time', lang('App.start_time'), $class?->start_time ?? set_value('start_time'), 'time')?>
          <?=validated_form_input('endTime', 'end_time', lang('App.end_time'), $class?->end_time ?? set_value('end_time'), 'time')?>
        </div>

        <!-- TODO: update db for repeat -->

        <div class="mb-2">
          <label for="???" class="">
            <?=lang('App.repeat')?>
          </label>
        </div>
        <div class="d-flex gap-2 mb-3">
          <div class="form-check">
            <input id="checkSun" type="checkbox" value="" class="form-check-input">
            <label class="form-check-label" for="checkSun">
              <?=lang('App.day_of_week.sun')?>
            </label>
          </div>
          <div class="form-check">
            <input id="checkMon" type="checkbox" value="" class="form-check-input">
            <label class="form-check-label" for="checkMon">
              <?=lang('App.day_of_week.mon')?>
            </label>
          </div>
          <div class="form-check">
            <input id="checkTue" type="checkbox" value="" class="form-check-input">
            <label class="form-check-label" for="checkTue">
              <?=lang('App.day_of_week.tue')?>
            </label>
          </div>
          <div class="form-check">
            <input id="checkWed" type="checkbox" value="" class="form-check-input">
            <label class="form-check-label" for="checkWed">
              <?=lang('App.day_of_week.wed')?>
            </label>
          </div>
          <div class="form-check">
            <input id="checkThu" type="checkbox" value="" class="form-check-input">
            <label class="form-check-label" for="checkThu">
              <?=lang('App.day_of_week.thu')?>
            </label>
          </div>
          <div class="form-check">
            <input id="checkFri" type="checkbox" value="" class="form-check-input">
            <label class="form-check-label" for="checkFri">
              <?=lang('App.day_of_week.fri')?>
            </label>
          </div>
          <div class="form-check">
            <input id="checkSat" type="checkbox" value="" class="form-check-input">
            <label class="form-check-label" for="checkSat">
              <?=lang('App.day_of_week.sat')?>
            </label>
          </div>
      </div>
      */ ?>

        <div class="mb-4">
          <?=validated_form_input('price', 'price', lang('App.price'), $class?->price ?? set_value('price'))?>
        </div>

        <div class="d-flex gap-3">
          <button class="btn btn-success ms-auto" type="submit">
            <?=lang('App.submit')?>
          </button>
          <button class="btn btn-secondary" type="reset">
            <?=lang('App.reset')?>
          </button>
        </div>

      </form>


    </div>
  </div>
</div>
</div>
</div>
</div>

</div>

<div id="modals-here" class="modal modal-blur fade" style="display: none" aria-hidden="false" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content"></div>
  </div>
</div>

<script>
  (() => {
    window.history.pushState(
      null,
      '<?= esc($title, 'js') ?>',
      '<?= esc($url, 'js') ?>',
    );
    document.getElementById('academyImage').onchange = function () {
      const src = URL.createObjectURL(this.files[0]);
      document.getElementById('imagePreview').src = src;
    };
  })();
</script>

<?= $this->endSection('content'); ?>
