<?php

use App\Entities\ClassEntity;

/* @var CodeIgniter\View\View $this */
/* @var ClassEntity $class */
?>
<?=lang('App.registration_code.help')?>
<div class="d-flex mt-1">
  <div class="ms-auto me-auto border border-2 rounded p-3" style="--bs-border-style: dashed;">
    <span class="fs-1 fw-bold font-monospace user-select-all"><?=$class->reg_code?></span>
  </div>
</div>
