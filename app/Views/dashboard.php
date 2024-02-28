<?php /* @var CodeIgniter\View\View $this */
$this->extend('default') ;

$this->section('page_title');
echo lang('App.dashboard');
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'dashboard';
$this->endSection('sidebarTab');
?>

<?= $this->section('content'); ?>
<h1>
  <?=lang('App.dashboard')?>
</h1>

<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Veniam, tempore nisi eaque nihil quae odio omnis minima
  esse. Expedita ipsum quaerat, omnis placeat quo incidunt nisi explicabo. Commodi, ab minus.</p>

<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Veniam, tempore nisi eaque nihil quae odio omnis minima
  esse. Expedita ipsum quaerat, omnis placeat quo incidunt nisi explicabo. Commodi, ab minus.</p>

<?= $this->endSection('content'); ?>
