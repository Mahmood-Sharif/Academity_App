<?php
use App\Entities\Academy;

/* @var CodeIgniter\View\View $this */
/* @var Academy $academy */

$this->extend('default') ;

helper('html');

$this->section('page_title');
echo lang('App.academy.edit', [$academy->name]) ;
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
      <?= lang('App.academy.edit', [$academy->name]) ?>
    </h1>
  </div>

  <div class="row">
    <div class="col-8 col-lg-6">
      <div class="ratio ratio-16x9 mb-4">
        <img src="<?=base_url($academy->image_url)?>" alt="" class="object-fit-cover rounded-4"
          style="view-transition-name: academy<?=$academy->academy_id?>">
      </div>

      <form action="<?= url_to('AdminPortal\Academy::update', $academy->academy_id)?>" method="post">
        <?= csrf_field() ?>

        <div class="form-floating mb-3">
          <input type="text" class="form-control" id="academyName" name="academy_name" placeholder=""
            value="<?=esc($academy->name)?>">
          <label for="academyName">
            <?=lang('App.academy_name')?>
          </label>
        </div>

        <div class="form-floating mb-3">
          <input type="tel" class="form-control" id="academyPhone" name="academy_phone" placeholder=""
            value="<?=esc($academy->phone)?>">
          <label for="academyPhone">
            <?=lang('App.academy_phone')?>
          </label>
        </div>

        <div class="form-floating mb-3">
          <input type="text" class="form-control" id="academyLocation" name="academy_location" placeholder=""
            value="<?=esc($academy->location)?>">
          <label for="academyLocation">
            <?=lang('App.academy_location')?>
          </label>
        </div>

        <div class="form-floating mb-4">
          <textarea type="text" class="form-control" id="academyDescription" name="academy_description"
            placeholder=""><?=esc($academy->description, 'html')?></textarea>
          <label for="academyDescription">
            <?=lang('App.academy_description')?>
          </label>
        </div>

        <div class="d-flex gap-3">
          <button class="btn btn-success ms-auto" type="submit">
            <?=lang('App.submit')?>
          </button>
          <button class="btn btn-secondary" type="reset">
            <?=lang('App.reset')?>
          </button>
        </div>

      </form>

    </div>
  </div>

</div>

<?= $this->endSection('content'); ?>
