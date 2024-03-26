<?php /* @var CodeIgniter\View\View $this */
$this->extend('home/template');

$this->section('content');
?>
<div class="p-5 text-center bg-body-tertiary rounded-3">
  <img src="<?=base_url('images/logo_L.png')?>" alt="Academity Logo">
  <h1 class="text-body-emphasis mt-3">
    <?=lang('Home.academity')?>
  </h1>
  <p class="col-lg-8 mx-auto fs-5 text-muted py-3">
    <?=lang('Home.home_about')?>
  </p>
  <div class="d-inline-flex gap-2 mb-5">
    <a href="#" onclick="alert('Coming Soon!');"
      class="d-inline-flex align-items-center btn btn-primary btn-lg px-4 rounded-pill" type="button">
      <i class="bi bi-download me-2"></i>
      <?=lang('Home.download_app')?>
    </a>
    <a href="<?=url_to('home_about')?>" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" type="button">
      <?=lang('Home.learn_more')?>
    </a>
  </div>
</div>

<?=$this->endSection()?>
