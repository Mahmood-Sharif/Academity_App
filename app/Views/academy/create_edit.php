<?php
use App\Entities\Academy;

/* @var CodeIgniter\View\View $this */
/* @var Academy|null $academy */
/* @var array $sports */
/* @var string $type 'create' || 'edit' */
/* @var array $errors */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
$title = match ($type) {
    'create' => lang('App.academy.create') ,
    'edit'   => lang('App.academy.edit', [$academy?->name ?? '']),
};
echo $title;
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'academies';
$this->endSection('sidebarTab');

$url = match($type) {
    'create' => url_to('AdminPortal\Academy::new'),
    'edit' => url_to('AdminPortal\Academy::edit', $academy->academy_id),
}

?>

<?= $this->section('content'); ?>

<div class="container">
  <div class="d-flex align-items-center mb-3">
    <!-- TODO: Make back buttons go back better -->
    <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
      <i class="bi bi-arrow-left-short fs-1"></i>
    </a>
    <h1>
      <?= $title ?>
    </h1>
  </div>

  <div class="row">
    <div class="col col-lg-7 col-md-8 col-sm-12">

      <form action="<?= match($type) {
          'create' => url_to('AdminPortal\Academy::create'),
          'edit' => url_to('AdminPortal\Academy::update', $academy->academy_id),
      }?>" method="post" enctype="multipart/form-data">
        <?= csrf_field() ?>
        <div class="mb-3 d-flex flex-column">
          <div class="ratio ratio-16x9 mb-2">
            <!-- FIXME: persist 'uploaded' image after form validation -->
            <img id="imagePreview" src="<?=base_url($academy?->image_url ?? 'images/Academy.jpg')?>" alt=""
              class="object-fit-cover rounded-4 border">
          </div>
          <label for="academyImage" class="btn btn-secondary ms-auto">
            <?=lang('App.change_image')?>
          </label>
          <input id="academyImage" name="image" class="visually-hidden" type="file"
            accept="image/png,image/jpeg,image/webp" hidden>
        </div>

        <div class="mb-3">
          <?=validated_form_input('academyName', 'name', lang('App.academy_name'), $academy?->name ?? set_value('name'))?>
        </div>

        <!-- FIXME: select value validation. i.e. don't allow placeholder selection -->
        <div class="form-floating mb-3">
          <select class="form-select" id="sportSelect" name="sport_id" aria-label="<?=lang('App.academy_sport')?>">
            <option selected>
              <?=lang('App.academy_sport.select')?>
            </option>
            <?php foreach ($sports as $sport): ?>
            <option value="<?=$sport->sport_id?>" <?=($academy?->sport_id ?? 0) == $sport->sport_id ? 'selected' : '' ?>
              >
              <?=$sport->name?>
            </option>
            <?php endforeach ?>
          </select>
          <label for="sportSelect">
            <?=lang('App.academy_sport')?>
          </label>
        </div>

        <div class="mb-3">
          <?=validated_form_input('academyPhone', 'phone', lang('App.academy_phone'), $academy?->phone ?? set_value('phone'), 'tel')?>
        </div>

        <div class="mb-3">
          <?=validated_form_input('academylocation', 'location', lang('App.academy_location'), $academy?->location ?? set_value('location'))?>
        </div>

        <div class="mb-4">
          <?=validated_form_textarea('academydescription', 'description', lang('App.academy_description'), $academy?->description ?? set_value('description'))?>
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
</div>
</div>
</div>

</div>

<div id="modals-here" class="modal modal-blur fade" style="display: none" aria-hidden="false" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content"></div>
  </div>
</div>

<script>
  (() => {
    window.history.pushState(
      null,
      '<?= esc($title, 'js') ?>',
      '<?= esc($url, 'js') ?>',
    );
    document.getElementById('academyImage').onchange = function () {
      const src = URL.createObjectURL(this.files[0]);
      document.getElementById('imagePreview').src = src;
    };
  })();
</script>

<?= $this->endSection('content'); ?>
