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
  <li>By email:
    <ul>
      <li>
        <a href="mailto:mahmood.acadmity@gmail.com">mahmood.acadmity@gmail.com</a>
      </li>
      <li>
        <a href="mailto:yara.academity@gmail.com">yara.acadmity@gmail.com</a>
      </li>
    </ul>
  </li>
</ul>


<?=$this->endSection()?>
