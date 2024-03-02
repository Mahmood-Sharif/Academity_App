<?php
use App\Entities\Academy;

/* @var CodeIgniter\View\View $this */
/* @var Academy[] $academies */

$this->extend('default') ;

helper('html');

$this->section('page_title');
echo lang('App.my_academies');
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'academies';
$this->endSection('sidebarTab');
?>

<?= $this->section('content'); ?>

<div class="container">
  <h1>
    <?=lang('App.my_academies')?>
  </h1>

  <div class="d-flex flex-wrap gap-3">
    <?php foreach ($academies as $academy):  ?>
    <div class="card" style="width: 20rem;">
      <div class="ratio ratio-16x9">
        <img src="<?= base_url($academy->image_url)?>" 
             alt="" 
             class="card-img object-fit-cover" 
             style="view-transition-name: academy<?=$academy->academy_id?>">
      </div>
      <div class="card-body">
        <a href="my-academies/<?=$academy->academy_id?>"
          class="stretched-link card-title text-decoration-none fs-6 fw-bold">
          <?= $academy->name ?>
        </a>
      </div>
    </div>
    <?php endforeach ?>
  </div>
</div>

<?= $this->endSection('content'); ?>
