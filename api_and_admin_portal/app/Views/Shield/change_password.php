<?php /* @var CodeIgniter\View\View $this */ ?>
<?= $this->extend(config('Auth')->views['layout']) ?>

<?= $this->section('title') ?>
<?= lang('Auth.change_password') ?>
<?= $this->endSection() ?>

<?= $this->section('main') ?>

<div class="container d-flex flex-column align-items-center justify-content-center p-3 p-md-5">
  <div class="col-8 col-md-5 mb-5">
    <svg viewBox="0 0 500 93.333336" alt="Academity" class="img-fluid">
      <?php readfile(ROOTPATH . 'public/images/logofull.svg') ?>
    </svg>
  </div>
  <div class="card col-12 col-md-7 col-lg-6 shadow-sm">
    <div class="card-body">
      <div class="d-flex align-items-center mb-3">
        <a hx-boost="false" href="javascript:history.back()" class="btn text-danger text-danger p-0 me-2">
          <i class="bi bi-arrow-left-short fs-1"></i>
        </a>
        <h5>
          <?= lang('App.change_password') ?>
        </h5>
      </div>

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

      <?php if (session('message') !== null) : ?>
      <div class="alert alert-success" role="alert">
        <?= session('message') ?>
      </div>
      <?php endif ?>

      <form action="<?= url_to('AdminPortal\User::changePassword') ?>" method="post">
        <?= csrf_field() ?>

        <!-- Old Password -->
        <div class="form-floating mb-4">
          <input type="password" class="form-control" id="floatingCPasswordInput" name="password" inputmode="text"
            autocomplete="current-password" placeholder="<?= lang('Auth.old_password') ?>" required>
          <label for="floatingCPasswordInput">
            <?= lang('Auth.old_password') ?>
          </label>
        </div>

        <!-- New Password -->
        <div class="form-floating mb-4">
          <input type="password" class="form-control" id="floatingNPasswordInput" name="new_password" inputmode="text"
            autocomplete="new-password" placeholder="<?= lang('Auth.new_password') ?>" required>
          <label for="floatingNPasswordInput">
            <?= lang('Auth.new_password') ?>
          </label>
        </div>

        <!-- New Password Again -->
        <div class="form-floating mb-4">
          <input type="password" class="form-control" id="floatingNCPasswordInput" name="confirm_password"
            inputmode="text" autocomplete="new-password" placeholder="<?= lang('Auth.new_pass_again') ?>" required>
          <label for="floatingNCPasswordInput">
            <?= lang('Auth.new_pass_again') ?>
          </label>
        </div>

        <div class="d-grid col-12 col-md-8 mx-auto m-3">
          <button type="submit" class="btn btn-primary btn-block">
            <?= lang('App.change_password') ?>
          </button>
        </div>

      </form>
    </div>
  </div>
</div>

<?= $this->endSection() ?>
