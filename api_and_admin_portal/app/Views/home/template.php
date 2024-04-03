<?php /* @var CodeIgniter\View\View $this */
$locale = service('request')->getLocale();
$dir = $locale == 'ar' ? 'rtl' : 'ltr';
?>
<!DOCTYPE html>
<html lang="<?=$locale?>" dir="<?=$dir?>">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
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
</head>

<body>
  <nav class="navbar navbar-expand-md bg-body-tertiary">
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
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <?=lang('Home.business')?>
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
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <!-- <?=$locale == 'en' ? lang('App.language.english') : lang('App.language.arabic')?> -->
              <?= lang('App.language') ?>
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
              role="button">
              <i id="theme-icon-active" class="bi bi-circle-half"></i>
              <span class="d-none" id="bd-theme-text">Toggle theme</span>
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

  <div class="container my-5">
    <div style="min-height: 45dvh;">
      <?= $this->renderSection('content')?>
    </div>

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
</body>

</html>
