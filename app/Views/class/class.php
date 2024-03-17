<?php

use App\Entities\User;

/* @var CodeIgniter\View\View $this */
/* @var Class|null $class */
/* @var User $coach */
/* @var string $classTimingsJson */
/* @var integer $numTimings */
/* @var string $type 'create' || 'edit' */
/* @var array $errors */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
$title = lang('App.class.view', [$class->class_name]);
echo $title;
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'academies';
$this->endSection('sidebarTab');
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
    <a href="<?=url_to('AdminPortal\Classes::edit', $class->class_id)?>" class="btn btn-outline-secondary ms-auto">
        <?=lang('App.edit')?>
    </a>
  </div>

  <div class="row">
    <div class="col">
        <div class="mb-3 row">
          <div class="col">
            <?=validated_form_input('className', 'class_name', lang('App.class_name'), $class?->class_name, 'text', [], true)?>
          </div>
          <div class="col">
            <?=validated_form_input('max_capacity', 'max_capacity', lang('App.max_capacity'), $class?->max_capacity, 'number', [], true)?>
          </div>
        </div>

        <div class="mb-3 row">
          <div class="col">
            <?=validated_form_input('min_age', 'min_age', lang('App.min_age'), $class?->min_age, 'number', [], true)?>
          </div>
          <div class="col">
            <?=validated_form_input('max_age', 'max_age', lang('App.max_age'), $class?->max_age, 'number', [], true)?>
          </div>
        </div>

        <div class="mb-3">
            <?=validated_form_input('price', 'price', lang('App.price'), $class?->price ?? 0, 'number', [], true)?>
        </div>

        <div class="mb-3">
          <duration-input id="min_duration" name="min_duration" data-classes-per-week="<?=$numTimings?>"
            data-label="<?=lang('App.enrol_duration')?>" readonly>
          </duration-input>
        </div>

        <div class="mb-3 d-flex align-items-center gap-3">
            <?=validated_form_input('coach', 'ceach', lang('App.main_coach'), $coach->name, 'text', ['readonly' => 'readonly'], 'form-control-plaintext')?>
        </div>

        <class-schedule-editor readonly>
          <?= $classTimingsJson ?>
        </class-schedule-editor>

    </div>
  </div>
</div>

<script src="/js/class_schedule.js"></script>
<script src="/js/class_duration.js"></script>

<?= $this->endSection('content'); ?>
