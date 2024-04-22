<?php /* @var CodeIgniter\View\View $this */
$locale = service('request')->getLocale();
$dir = $locale == 'ar' ? 'rtl' : 'ltr';
$tab = ($this->sections['sidebarTab'] ?? [''])[0];
?>
<!DOCTYPE html>
<html lang="<?=$locale?>" dir="<?=$dir?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="view-transition" content="same-origin">
    <title><?= $this->renderSection('title') ?></title>

  <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..700;1,100..700&display=swap"
    rel="preload" as="style">
  <?php if ($dir == 'rtl'): ?>
  <link href="/css/academity-bootstrap.min.rtl.css" rel="stylesheet">
  <?php else: ?>
  <link href="/css/academity-bootstrap.min.css" rel="stylesheet">
  <?php endif ?>
  <link href="/css/academity-custom.css" rel="stylesheet">
  <link rel="preload" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" as="style"
    onload="this.onload=null;this.rel='stylesheet'">
  <script>
    (() => {
      'use strict'

      const getStoredTheme = () => localStorage.getItem('theme')
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
    })()
  </script>

    <?= $this->renderSection('pageStyles') ?>
</head>

<body>

    <main role="main" class="container">
        <?= $this->renderSection('main') ?>
    </main>

<?= $this->renderSection('pageScripts') ?>
</body>
</html>
