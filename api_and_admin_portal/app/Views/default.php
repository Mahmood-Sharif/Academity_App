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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link href="/css/academity-custom.css" rel="stylesheet">
  <script src="/js/bootstrap.bundle.min.js"></script>
  <script src="https://unpkg.com/htmx.org@1.9.10" integrity="sha384-D1Kt99CQMDuVetoL1lrYwg5t+9QdHe7NLX/SoJYkXDFfX37iInKRy5xLSi8nO7UC" crossorigin="anonymous"></script>
  <script src="https://unpkg.com/htmx.org/dist/ext/ajax-header.js"></script>
</head>

<body hx-ext="ajax-header">

  <div class="row m-0 p-0">
    <div id="sidebar" class="col-lg-3 col-md-4 col-12 border-end border-2 p-4 d-flex flex-column sticky-top">
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
      <div class="mt-auto d-flex gap-3">
        <div class="dropup flex-fill">
          <button class="btn btn-primary dropdown-toggle w-100" data-bs-toggle="dropdown">
            <?=lang('App.profile')?>&nbsp;
          </button>
          <ul class="dropdown-menu">
            <li><a href="#" class="dropdown-item">
                <?=lang('App.profile.view')?>
              </a></li>
            <li><a href="<?=url_to('logout')?>" class="dropdown-item">
                <?=lang('App.logout')?>
              </a></li>
          </ul>
        </div>
        <div id="settingsDropdown" class="dropup flex-fill">
          <button class="btn btn-primary dropdown-toggle w-100" data-bs-toggle="dropdown" data-bs-auto-close="outside"
            aria-expanded="false">
            <?=lang('App.settings')?>&nbsp;
          </button>
          <ul class="dropdown-menu">
            <li>
              <div class="dropend">
                <button class="dropdown-item dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                  <?=lang('App.theme')?>&nbsp;
                </button>
                <ul class="dropdown-menu dropdown-menu-start">
                  <li>
                    <a href="#" class="dropdown-item">
                      <?=lang('App.theme.system')?>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="dropdown-item">
                      <?=lang('App.theme.light')?>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="dropdown-item">
                      <?=lang('App.theme.dark')?>
                    </a>
                  </li>
                </ul>
              </div>
            </li>
            <li>
              <div class="dropend">
                <button class="dropdown-item dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                  <?=lang('App.language')?>&nbsp;
                </button>
                <ul class="dropdown-menu dropdown-menu-start">
                  <li>
                    <a href="/change-locale/ar" class="dropdown-item <?= $locale == 'ar' ? 'active' : '' ?>">
                      <?=lang('App.language.arabic')?>
                    </a>
                  </li>
                  <li>
                    <a href="/change-locale/en" class="dropdown-item <?= $locale == 'en' ? 'active' : '' ?>">
                      <?=lang('App.language.english')?>
                    </a>
                  </li>
                </ul>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="col p-4">
      <?= $this->renderSection('content') ?>
    </div>
  </div>
</body>

</html>
