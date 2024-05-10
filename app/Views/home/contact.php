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
        <a href="mailto:mahmood.academity@gmail.com">mahmood.academity@gmail.com</a>
      </li>
      <li>
        <a href="mailto:yara.academity@gmail.com">yara.academity@gmail.com</a>
      </li>
    </ul>
  </li>
</ul>


<?=$this->endSection()?>
