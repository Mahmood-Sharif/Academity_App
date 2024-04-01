<?php /* @var CodeIgniter\View\View $this */
$this->extend('home/template');

$this->section('content');
?>

<h1>
  <?=lang('Home.about_academity')?>
</h1>

<p>
  Academity is an innovative platform designed to transform the operational
  dynamics of sports academies. It serves as a nexus connecting sports
  academies, enthusiasts, and guardians, streamlining the process of discovery,
  enrollment, and management of sports activities. By integrating technology
  into sports education, Academity facilitates enhanced interaction and
  operational efficiency.
</p>

<h2>
  <?=lang('Home.users_app')?>
</h2>

<p>
  <?=lang('Home.users_app.info')?>
</p>

<h2>
  <?=lang('Home.coaches_app')?>
</h2>

<p>
  <?=lang('Home.coaches_app.info')?>
</p>

<h2>
  <?=lang('Home.admin_portal')?>
</h2>

<p>
  <?=lang('Home.admin_portal.info')?>
</p>


<?=$this->endSection()?>
