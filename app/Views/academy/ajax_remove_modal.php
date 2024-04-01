<?php
/* @var CodeIgniter\View\View $this */
/* @var string|false $error */
/* @var Academy $academy */
?>

<?php if ($error === false): ?>

<div class="modal-dialog modal-dialog-centered">
  <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title">
        <?=lang('App.delete_academy')?>
      </h5>
    </div>
    <div class="modal-body">
      <p>
        <?=lang('App.delete_academy.confirm', [$academy->name])?>
      </p>
      <div class="form-floating mb-3">
        <input class="form-control" type="text" name="academyNameConfirm" placeholder="">
        <label for="academyNameConfirm">
          <?=lang('App.academy_name')?>
        </label>
      </div>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-danger"
        hx-post="<?=url_to('AdminPortal\Academy::delete', $academy->academy_id)?>" hx-target="#modals-here"
        hx-include="[name='academyNameConfirm']" hx-headers='{"<?= csrf_header() ?>": "<?= csrf_hash()?> "}'>
        <?=lang('App.delete_academy.btn')?>
      </button>
      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
        <?=lang('App.cancel')?>
      </button>
    </div>
  </div>
</div>

<?php else: ?>

<div class="modal-dialog modal-dialog-centered">
  <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title">
        <?=lang('App.delete_academy')?>
      </h5>
    </div>
    <div class="modal-body">
      <p>
        <?=$error?>
      </p>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
    </div>
  </div>
</div>

<?php endif ?>
