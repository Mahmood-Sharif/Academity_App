<?php
use App\Entities\ClassEntity;

/* @var CodeIgniter\View\View $this */
/* @var ClassEntity[] $classes */

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
  <div class="d-flex align-items-first-baseline">
    <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
      <i class="bi bi-arrow-left-short fs-1"></i>
    </a>
    <div>
      <h1>
        <?=lang('App.classes')?>
      </h1>
      <h2 class="text-muted">academy name</h2>
    </div>
  </div>

  <!-- TODO: filter by academy -->

  <ul class="list-group">
    <?php foreach ($classes as $class):  ?>
    <li class="list-group-item d-flex align-items-center">
      <?= $class->class_name ?>
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
