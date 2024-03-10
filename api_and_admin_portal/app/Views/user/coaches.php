<?php
use App\Entities\User;

/* @var CodeIgniter\View\View $this */
/* @var User[] $coaches */

$this->extend('default') ;

helper('html');

$this->section('page_title');
echo lang('App.coaches');
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'academies';
$this->endSection('sidebarTab');
?>

<?= $this->section('content'); ?>

<div class="container">

  <div class="d-flex align-items-start">
    <div>
      <h1>
        <?=lang('App.coaches')?>
      </h1>
      <!-- <h2 class="text-muted">academy name</h2> -->
      <!-- <h2 class="text-muted">class name</h2> -->
    </div>

    <a href="<?=url_to('AdminPortal\User::registerCoach')?>" class="ms-auto btn btn-secondary">
      <?=lang('App.register_coach')?>
    </a>
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

  <?php if (empty($coaches)): ?>
  <h3>
    <?=lang('App.empty.coaches')?>
  </h3>
  <?php else: ?>
  <table class="table">
    <thead>
      <th scope="col">
        <?=lang('App.coach_name')?>
      </th>
      <th scope="col">
        <?=lang('App.academies')?>
      </th>
      <th scope="col">
        <?=lang('App.actions')?>
      </th>
    </thead>
    <tbody>
      <?php foreach ($coaches as $coach):  ?>
      <tr>
        <td>
          <?= $coach->name ?>
        </td>
        <td><?=$coach->academies?></td>
        <td>
          <a href="#" class="btn btn-outline-success ms-auto">
            <?=lang('App.view')?>
          </a>
        </td>
      </tr>
      <?php endforeach ?>

    </tbody>
  </table>
  <?php endif ?>


</div>

<?= $this->endSection('content'); ?>
