<?php

function validated_form_input(string $id, string $name, string $labelText, string $value = '', string $type = 'text', array $attributes = [], bool $readonly = false): string
{
    $isError = array_key_exists($name, validation_errors());
    if ($readonly) {
        $attributes['readonly'] = 'readonly';
    }
    return '<div class="form-floating">' .
      form_input([
        'id' => $id,
        'name' => $name,
        'value' => $value,
        'type' => $type,
        'class' => 'form-control' . ($readonly ? '-plaintext' : '') . ($isError ? ' is-invalid' : '') ,
        'placeholder' => '',
        ...$attributes
      ]) .
      form_label($labelText, $id, ['class' => 'form-label']) .
      validation_show_error($name) .
      '</div>' . "\n";
}

function validated_form_textarea(string $id, string $name, string $labelText, string $value = '', string $type = 'text', array $attributes = [], bool $readonly = false): string
{
    $isError = array_key_exists($name, validation_errors());
    if ($readonly) {
        $attributes['readonly'] = 'readonly';
    }
    return '<div class="form-floating">' .
      form_textarea([
        'id' => $id,
        'name' => $name,
        'value' => $value,
        'class' => 'form-control' . ($readonly ? '-plaintext' : '') . ($isError ? ' is-invalid' : ''),
        'placeholder' => '',
        ...$attributes
      ]) .
      form_label($labelText, $id, ['class' => 'form-label']) .
      validation_show_error($name) .
      '</div>' . "\n";
}

function validated_form_select(string $id, string $name, string $labelText, array $options, string|null $selected, string $extraClasses = '', string $attributes = ''): string
{
    $isError = array_key_exists($name, validation_errors()) ? 'is-invalid' : '';
    $optionsDOM = '';
    foreach ($options as $value => $text) {
        $isSelected = $selected == $value ? 'selected' : '';
        $optionsDOM .= "<option value=\"$value\" $isSelected>$text</option>";
    }
    return
      "<div class=\"form-floating $extraClasses\">" .
      "<select id=\"$id\" name=\"$name\" class=\"form-select $isError\" $attributes>" .
      $optionsDOM .
      '</select>' .
      form_label($labelText, $id, ['class' => 'form-label']) .
      validation_show_error($name) .
      '</div>' . "\n";
}
