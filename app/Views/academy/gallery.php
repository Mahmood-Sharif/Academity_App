<?php
use App\Entities\Academy;

/* @var CodeIgniter\View\View $this */
/* @var Academy $academy */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
echo $academy->name;
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'academies';
$this->endSection('sidebarTab');
?>

<?= $this->section('content'); ?>

<div class="row">
  <div class="d-flex align-items-start mb-5">
    <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
      <i class="bi bi-arrow-left-short fs-1"></i>
    </a>
    <h1 class="flex-grow-1">
      <?= lang('App.academy_gallery') ?>
    </h1>
    <div class="d-flex flex-column gap-1" style="max-height: 12em; width: fit-content;">
      <div class="ratio ratio-16x9" style="cursor: zoom-in" data-bs-toggle="modal" data-bs-target="#lightbox">
        <img id="imagePreview" src="<?=$academy?->image_url ?? base_url('images/placeholder.jpeg')?>" alt=""
          class="img-fluid object-fit-cover rounded-4 border">
      </div>
      <div>
        <label for="academyImage" class="btn btn-secondary w-100">
          <?=lang('App.change_thumbnail')?>
        </label>
        <form id="thumbnailForm" enctype="multipart/form-data" hx-swap="outerHTML"
          hx-post="<?=url_to('AdminPortal\Academy::updateThumbnail', $academy->academy_id)?>" hx-target=".toast"
          hx-trigger="change from:#academyImage">
          <?=csrf_field()?>
        </form>
        <div>
          <input form="thumbnailForm" id="academyImage" name="thumbnail"
            class="visually-hidden <?=array_key_exists('image', validation_errors()) ? ' is-invalid' : ''?>" type="file"
            accept="image/png,image/jpeg,image/webp" hidden>
          <?=validation_show_error('image')?>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="col-12">
  <custom-gallery data-items-endpoint="<?=url_to('AdminPortal\Academy::galleryItems', $academy->academy_id)?>"
    data-upload-endpoint="<?=url_to('AdminPortal\Academy::galleryUpload')?>"
    data-submit-endpoint="<?=url_to('AdminPortal\Academy::gallerySubmit', $academy->academy_id)?>"
    data-csrf-token="<?=csrf_hash()?>">
  </custom-gallery>
</div>

<script type="module" src="<?=base_url('js/gallery.js')?>"></script>
<script>
  // (() => {
  //   document.getElementById('academyImage').onchange = function () {
  //     const src = URL.createObjectURL(this.files[0]);
  //     document.getElementById('imagePreview').src = src;
  //   };
  // })();
</script>

<?= $this->endSection('content'); ?>
