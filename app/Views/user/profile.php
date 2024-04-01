<?php

use App\Entities\User;

/* @var CodeIgniter\View\View $this */
/* @var User $user */
/* @var string $type */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
$title = lang('App.profile.view.' . $type);
echo $title;
$this->endSection('page_title');
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
    <?php if (false && $type == 'owner'): ?>
    <a href="<?=url_to('AdminPortal\User::edit', $user->id)?>" class="btn btn-outline-secondary ms-auto">
      <?=lang('App.edit')?>
    </a>
    <?php endif ?>
  </div>

  <div class="row">
    <div class="col">
      <div class="mb-3">
        <?=validated_form_input('', '', lang('Auth.name'), $user->name, 'text', [], true)?>
      </div>
      <div class="mb-3">
        <?=validated_form_input('', '', lang('Auth.phone'), $user->phone, 'text', [], true)?>
      </div>
      <div class="mb-3">
        <?=validated_form_input('', '', lang('Auth.dob'), $user->dob, 'text', [], true)?>
      </div>
      <div class="mb-3">
        <?=validated_form_input('', '', lang('Auth.gender'), $user->gender, 'text', [], true)?>
      </div>
      <?php if ($type == 'student'): ?>
      <div class="mb-3">
        <?=validated_form_textarea('', '', lang('App.medical_condition'), $user->medical_condition ?? lang('App.no_medical_condition'), 'text', [], true)?>
      </div>
      <?php endif ?>
      <?php if ($type == 'coach'): ?>
      <div class="mb-3">
        <?=validated_form_textarea('', '', lang('App.academies'), $user->academies ?? lang('App.error'), 'text', [], true)?>
      </div>
      <?php endif ?>
    </div>
  </div>


</div>

<?= $this->endSection('content'); ?>
