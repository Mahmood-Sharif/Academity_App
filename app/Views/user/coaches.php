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
echo 'coaches';
$this->endSection('sidebarTab');
?>

<?= $this->section('content'); ?>

<div class="container">

  <div class="d-flex align-items-center">
    <!-- TODO: only show if there is back page. refer_url -->
    <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
      <i class="bi bi-arrow-left-short fs-1"></i>
    </a>

    <div>
      <h1>
        <?=lang('App.coaches')?>
      </h1>
      <!-- <h2 class="text-muted">academy name</h2> -->
      <!-- <h2 class="text-muted">class name</h2> -->
    </div>

    <a href="<?=url_to('register_new_coach')?>" class="ms-auto btn btn-secondary">
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
          <div class="d-flex gap-2">
            <a href="<?=url_to('AdminPortal\User::showCoach', $coach->id)?>" class="btn btn-outline-success ms-auto">
              <?=lang('App.view')?>
            </a>
            <div class="dropdown">
              <button class="btn btn-danger dropdown-toggle" type="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                <?=lang('App.remove')?>
              </button>
              <ul class="dropdown-menu">
                <?php foreach ($coach->academiesObj as $academy): ?>
                <li><a href="<?=url_to('AdminPortal\User::removeCoach') . '?coach_id=' . $coach->id . '&academy_id=' . $academy->academy_id ?>"
                    class="dropdown-item">
                    <?=lang('App.remove.from_academy', [$academy->name])?>
                  </a></li>
                <?php endforeach ?>
              </ul>
            </div>
          </div>
        </td>
      </tr>
      <?php endforeach ?>

    </tbody>
  </table>
  <?php endif ?>


</div>

<div id="modals-here" class="modal modal-blur fade" style="display: none" aria-hidden="false" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content"></div>
  </div>
</div>

<?= $this->endSection('content'); ?>
