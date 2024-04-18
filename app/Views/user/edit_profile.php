<?php

use App\Entities\User;

/* @var CodeIgniter\View\View $this */
/* @var User $user */

$this->extend('default') ;

helper('html');
helper('form');

$this->section('page_title');
$title = lang('App.profile.edit');
$this->endSection('page_title');
?>

<?= $this->section('content'); ?>

<div class="container">
  <div class="d-flex align-items-center mb-3">
    <a href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
      <i class="bi bi-arrow-left-short fs-1"></i>
    </a>
    <h1>
      <?= $title ?>
    </h1>
  </div>

  <?php if (session('message') !== null) : ?>
  <div class="alert alert-success" role="alert">
    <?= session('message') ?>
  </div>
  <?php endif ?>
  <?php if (session('error') !== null) : ?>
  <div class="alert alert-danger" role="alert">
    <?= session('error') ?>
  </div>
  <?php elseif (session('errors') !== null) : ?>
  <div class="alert alert-danger" role="alert">
    <?php if (is_array(session('errors'))) : ?>
    <?php foreach (session('errors') as $error) : ?>
    <?= $error ?>
    <br>
    <?php endforeach ?>
    <?php else : ?>
    <?= session('errors') ?>
    <?php endif ?>
  </div>
  <?php endif ?>

  <div class="row">
    <div class="col-12 p-md-7 col-lg-6">
      <form action="<?= url_to('AdminPortal\User::editProfile') ?>" method="post">
        <?= csrf_field() ?>

        <!-- Name -->
        <div class="form-floating mb-3">
          <input type="text" class="form-control" id="floatingLastNameInput" name="name" inputmode="text"
            autocomplete="name" placeholder="<?= lang('Auth.name') ?>" value="<?= $user->name ?? set_value('name') ?>"
            required>
          <label for="floatingLastNameInput">
            <?= lang('Auth.name') ?>
          </label>
        </div>

        <!-- Phone -->
        <div class="form-floating mb-3">
          <input type="tel" class="form-control" id="floatingPhoneInput" name="phone" inputmode="tel" autocomplete="tel"
            placeholder="<?= lang('Auth.phone') ?>" value="<?= $user->phone ?? set_value('phone') ?>" required>
          <label for="floatingPhoneInput">
            <?= lang('Auth.phone') ?>
          </label>
        </div>

        <!-- DOB -->
        <div class="form-floating mb-3">
          <input type="date" class="form-control" id="floatingDobInput" name="dob" autocomplete="bday"
            placeholder="<?= lang('Auth.dob') ?>" value="<?= $user->dob ?? set_value('dob') ?>" required>
          <label for="floatingDobInput">
            <?= lang('Auth.dob') ?>
          </label>
        </div>

        <!-- Email -->
        <div class="form-floating mb-3">
          <input type="email" class="form-control" id="floatingEmailInput" name="email" inputmode="email"
            autocomplete="email" placeholder="<?= lang('Auth.email') ?>"
            value="<?= $user->email ?? set_value('email') ?>" required>
          <label for="floatingEmailInput">
            <?= lang('Auth.email') ?>
          </label>
        </div>

        <div class="d-grid col-12 col-md-8 mx-auto m-3">
          <button type="submit" class="btn btn-primary btn-block">
            <?= lang('App.save') ?>
          </button>
        </div>

      </form>

    </div>
  </div>


</div>

<?= $this->endSection('content'); ?>
