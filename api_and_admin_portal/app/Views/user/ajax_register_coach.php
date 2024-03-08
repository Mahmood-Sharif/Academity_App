<?php
/* @var CodeIgniter\View\View $this */
/* @var App\Entities\User|null $coach */

helper('form');

?>

<form hx-post="">
  <?=csrf_field()?>

  <div class="mb-3">
    <?=validated_form_input('coachEmail', 'email', lang('App.coach_email'), set_value('email'), 'email')?>
  </div>

  <div class="mb-3">
    <?= $coach?->name ?? 'No' ?>
  </div>

  <button class="btn btn-success ms-auto" type="submit">
    <?=lang('App.register_coach')?>
  </button>
  <a href="<?=current_url()?>" class="btn btn-secondary ms-3">
    <?=lang('App.reset')?>
  </a>
</form>




