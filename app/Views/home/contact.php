<?php /* @var CodeIgniter\View\View $this */
$this->extend('home/template');

$this->section('content');
?>

<h1>
  <?=lang('Home.contact_us')?>
</h1>
<p>
  <?=lang('Home.contact_us.info')?>
</p>
<ul>
  <li>By email: <a href="mailto:mahmood.acadmity@gmail.com">mahmood.acadmity@gmail.com</a></li>
</ul>


<?=$this->endSection()?>
