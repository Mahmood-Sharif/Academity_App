<?php /* @var CodeIgniter\View\View $this */ ?>

<?= $this->extend(config('Auth')->views['layout']) ?>

<?= $this->section('title') ?>
<?= lang('Auth.register') ?>
<?= $this->endSection() ?>

<?= $this->section('main') ?>

<div class="container d-flex flex-column align-items-center justify-content-center p-3 p-md-5">
  <div class="col-8 col-md-5 mb-5">
    <svg viewBox="0 0 500 93.333336" alt="Academity" class="img-fluid">
      <?php readfile(ROOTPATH . 'public/images/logofull.svg') ?>
    </svg>
  </div>
  <div class="card col-12 p-md-7 col-lg-6 shadow-sm">
    <div class="card-body">
      <h5 class="card-title mb-5">
        <?= lang('Auth.register') ?>
      </h5>

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

      <form action="<?= url_to('register') ?>" method="post">
        <?= csrf_field() ?>

        <!-- Name -->
        <div class="form-floating mb-3">
          <input type="text" class="form-control" id="floatingLastNameInput" name="name" inputmode="text"
            autocomplete="name" placeholder="<?= lang('Auth.name') ?>" value="<?= old('name') ?>" required>
          <label for="floatingLastNameInput">
            <?= lang('Auth.name') ?>
          </label>
        </div>

        <!-- Phone -->
        <div class="form-floating mb-3">
          <input type="tel" class="form-control" id="floatingPhoneInput" name="phone" inputmode="tel" autocomplete="tel"
            placeholder="<?= lang('Auth.phone') ?>" value="<?= old('phone') ?>" required>
          <label for="floatingPhoneInput">
            <?= lang('Auth.phone') ?>
          </label>
        </div>

        <!-- DOB -->
        <div class="form-floating mb-3">
          <input type="date" class="form-control" id="floatingDobInput" name="dob" autocomplete="bday"
            placeholder="<?= lang('Auth.dob') ?>" value="<?= old('dob') ?>" required>
          <label for="floatingDobInput">
            <?= lang('Auth.dob') ?>
          </label>
        </div>

        <!-- Gender -->
        <fieldset class="mb-3">
          <legend class="text-body fs-6">
            <?=lang('Auth.gender')?>
          </legend>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="gender" id="inlineRadio1" value="Male" required>
            <label class="form-check-label" for="inlineRadio1">
              <?=lang('Auth.gender.male')?>
            </label>
          </div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="gender" id="inlineRadio2" value="Female" required>
            <label class="form-check-label" for="inlineRadio2">
              <?=lang('Auth.gender.female')?>
            </label>
          </div>
        </fieldset>


        <!-- Email -->
        <div class="form-floating mb-3">
          <input type="email" class="form-control" id="floatingEmailInput" name="email" inputmode="email"
            autocomplete="email" placeholder="<?= lang('Auth.email') ?>" value="<?= old('email') ?>" required>
          <label for="floatingEmailInput">
            <?= lang('Auth.email') ?>
          </label>
        </div>


        <!-- Password -->
        <div class="form-floating mb-3">
          <input type="password" class="form-control" id="floatingPasswordInput" name="password" inputmode="text"
            autocomplete="new-password" placeholder="<?= lang('Auth.password') ?>" required>
          <label for="floatingPasswordInput">
            <?= lang('Auth.password') ?>
          </label>
        </div>

        <!-- Password (Again) -->
        <div class="form-floating mb-5">
          <input type="password" class="form-control" id="floatingPasswordConfirmInput" name="password_confirm"
            inputmode="text" autocomplete="new-password" placeholder="<?= lang('Auth.passwordConfirm') ?>" required>
          <label for="floatingPasswordConfirmInput">
            <?= lang('Auth.passwordConfirm') ?>
          </label>
        </div>

        <input type="hidden" name="username" value="">

        <div class="d-grid col-12 col-md-8 mx-auto m-3">
          <button type="submit" class="btn btn-primary btn-block">
            <?= lang('Auth.register') ?>
          </button>
        </div>

        <p class="text-center">
          <?= lang('Auth.haveAccount') ?> <a href="<?= url_to('login') ?>">
            <?= lang('Auth.login') ?>
          </a>
        </p>

      </form>
    </div>
  </div>
</div>

<?= $this->endSection() ?>
