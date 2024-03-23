<?php

use App\Entities\Enrollment;

/* @var CodeIgniter\View\View $this */
/* @var Enrollment $enrollment */
?>

<div class="modal-dialog modal-dialog-centered">
  <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title">
        <?=lang('App.unenrol')?>
      </h5>
    </div>
    <div class="modal-body">
      <p>
        <?=lang('App.unenrol.confirm', [$enrollment->student_name, $enrollment->class_name])?>
      </p>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-danger"
        hx-post="<?=url_to('AdminPortal\Enrollment::delete', $enrollment->enrollment_id)?>" hx-target="#modals-here"
        hx-headers='{"<?= csrf_header() ?>": "<?= csrf_hash()?> "}'>
        <?=lang('App.unenrol')?>
      </button>
      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
        <?=lang('App.cancel')?>
      </button>
    </div>
  </div>
</div>

