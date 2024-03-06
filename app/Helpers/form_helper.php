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
