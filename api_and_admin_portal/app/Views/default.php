<?php /* @var CodeIgniter\View\View $this */
$locale = service('request')->getLocale();
$dir = $locale == 'ar' ? 'rtl' : 'ltr';
$tab = ($this->sections['sidebarTab'] ?? [''])[0];
?>
<!DOCTYPE html>
<html lang="<?=$locale?>" dir="<?=$dir?>">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="view-transition" content="same-origin">
  <meta name="htmx-config" content='{"globalViewTransitions":true}'>
  <title>
    Academity -
    <?= $this->renderSection('page_title', true) ?>
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
  <script defer src="https://unpkg.com/htmx.org@1.9.10"
    integrity="sha384-D1Kt99CQMDuVetoL1lrYwg5t+9QdHe7NLX/SoJYkXDFfX37iInKRy5xLSi8nO7UC"
    crossorigin="anonymous"></script>
  <script defer src="https://unpkg.com/htmx.org/dist/ext/ajax-header.js"></script>
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
        const activeThemeIcon = document.querySelector('.theme-icon-active use')
        const btnToActive = document.querySelector(`[data-bs-theme-value="${theme}"]`)
        // const svgOfActiveBtn = btnToActive.querySelector('svg use').getAttribute('href')

        document.querySelectorAll('[data-bs-theme-value]').forEach(element => {
          element.classList.remove('active')
          element.setAttribute('aria-pressed', 'false')
        })

        btnToActive.classList.add('active')
        btnToActive.setAttribute('aria-pressed', 'true')
        // activeThemeIcon.setAttribute('href', svgOfActiveBtn)
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

<body hx-boost="true" hx-ext="ajax-header">

  <div class="row m-0 p-0">
    <div id="sidebar" class="col-lg-3 col-md-4 col-12 border-end border-2 p-4 d-flex flex-column sticky-md-top">
      <div class="nav nav-pills nav-fill flex-column gap-1">
        <svg viewBox="0 0 500 93.333336">
          <?php readfile(ROOTPATH . 'public/images/logofull.svg') ?>
        </svg>
        <span class="fs-4 fw-bold text-center mt-3 mb-4">
          <?= lang('App.academity_admin_portal') ?>
        </span>
        <a href="<?= url_to('AdminPortal\Academy::index')?>"
          class="nav-link <?= $tab == 'academies' ? 'active' : '' ?>">
          <i class="bi bi-mortarboard fs-5 me-1"></i>
          <?=lang('App.my_academies')?>
        </a>
        <a href="<?=url_to('AdminPortal\User::indexCoaches')?>"
          class="nav-link <?= $tab == 'coaches' ? 'active' : '' ?>">
          <div class="d-none">
            <?php readfile(ROOTPATH . 'public/images/whistle.svg') ?>
          </div>
          <svg width="20" height="20" viewBox="0 0 16 16" class="me-1" style="vertical-align: -.275em;">
            <use href="#whistle"></use>
          </svg>
          <?=lang('App.coaches')?>
        </a>
        <a href="<?=url_to('AdminPortal\Enrollment::index')?>"
          class="nav-link <?= $tab == 'students' ? 'active' : '' ?>">
          <i class="bi bi-person fs-5 me-1"></i>
          <?=lang('App.students')?>
        </a>
        <div class="div" title="<?=lang('App.coming_soon')?>">
          <a href="#" class="nav-link disabled <?= $tab == 'dashboard' ? 'active' : '' ?>">
            <i class="bi bi-grid fs-5 me-1"></i>
            <?=lang('App.dashboard')?>
          </a>
        </div>
        <div class="div" title="<?=lang('App.coming_soon')?>">
          <a href="analytics" class="nav-link disabled <?= $tab == 'analytics' ? 'active' : '' ?>">
            <i class="bi bi-clipboard-data fs-5 me-1"></i>
            <?=lang('App.analytics')?>
          </a>
        </div>
        <div class="div" title="<?=lang('App.coming_soon')?>">
          <a href="announcements" class="nav-link disabled <?= $tab == 'announcements' ? 'active' : '' ?>">
            <i class="bi bi-megaphone fs-5 me-1"></i>
            <?=lang('App.announcements')?>
          </a>
        </div>
        <div class="div" title="<?=lang('App.coming_soon')?>">
          <a href="reviews" class="nav-link disabled <?= $tab == 'reviews' ? 'active' : '' ?>">
            <i class="bi bi-chat-left-text fs-5 me-1"></i>
            <?=lang('App.reviews')?>
          </a>
        </div>
        <div class="div" title="<?=lang('App.coming_soon')?>">
          <a href="offers" class="nav-link disabled <?= $tab == 'offers' ? 'active' : '' ?>">
            <i class="bi bi-tag fs-5 me-1"></i>
            <?=lang('App.offers')?>
          </a>
        </div>
        <div class="div" title="<?=lang('App.coming_soon')?>">
          <a href="accounting" class="nav-link disabled <?= $tab == 'accounting' ? 'active' : '' ?>">
            <i class="bi bi-cash-stack fs-5 me-1"></i>
            <?=lang('App.accounting')?>
          </a>
        </div>

      </div>
      <div id="sidebarActions" class="mt-auto d-flex gap-3">
        <div class="dropup flex-fill">
          <button class="btn btn-primary dropdown-toggle w-100" data-bs-toggle="dropdown">
            <?=lang('App.profile')?>&nbsp;
          </button>
          <ul class="dropdown-menu">
            <li><a href="<?=url_to('AdminPortal\User::showOwner')?>" class="dropdown-item">
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
              <div id="theme-changer" class="dropend" hx-preserve="true">
                <button class="dropdown-item dropdown-toggle" id="bd-theme" data-bs-toggle="dropdown"
                  aria-expanded="false">
                  <span id="bd-theme-text">
                    <?=lang('App.theme')?>
                  </span>
                  &nbsp;
                </button>
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
              </div>
            </li>
            <li>
              <div class="dropend" hx-boost="false">
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
