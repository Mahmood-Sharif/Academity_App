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
    <div class="col col-lg-7 col-md-8 col-sm-12">

      <?php if (session('error') !== null) : ?>
      <div class="alert alert-danger alert-dismissible" role="alert">
        <?= session('error') ?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <?php endif ?>

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

      <div class="accordion mt-4" id="accordionDanger">
        <div class="accordion-item">
          <h2 class="accordion-header">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
              data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
              <?=lang('App.advanced_options')?>
            </button>
          </h2>
          <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionDanger">
            <div class="accordion-body">
              <ul class="list-group list-group-flush">
                <li class="list-group-item d-flex align-items-start">
                  <div class="ms-2 me-auto">
                    <div class="fw-bold">
                      <?=lang('App.block_registration')?>
                    </div>
                    <?=lang('App.block_registration.desc')?>
                  </div>
                  <button class="btn btn-danger">
                    <?=lang('App.block_registration.btn')?>
                  </button>
                </li>
                <li class="list-group-item d-flex align-items-start">
                  <div class="ms-2 me-auto">
                    <div class="fw-bold">
                      <?=lang('App.delete_academy')?>
                    </div>
                    <?=lang('App.delete_academy.desc')?>
                  </div>
                  <button hx-get="<?=url_to('AdminPortal\Academy::remove', $academy->academy_id)?>"
                    hx-target="#modals-here" hx-trigger="click" data-bs-toggle="modal" data-bs-target="#modals-here"
                    class="btn btn-danger">
                    <?=lang('App.delete_academy.btn')?>
                  </button>
                </li>
              </ul>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
</div>
</div>
</div>

</div>

<div id="modals-here" class="modal modal-blur fade" style="display: none" aria-hidden="false" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content"></div>
  </div>
</div>

<?= $this->endSection('content'); ?>
