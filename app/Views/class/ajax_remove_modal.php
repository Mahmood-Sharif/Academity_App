<?php
use App\Entities\ClassEntity;

/* @var CodeIgniter\View\View $this */
/* @var ClassEntity $class */
?>

<div class="modal-dialog modal-dialog-centered">
  <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title">
        <?=lang('App.delete_class')?>
      </h5>
    </div>
    <div class="modal-body">
      <p>
        <?=lang('App.delete_class.confirm', [$class->class_name])?>
      </p>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-danger"
        hx-post="<?=url_to('AdminPortal\Classes::delete', $class->class_id)?>" hx-target="#modals-here"
        hx-headers='{"<?= csrf_header() ?>": "<?= csrf_hash()?> "}'>
        <?=lang('App.delete_class.btn')?>
      </button>
      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
        <?=lang('App.cancel')?>
      </button>
    </div>
  </div>
</div>

