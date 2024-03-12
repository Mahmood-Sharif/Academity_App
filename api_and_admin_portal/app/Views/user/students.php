<?php
use App\Entities\User;

/* @var CodeIgniter\View\View $this */
/* @var User[] $students */

$this->extend('default') ;

helper('html');

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
      <h2 class="text-muted">academy name</h2>
      <h2 class="text-muted">class name</h2>
    </div>
  </div>

  <!-- TODO: filter by academy -->
  <!-- TODO: filter by class -->

  <ul class="list-group">
    <?php foreach ($students as $student):  ?>
    <li class="list-group-item d-flex align-items-center">
      <?= $student->name ?>
      <a href="#" class="btn btn-outline-success ms-auto">
        <?=lang('App.view')?>
      </a>
    </li>
    <?php endforeach ?>
  </ul>

</div>

<?= $this->endSection('content'); ?>
