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
  <div class="col col-lg-8">
    <div class="mb-3 d-flex flex-row align-items-end">
      <div class="ratio ratio-16x9">
        <img id="imagePreview" src="<?=$academy?->image_url ?? base_url('images/placeholder.jpeg')?>" alt=""
          class="object-fit-cover rounded-4 border">
      </div>
      <div class="ms-auto d-flex flex-row-reverse align-items-center">
        <label for="academyImage" class="ms-3 btn btn-secondary">
          <?=lang('App.change_thumbnail')?>
        </label>
        <div>
          <input id="academyImage" name="image"
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
  (() => {
    document.getElementById('academyImage').onchange = function () {
      const src = URL.createObjectURL(this.files[0]);
      document.getElementById('imagePreview').src = src;
    };
  })();
</script>

<?= $this->endSection('content'); ?>
