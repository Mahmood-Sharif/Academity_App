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
  <h1>
    <?= $academy->name ?>
  </h1>

  <div class="row">
    <div class="col-8 col-lg-6">
      <div class="ratio ratio-16x9 mb-4">
        <img src="<?=base_url($academy->image_url)?>" alt="" class="object-fit-cover rounded-4">
      </div>
      <h2><?=lang('App.notifications')?></h2>
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
        <li class="list-group-item"><?=lang('App.academy.num_classes', [0])?> </li>
        <li class="list-group-item"><?=lang('App.academy.num_classes', [1])?> </li>
        <li class="list-group-item"><?=lang('App.academy.num_classes', [3])?> </li>
      </ul>
      <div class="d-flex flex-column gap-3">
        <button class="btn btn-secondary"><?=lang('App.manage.classes')?></button>
        <button class="btn btn-secondary"><?=lang('App.manage.schedule')?></button>
        <button class="btn btn-secondary"><?=lang('App.manage.students')?></button>
        <button class="btn btn-secondary"><?=lang('App.manage.announcements')?></button>
        <button class="btn btn-secondary"><?=lang('App.manage.accounting')?></button>
        <button class="btn btn-secondary"><?=lang('App.manage.academy')?></button>
      </div>
    </div>
  </div>

</div>

<?= $this->endSection('content'); ?>
