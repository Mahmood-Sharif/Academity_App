<?php

function validated_form_input(string $id, string $name, string $labelText, string $value = '', string $type = 'text'): string
{
    $isError = array_key_exists($name, validation_errors());
    return '<div class="form-floating">' .
      form_input([
        'id' => $id,
        'name' => $name,
        'value' => $value,
        'type' => $type,
        'class' => 'form-control' . ($isError ? ' is-invalid' : ''),
        'placeholder' => '',
      ]) .
      form_label($labelText, $id, ['class' => 'form-label']) .
      validation_show_error($name) .
      '</div>' . "\n";
}

function validated_form_textarea(string $id, string $name, string $labelText, string $value = '', string $type = 'text'): string
{
    $isError = array_key_exists($name, validation_errors());
    return '<div class="form-floating">' .
      form_textarea([
        'id' => $id,
        'name' => $name,
        'value' => $value,
        'class' => 'form-control' . ($isError ? ' is-invalid' : ''),
        'placeholder' => '',
      ]) .
      form_label($labelText, $id, ['class' => 'form-label']) .
      validation_show_error($name) .
      '</div>' . "\n";
}

function validated_form_select(string $id, string $name, string $labelText, array $options, string $selected): string
{
    $isError = array_key_exists($name, validation_errors()) ? 'is-invalid' : '';
    $optionsDOM = '';
    foreach ($options as $value => $text) {
        $isSelected = $selected === $value;
        $optionsDOM .= "<option value=\"$value\" $isSelected>$text</option>";
    }
    return
      '<div class="form-floating">' .
      "<select id=\"$id\" name=\"$name\" class=\"form-select $isError\">" .
      $optionsDOM .
      '</select>' .
      form_label($labelText, $id, ['class' => 'form-label']) .
      validation_show_error($name) .
      '</div>' . "\n";
}

/* <div class="mb-3 form-floating"> */
/*   <select class="form-select" name="academy_id" id="academy_id"> */
/*     <?php foreach($academies as $academy): ?> */
/*     <option value="<?=$academy->academy_id?>"><?=$academy->name?></option> */
/*     <?php endforeach ?> */
/*   </select> */
/*   <label for="academy_id"> */
/*     <?=lang('App.select.academy')?> */
/*   </label> */
/* </div> */
