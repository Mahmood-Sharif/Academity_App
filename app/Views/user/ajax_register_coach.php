<?php

use App\Models\AcademyModel;

/* @var CodeIgniter\View\View $this */
/* @var App\Entities\User|null $coach */

/* @var array $academies */
$academies = key_array(
    fn ($academy) => [$academy->academy_id, $academy->name],
    (new AcademyModel())->findAcademiesForOwner(auth()->id())
);

helper('form');

?>

<form hx-post="" hx-swap="outerHTML" class="col-12 col-md-5">
  <?=csrf_field()?>

  <div class="alert alert-danger mb-3">
    <?=lang('App.register_coach.help')?>
  </div>

  <div class="mb-3">
    <?=validated_form_input('coachEmail', 'email', lang('App.coach_email'), set_value('email'), 'email')?>
  </div>

  <div class="mb-3">
    <?=validated_form_select('academy_id', 'academy_id', lang('App.select.academy'), $academies, set_value('academy_id'))?>
  </div>

  <button class="btn btn-success ms-auto" type="submit">
    <?=lang('App.register_coach')?>
  </button>
</form>
