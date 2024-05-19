<?php /* @var CodeIgniter\View\View $this */
$locale = service('request')->getLocale();
$dir = $locale == 'ar' ? 'rtl' : 'ltr';
?>
<!DOCTYPE html>
<html lang="<?=$locale?>" dir="<?=$dir?>">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="view-transition" content="same-origin">
  <title>
    <?=lang('Home.academity')?>
  </title>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..700;1,100..700&display=swap"
    rel="preload" as="style">
  <?php if ($dir == 'rtl'): ?>
  <link href="/css/academity-bootstrap.min.rtl.css" rel="stylesheet">
  <?php else: ?>
  <link href="/css/academity-bootstrap.min.css" rel="stylesheet">
  <?php endif ?>
  <link rel="preload" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" as="style"
    onload="this.onload=null;this.rel='stylesheet'">
  <link href="/css/academity-custom.css" rel="stylesheet">
  <link rel='shortcut icon' type='image/x-icon' href='/favicon.ico' />
  <script id="bootstrapScript" defer src="/js/bootstrap.bundle.min.js"></script>
  <script>
    /*!
     * Color mode toggler for Bootstrap's docs (https://getbootstrap.com/)
     * Copyright 2011-2024 The Bootstrap Authors
     * Licensed under the Creative Commons Attribution 3.0 Unported License.
     */

    (() => {
      'use strict'

      const getStoredTheme = () => localStorage.getItem('theme')
      const setStoredTheme = theme => localStorage.setItem('theme', theme)

      const getPreferredTheme = () => {
        const storedTheme = getStoredTheme()
        if (storedTheme) {
          return storedTheme
        }

        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
      }

      const setTheme = theme => {
        if (theme === 'auto') {
          document.documentElement.setAttribute('data-bs-theme', (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'))
        } else {
          document.documentElement.setAttribute('data-bs-theme', theme)
        }
      }

      setTheme(getPreferredTheme())

      const showActiveTheme = (theme, focus = false) => {
        const themeSwitcher = document.querySelector('#bd-theme')

        if (!themeSwitcher) {
          return
        }

        const themeSwitcherText = document.querySelector('#bd-theme-text')
        const activeThemeIcon = document.querySelector('#theme-icon-active')
        const btnToActive = document.querySelector(`[data-bs-theme-value="${theme}"]`)
        const classesOfActiveBtn = btnToActive.querySelector('.bi').classList.toString()

        document.querySelectorAll('[data-bs-theme-value]').forEach(element => {
          element.classList.remove('active')
          element.setAttribute('aria-pressed', 'false')
        })

        btnToActive.classList.add('active')
        btnToActive.setAttribute('aria-pressed', 'true')
        activeThemeIcon.classList = classesOfActiveBtn;
        const themeSwitcherLabel = `${themeSwitcherText.textContent} (${btnToActive.dataset.bsThemeValue})`
        themeSwitcher.setAttribute('aria-label', themeSwitcherLabel)

        if (focus) {
          themeSwitcher.focus()
        }
      }

      window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
        const storedTheme = getStoredTheme()
        if (storedTheme !== 'light' && storedTheme !== 'dark') {
          setTheme(getPreferredTheme())
        }
      })

      window.addEventListener('DOMContentLoaded', () => {
        showActiveTheme(getPreferredTheme())

        document.querySelectorAll('[data-bs-theme-value]')
          .forEach(toggle => {
            toggle.addEventListener('click', () => {
              const theme = toggle.getAttribute('data-bs-theme-value')
              setStoredTheme(theme)
              setTheme(theme)
              showActiveTheme(theme, true)
            })
          })
      })
    })()
  </script>
  <style>
    [data-bs-theme="dark"] .navbar::before {
      content: '';
      display: block;
      width: 100%;
      height: calc(100% + 2rem);
      position: absolute;
      z-index: -1;
      background: linear-gradient(0deg, transparent, var(--bs-body-bg));
    }

    .hero {
      background: linear-gradient(0deg, transparent, #fffffff0, transparent);
      border-radius: 3em;
    }

    [data-bs-theme="dark"] .hero {
      background: linear-gradient(0deg, transparent, var(--bs-body-bg) 20%, #00000080);
      border-radius: 3em;
    }

    .navbar-nav .dropdown-menu {
      position: absolute !important;
    }
  </style>
</head>

<body>
  <div class="hero-background position-absolute z-n1 border-bottom w-100" style="height: 71vh">
    <img src="<?=base_url('images/home/hero_background.svg')?>" class="w-100 h-100 object-fit-cover" alt=""
      loading="lazy">
  </div>

  <nav class="navbar navbar-expand-md">
    <div class="container">
      <a class="navbar-brand fw-bold" href="/<?=$locale?>">
        <svg height="24" viewBox="0 0 500 93.333336">
          <?php readfile(ROOTPATH . 'public/images/logofull.svg') ?>
        </svg>
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0 gap-3 d-grid d-md-flex mt-3 mt-md-0"
          style="grid-template-columns: 1fr 1fr;">
          <li class="nav-item" data-bs-theme="dark">
            <a href="#download" class="btn btn-secondary rounded-pill shadow">
              <?=lang('Home.download_app')?>
            </a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
              title="<?=lang('Home.business')?>">
              <div class="d-none">
                <?php readfile(ROOTPATH . 'public/images/whistle.svg') ?>
              </div>
              <svg width="20" height="20" viewBox="0 0 16 16" class="me-1" style="vertical-align: -.275em;">
                <use href="#whistle"></use>
              </svg>
              <span class="d-md-none">
                <?=lang('Home.academity')?>
              </span>
            </a>
            <ul class="dropdown-menu">
              <li class="nav-item">
                <a class="dropdown-item" href="<?=url_to('home_about')?>">
                  <?=lang('Home.about')?>
                </a>
              </li>
              <li class="nav-item">
                <a class="dropdown-item" href="<?=url_to('home_privacy')?>">
                  <?=lang('Home.privacy_policy')?>
                </a>
              </li>
              <li class="nav-item">
                <a class="dropdown-item" href="<?=url_to('login')?>">
                  <?=lang('Home.login_admin_portal')?>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
              title="<?=lang('App.language')?>">
              <!-- <?=$locale == 'en' ? lang('App.language.english') : lang('App.language.arabic')?> -->
              <i class="bi bi-globe2"></i>
              <span class="d-md-none">
                <?=lang('App.language')?>
              </span>
            </a>
            <ul class="dropdown-menu">
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
          </li>
          <li class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" id="bd-theme" data-bs-toggle="dropdown" aria-expanded="false"
              role="button" title="<?=lang('App.theme')?>">
              <i id="theme-icon-active" class="bi bi-circle-half"></i>
              <span class="d-md-none" id="bd-theme-text">
                <?=lang('App.theme')?>
              </span>
            </a>
            <ul class="dropdown-menu dropdown-menu-start">
              <li>
                <button type="button" class="dropdown-item" data-bs-theme-value="auto">
                  <i class="bi bi-circle-half fs-5 me-1"></i>
                  <?=lang('App.theme.system')?>
                </button>
              </li>
              <li>
                <button type="button" class="dropdown-item" data-bs-theme-value="light">
                  <i class="bi bi-sun fs-5 me-1"></i>
                  <?=lang('App.theme.light')?>
                </button>
              </li>
              <li>
                <button type="button" class="dropdown-item" data-bs-theme-value="dark">
                  <i class="bi bi-moon fs-5 me-1"></i>
                  <?=lang('App.theme.dark')?>
                </button>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div style="overflow-x: clip;">
    <div class="container mb-5">
      <section class="mb-5" style="min-height: 45dvh;">
        <div class="hero row pt-md-5 px-md-5 p-sm-0">
          <div class="col-12 col-sm-6 col-md-6 me-auto">
            <div class="hero-text">
              <span class="fw-bold d-inline-block mt-5 text-center text-sm-start" style="font-size: 4rem;">
                <?=lang('Home.home_about')?>
              </span>
              <p class="fs-3 mt-3 text-sm-center text-md-start">
                <?=lang('Home.home_about.more')?>
              </p>
            </div>
          </div>
          <div class="col-12 col-sm-6 col-md-6">
            <img src="<?=base_url('images/home/academity_phones_1.png')?>" alt="">
          </div>
      </section>
      <section class="d-flex mb-5">
        <img src="<?=base_url('images/home/academity_info.png')?>" class="img-fluid m-auto"
          style="max-width: 850px; width: 100%" alt="">
      </section>
      <section id="download">
        <h2 class="mb-4">
          <?=lang('Home.download_app')?>
        </h2>
        <ul class="nav nav-tabs nav-fill" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="tab-dWeb" data-bs-toggle="tab" data-bs-target="#dWeb" type="button"
              role="tab" aria-controls="Web" aria-selected="true">
              <i class="bi bi-globe me-2"></i>
              Web
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="tab-diOS" data-bs-toggle="tab" data-bs-target="#diOS" type="button" role="tab"
              aria-controls="Web" aria-selected="false">
              <i class="bi bi-apple me-2"></i>
              iOS
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="tab-dAndroid" data-bs-toggle="tab" data-bs-target="#dAndroid" type="button"
              role="tab" aria-controls="Web" aria-selected="false">
              <i class="bi bi-android me-2"></i>
              Android
            </button>
          </li>
        </ul>
        <div class="tab-content p-3" id="download-tabs">
          <div class="tab-pane fade show active" id="dWeb" role="tabpanel" aria-labelledby="tab-dWeb" tabindex="0">
            <?= lang('Home.download_pwa') ?>
            <ul class="mt-3">
              <li class="mb-2">
                <?= lang('Home.download_pwa.1') ?>
              </li>
              <li class="mb-2">
                <?= lang('Home.download_pwa.2') ?>
              </li>
              <li class="mb-2">
                <?= lang('Home.download_pwa.3') ?>
              </li>
            </ul>
          </div>
          <div class="tab-pane fade" id="diOS" role="tabpanel" aria-labelledby="tab-diOS" tabindex="0">
            <?= lang('Home.download_ios') ?>
            <div class="d-flex mt-3">
              <a href="https://apps.apple.com/bh/app/academity/id6502606802" class="mx-auto">
                <img src="<?=base_url('images/home/Download_on_the_App_Store_Badge_'.$locale.'.svg')?>"
                  alt="download from app store" style="width: 10rem;">
              </a>
            </div>
          </div>
          <div class="tab-pane fade" id="dAndroid" role="tabpanel" aria-labelledby="tab-dAndroid" tabindex="0">
            <?= lang('Home.download_android') ?>

            <div class="d-flex my-3">
              <a href="<?=base_url('uploads/Academity.apk')?>" class="btn btn-secondary rounded-pill mx-auto">
                <i class="bi bi-download me-1"></i>
                <?=lang('Home.download_android.1')?>
              </a>
            </div>

            <?= lang('Home.download_android.2') ?>
          </div>
        </div>

      </section>

      <footer class="row row-cols-1 row-cols-sm-2 row-cols-md-4 py-5 my-5 border-top">
        <div class="col mb-3">
          <a href="/" class="d-flex align-items-center mb-3 link-body-emphasis text-decoration-none">
            <svg height="24" viewBox="0 0 500 93.333336">
              <use href="#svg1" />
            </svg>
          </a>
          <p class="text-body-secondary">© 2024 Academity</p>
        </div>

        <div class="col mb-3"></div>

        <div class="col mb-3">
          <h5>
            <?=lang('Home.academity')?>
          </h5>
          <ul class="nav flex-column gap-2">
            <li class="nav-item">
              <a href="<?=url_to('home')?>" class="nav-link p-0 text-body-secondary">
                <?=lang('Home.home')?>
              </a>
            </li>
            <li class="nav-item">
              <a href="<?=url_to('home_about')?>" class="nav-link p-0 text-body-secondary">
                <?=lang('Home.about')?>
              </a>
            </li>
            <li class="nav-item">
              <a href="<?=url_to('home_privacy')?>" class="nav-link p-0 text-body-secondary">
                <?=lang('Home.privacy_policy')?>
              </a>
            </li>
            <li class="nav-item">
              <a href="<?=url_to('home_contact')?>" class="nav-link p-0 text-body-secondary">
                <?=lang('Home.contact_us')?>
              </a>
            </li>
          </ul>
        </div>

        <div class="col mb-3">
          <h5>
            <?=lang('Home.business')?>
          </h5>
          <ul class="nav flex-column gap-2">
            <li class="nav-item">
              <a href="<?=url_to('login')?>" class="nav-link p-0 text-body-secondary">
                <?=lang('Home.login_admin_portal')?>
              </a>
            </li>
          </ul>
        </div>

      </footer>
    </div>
  </div>

  <script>
    window.addEventListener('DOMContentLoaded', () => {
      const mobile = /Mobile|mini|Fennec|Android|iP(ad|od|hone)/.test(navigator.appVersion);
      if (mobile) {
        let tab;
        if (/Android/.test(navigator.userAgent)) {
          tab = 'tab-dAndroid';
        } else if (/(iPhone|iPad|iPod)/.test(navigator.userAgent)) {
          tab = 'tab-diOS';
        } else {
          tab = 'tab-dWeb';
        }
        bootstrap.Tab.getOrCreateInstance(document.getElementById(tab)).show();
      }
    });
  </script>
</body>

</html>
