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
    <div class="col col-lg-8">

      <form action="<?= match($type) {
          'create' => url_to('AdminPortal\Academy::create'),
          'edit' => url_to('AdminPortal\Academy::update', $academy->academy_id),
      }?>" method="post" enctype="multipart/form-data" hx-push-url="false">
        <?= csrf_field() ?>
        <div class="mb-3 d-flex flex-column">
          <div class="ratio ratio-16x9 mb-2">
            <!-- TODO: persist 'uploaded' image after form validation -->
            <img id="imagePreview" src="<?=$academy?->image_url ?? base_url('images/placeholder.jpeg')?>" alt=""
              class="object-fit-cover rounded-4 border" style="view-transition-name: academy<?=$academy?->academy_id ?? 0 ?>;">
          </div>
          <div class="ms-auto d-flex flex-row-reverse align-items-center">
            <label for="academyImage" class="ms-3 btn btn-secondary">
              <?=lang('App.change_image')?>
            </label>
            <div>
              <input id="academyImage" name="image"
                class="visually-hidden <?=array_key_exists('image', validation_errors()) ? ' is-invalid' : ''?>"
                type="file" accept="image/png,image/jpeg,image/webp" hidden>
              <?=validation_show_error('image')?>
            </div>
          </div>
        </div>

        <div class="mb-3">
          <?=validated_form_input('academyName', 'name', lang('App.academy_name'), $academy?->name ?? set_value('name'))?>
        </div>

        <div class="mb-3">
          <?= validated_form_select('sport_id', 'sport_id', lang('App.academy_sport'), $sports, $academy?->sport_id ?? set_value('sport_id'))?>
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
    document.getElementById('academyImage').onchange = function () {
      const src = URL.createObjectURL(this.files[0]);
      document.getElementById('imagePreview').src = src;
    };
  })();
</script>

<?= $this->endSection('content'); ?>
