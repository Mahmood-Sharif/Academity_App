<?php
/* @var CodeIgniter\View\View $this */
/* @var int|null $academyId */
/* @var array $academies */
/* @var array $coaches */
/* @var Class|null $class */
/* @var string $classTimingsJson */
/* @var int $numTimings */
/* @var string $type 'create' || 'edit' */
/* @var array $errors */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
$title = match ($type) {
    'create' => lang('App.class.create') ,
    'edit'   => lang('App.class.edit', [$class?->class_name ?? '']),
};
echo $title;
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'academies';
$this->endSection('sidebarTab');

$url = match($type) {
    'create' => url_to('AdminPortal\Classes::new'),
    'edit' => url_to('AdminPortal\Classes::edit', $class->class_id),
};
?>

<?= $this->section('content'); ?>

<div class="container">
  <form action="<?= match($type) {
      'create' => url_to('AdminPortal\Classes::create'),
      'edit' => url_to('AdminPortal\Classes::update', $class->class_id),
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
          'academy_id',
          'academy_id',
          lang('App.academy'),
          $academies,
          request()->getGet('academy_id') ?? set_value('academy_id'),
          'ms-auto',
          'hx-get="'.url_to('AdminPortal\User::academyCoachesInput').'" hx-vals="js:{academy_id: event.target.value}" hx-target="#academyCoaches" hx-trigger="change" hx-swap="outerHTML"'
      ) ?>
      <?php endif ?>
    </div>

    <div class="row">
      <div class="col">

        <!-- <h2> -->
        <!--   <?=lang('class.details')?> -->
        <!-- </h2> -->

        <div class="mb-3 row">
          <div class="col">
            <?=validated_form_input('className', 'class_name', lang('App.class_name'), $class?->class_name ?? set_value('class_name'))?>
          </div>
          <div class="col">
            <?=validated_form_input('max_capacity', 'max_capacity', lang('App.max_capacity'), $class?->max_capacity ?? set_value('max_capacity') ?? 20, 'number')?>
          </div>
        </div>

        <div class="mb-3 row">
          <div class="col">
            <?=validated_form_input('min_age', 'min_age', lang('App.min_age'), $class?->min_age ?? set_value('min_age'), 'number')?>
          </div>
          <div class="col">
            <?=validated_form_input('max_age', 'max_age', lang('App.max_age'), $class?->max_age ?? set_value('max_age'), 'number')?>
          </div>
        </div>

        <div class="mb-3">
          <?=validated_form_input('price', 'price', lang('App.price'), $class?->price ?? set_value('price'), 'number', [
                                                                  'aria-describedby' => 'priceHelp',
                                                                  'min' => '0.100',
                                                                  'step' => '0.001',
                                                        ])?>
          <div id="priceHelp" class="form-text">
            <?=lang('App.price.help')?>
          </div>
        </div>

        <div class="mb-3">
          <duration-input id="min_duration" name="min_duration" data-classes-per-week="<?=$numTimings ?? 1 ?>"
            data-label="<?=lang('App.enrol_duration')?>">
          </duration-input>
        </div>

        <!-- <h2 class="fw-normal"> -->
        <!--   <?=lang('class.scheduling')?> -->
        <!-- </h2> -->

        <!-- TODO: search select -->
        <div id="academyCoaches" class="mb-3 d-flex align-items-center gap-3">
          <?=validated_form_select(
              'coach',
              'coach_id',
              lang('App.main_coach'),
              empty($coaches) ? ['' => lang('App.empty.coaches')] : $coaches,
              $class?->coach_id ?? set_value('coach_id'),
              'flex-fill'
          )?>
          <?php if(empty($coaches)): ?>
          <a href="<?=url_to('register_new_coach') . '?academy_id=' . $academyId ?? $class?->academy_id ?>"
            class="btn btn-secondary">
            <?=lang('App.register_coach')?>
          </a>
          <?php endif ?>
        </div>

        <class-schedule-editor name="timings" data-class-counters="min_duration">
          <?= $classTimingsJson ?? '' ?>
        </class-schedule-editor>


        <div class="d-flex gap-3 mt-4">
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
  <?php if ($type === 'edit'): ?>
  <div class="accordion mt-4" id="accordionDanger">
    <div class="accordion-item">
      <h2 class="accordion-header">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne"
          aria-expanded="true" aria-controls="collapseOne">
          <?=lang('App.advanced_options')?>
        </button>
      </h2>
      <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionDanger">
        <div class="accordion-body">
          <ul class="list-group list-group-flush">
            <li class="list-group-item d-flex align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <?=lang('App.delete_class')?>
                </div>
                <?=lang('App.delete_class.desc')?>
              </div>
              <button hx-get="<?=url_to('AdminPortal\Classes::remove', $class->class_id)?>" hx-target="#modals-here"
                hx-trigger="click" data-bs-toggle="modal" data-bs-target="#modals-here" class="btn btn-danger">
                <?=lang('App.delete_class.btn')?>
              </button>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <?php endif ?>
</div>

<div id="modals-here" class="modal modal-blur fade" style="display: none" aria-hidden="false" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content"></div>
  </div>
</div>

<script src="/js/class_schedule.js"></script>
<script src="/js/class_duration.js"></script>
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
