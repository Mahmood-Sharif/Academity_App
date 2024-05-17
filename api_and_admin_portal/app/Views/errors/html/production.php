<?php /* @var CodeIgniter\View\View $this */
/* @var string $errorCode */
/* @var string $message */
$locale = service('request')->getLocale();
$dir = $locale == 'ar' ? 'rtl' : 'ltr';
$tab = ($this->sections['sidebarTab'] ?? [''])[0];
?>
<!DOCTYPE html>
<html lang="<?=$locale?>" dir="<?=$dir?>">

<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noindex">
    <title>
        <?=lang('App.error')?>
    </title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..700;1,100..700&display=swap"
        rel="preload">
    <style>
        <?=preg_replace('#[\r\n\t ]+#', ' ', file_get_contents(__DIR__ . DIRECTORY_SEPARATOR . 'debug.css')) ?>
    </style>
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
            setTheme(getPreferredTheme());
        })();
    </script>
</head>

<body>

    <div class="container text-center">

        <h1 class="headline">
            <?= isset($errorCode) ? $errorCode : lang('Errors.whoops') ?>
        </h1>

        <p class="lead">
            <?= lang('Errors.weHitASnag') ?>
        </p>

        <a href="javascript:history.back()">
            <?=lang('App.back.previous')?>
        </a>

    </div>

</body>

</html>
