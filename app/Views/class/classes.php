<?php
use App\Entities\Academy;


use App\Entities\ClassEntity;

/* @var CodeIgniter\View\View $this */
/* @var ClassEntity[] $classes */
/* @var Academy $academy */
/* @var Academy[] $academies */

$this->extend('default') ;

helper('html');

$this->section('page_title');
echo lang('App.classes');
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'academies';
$this->endSection('sidebarTab');
?>

<?= $this->section('content'); ?>

<div class="container">
  <div class="d-flex align-items-start">
    <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
      <i class="bi bi-arrow-left-short fs-1"></i>
    </a>
    <div>
      <h1>
        <?=lang('App.classes')?>
      </h1>
      <h2 class="text-muted">
        <?=$academy?->name ?? lang('App.all_academies') ?>
      </h2>
    </div>
    <a href="<?=url_to('AdminPortal\Classes::new') . ($academy !== null ? '?academy_id=' . $academy->academy_id : '') ?>"
      class="ms-auto btn btn-secondary">
      <?=lang('App.class.create')?>
    </a>
  </div>

  <!-- TODO: filter by academy -->

  <ul class="list-group">
    <?php foreach ($classes as $class):  ?>
    <li class="list-group-item d-flex align-items-center">
      <a href="<?=url_to('AdminPortal\Classes::show', $class->class_id)?>" class="text-decoration-none text-body">
        <?= $class->class_name ?>
      </a>
      <a href="#" class="btn btn-outline-success ms-auto">
        <?=lang('App.students')?>
      </a>
      <a href="<?=url_to('AdminPortal\Classes::edit', $class->class_id)?>" class="btn btn-outline-secondary ms-3">
        <?=lang('App.edit')?>
      </a>
    </li>
    <?php endforeach ?>
  </ul>

</div>

<?= $this->endSection('content'); ?>
