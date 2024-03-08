<?php

use App\Models\AcademyModel;

use App\Entities\Academy;

/* @var CodeIgniter\View\View $this */

/* @var Academy[] $academies */
$academies = key_array(
    fn ($academy) => [$academy->academy_id, $academy->name],
    (new AcademyModel())->findAcademiesForOwner(auth()->id())
);

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
echo lang('App.register_coach');
$this->endSection('page_title');

$this->section('sidebarTab');
echo 'academies';
$this->endSection('sidebarTab');
?>

<?= $this->section('content'); ?>

<div class="container">
  <div class="d-flex align-items-start">
    <div>
      <h1>
        <?=lang('App.register_coach')?>
      </h1>
      <!-- <h2 class="text-muted">academy name</h2> -->
      <!-- <h2 class="text-muted">class name</h2> -->
    </div>
  </div>

  <form hx-post="">
    <?=csrf_field()?>

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



</div>

<?= $this->endSection('content'); ?>
