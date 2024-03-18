<?php
use App\Entities\Academy;

/* @var CodeIgniter\View\View $this */
/* @var Academy $academy */

$this->extend('default') ;

helper('html');

$this->section('page_title');
echo $academy->name;
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
      <?= $academy->name ?>
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
    <div class="col-8 col-lg-6">
      <div class="ratio ratio-16x9 mb-4">
        <img src="<?=$academy->image_url?>" alt="" class="object-fit-cover rounded-4"
          style="view-transition-name: academy<?=$academy->academy_id?>">
      </div>
      <h2>
        <?=lang('App.notifications')?>
      </h2>
      <div class="d-flex flex-column">
        <div class="alert alert-secondary alert-dismissible fade show">Lorem ipsum dolor sit amet
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <div class="alert alert-secondary alert-dismissible fade show">Lorem ipsum dolor sit amet
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <div class="alert alert-secondary alert-dismissible fade show">Lorem ipsum dolor sit amet
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      </div>
    </div>
    <div class="col-4">
      <ul class="list-group mb-3">
        <li class="list-group-item">
          <i class="bi bi-check2 fs-5 me-1"></i>
          <?=lang('App.academy.status.running')?>
        </li>
        <li class="list-group-item">
          <i class="bi bi-book fs-5 me-1"></i>
          <?=lang('App.academy.num_classes', [$academy->num_classes])?>
        </li>
        <li class="list-group-item">
          <i class="bi bi-person fs-5 me-1"></i>
          <?=lang('App.academy.num_students', [$academy->num_students])?>
        </li>
      </ul>
      <div class="d-flex flex-column gap-3">
        <a href="<?=url_to('AdminPortal\Classes::index', $academy->academy_id)?>" class="btn btn-secondary">
          <?=lang('App.manage.classes')?>
        </a>
        <a href="#" class="btn btn-secondary">
          <?=lang('App.manage.schedule')?>
        </a>
        <a href="<?=url_to('AdminPortal\User::indexStudents') . '?academy=' . $academy->academy_id ?>" class="btn btn-secondary">
          <?=lang('App.manage.students')?>
        </a>
        <a href="<?=url_to('AdminPortal\User::indexCoaches') ?>" class="btn btn-secondary">
          <?=lang('App.manage.coaches')?>
        </a>
        <a href="#" class="btn btn-secondary disabled">
          <?=lang('App.manage.announcements')?>
        </a>
        <a href="#" class="btn btn-secondary disabled">
          <?=lang('App.manage.accounting')?>
        </a>
        <a href="<?=url_to('AdminPortal\Academy::edit', $academy->academy_id)?>" class="btn btn-secondary">
          <?=lang('App.manage.academy')?>
        </a>
      </div>
    </div>
  </div>

</div>

<?= $this->endSection('content'); ?>
