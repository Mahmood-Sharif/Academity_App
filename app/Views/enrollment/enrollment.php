<?php

use App\Entities\Enrollment;
use App\Entities\User;

/* @var CodeIgniter\View\View $this */
/* @var User $user */
/* @var Enrollment $enrollment */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
$title = lang('App.enrollment.view');
echo $title;
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'students';
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
  </div>

  <?php if (session('error') !== null) : ?>
  <div class="alert alert-danger alert-dismissible" role="alert">
    <?= session('error') ?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <?php endif ?>

  <?php if (session('message') !== null) : ?>
  <div class="alert alert-success alert-dismissible" role="alert">
    <?= session('message') ?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <?php endif ?>

  <div class="row">
    <div class="col">
      <div class="mb-3">
        <?=validated_form_input('', '', lang('App.student_name'), $enrollment->student_name, 'text', [], true)?>
      </div>
      <div class="mb-3">
        <?=validated_form_input('', '', lang('App.class_name'), $enrollment->class_name, 'text', [], true)?>
      </div>
      <div class="mb-3">
        <?=validated_form_input('', '', lang('App.student_gender'), $enrollment->student_gender, 'text', [], true)?>
      </div>
      <div class="mb-3">
        <?=validated_form_input('', '', lang('Auth.dob'), $enrollment->student_dob, 'text', [], true)?>
      </div>
      <div class="mb-3">
        <?=validated_form_input('', '', lang('App.student_phone'), $enrollment->student_phone, 'text', [], true)?>
      </div>
      <div class="row mb-4">
        <div class="col">
          <?=validated_form_input('', '', lang('App.enrollment_start'), $enrollment->start_date, 'text', [], true)?>
        </div>
        <div class="col">
          <?=validated_form_input('', '', lang('App.enrollment_end'), $enrollment->end_date, 'text', [], true)?>
        </div>
      </div>
      <div class="d-flex">
        <a class="btn btn-secondary ms-auto"
          href="<?=url_to('AdminPortal\Enrollment::edit', $enrollment->enrollment_id)?>">
          <?=lang('App.edit.end_date')?>
        </a>
        <button hx-get="<?=url_to('AdminPortal\Enrollment::remove', $enrollment->enrollment_id)?>"
          hx-target="#modals-here" data-bs-toggle="modal" data-bs-target="#modals-here" class="btn btn-danger ms-3">
          <?=lang('App.unenrol')?>
        </button>
      </div>
    </div>
  </div>
</div>

<div id="modals-here" class="modal modal-blur fade" style="display: none" aria-hidden="false" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content"></div>
  </div>
</div>

<?= $this->endSection('content'); ?>
