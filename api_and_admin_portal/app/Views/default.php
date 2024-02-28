<?php /* @var CodeIgniter\View\View $this */
$locale = service('request')->getLocale();
$dir = $locale == 'ar' ? 'rtl' : 'ltr';
$tab = $this->sections['sidebarTab'][0];
?>
<!DOCTYPE html>
<html lang="<?=$locale?>" dir="<?=$dir?>">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="view-transition" content="same-origin">
  <title>
    Academity -
    <?= $this->renderSection('page_title', true) ?>
  </title>
  <?php if ($dir == 'rtl'): ?>
  <link href="/css/academity-bootstrap.min.rtl.css" rel="stylesheet">
  <?php else: ?>
  <link href="/css/academity-bootstrap.min.css" rel="stylesheet">
  <?php endif ?>
  <link href="/css/academity-custom.css" rel="stylesheet">
  <script src="/js/bootstrap.bundle.min.js"></script>
</head>

<body>

  <div class="row m-0 p-0">
    <div id="sidebar" class="col-lg-3 col-md-4 col-12 border-end border-2 p-4">
      <div class="nav nav-pills nav-fill flex-column gap-1">
        <span class="fs-2 fw-bold text-center mb-3">
          <?= lang('App.academity_admin_portal') ?>
        </span>
        <a href="<?= url_to('AdminPortal\Controller::dashboard')?>"
          class="nav-link <?= $tab == 'dashboard' ? 'active' : '' ?>">
          <?=lang('App.dashboard')?>
        </a>
        <a href="<?= url_to('AdminPortal\Academy::index')?>"
          class="nav-link <?= $tab == 'academies' ? 'active' : '' ?>">
          <?=lang('App.my_academies')?>
        </a>
        <a href="analytics" class="nav-link <?= $tab == 'analytics' ? 'active' : '' ?>">
          <?=lang('App.analytics')?>
        </a>
        <a href="announcements" class="nav-link <?= $tab == 'announcements' ? 'active' : '' ?>">
          <?=lang('App.announcements')?>
        </a>
        <a href="students" class="nav-link <?= $tab == 'students' ? 'active' : '' ?>">
          <?=lang('App.students')?>
        </a>
        <a href="reviews" class="nav-link <?= $tab == 'reviews' ? 'active' : '' ?>">
          <?=lang('App.reviews')?>
        </a>
        <a href="offers" class="nav-link <?= $tab == 'offers' ? 'active' : '' ?>">
          <?=lang('App.offers')?>
        </a>
        <a href="accounting" class="nav-link <?= $tab == 'accounting' ? 'active' : '' ?>">
          <?=lang('App.accounting')?>
        </a>
      </div>
    </div>
    <div class="col p-4">
      <div class="container">
        <?= $this->renderSection('content') ?>
      </div>
    </div>
  </div>
</body>

</html>
