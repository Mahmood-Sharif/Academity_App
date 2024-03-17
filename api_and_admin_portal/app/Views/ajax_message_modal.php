<?php
/* @var CodeIgniter\View\View $this */
/* @var string $title */
/* @var string $body */
/* @var string $action */
/* @var string $actionUrl */
?>

<div class="modal-dialog modal-dialog-centered">
  <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title">
        <?=$title?>
      </h5>
    </div>
    <div class="modal-body">
      <p>
        <?=$body?>
      </p>
    </div>
    <div class="modal-footer">
    <?php if (isset($action)) : ?>
      <a href="<?=$actionUrl?>" class="btn btn-secondary">
        <?=$action?>
      </a>
    <?php else: ?>
      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
        <?=lang('App.close')?>
      </button>
    <?php endif ?>
    </div>
  </div>
</div>

