<?php

/**
 * The goal of this file is to allow developers a location
 * where they can overwrite core procedural functions and
 * replace them with their own. This file is loaded during
 * the bootstrap process and is called during the framework's
 * execution.
 *
 * This can be looked at as a `master helper` file that is
 * loaded early on, and may also contain additional functions
 * that you'd like to use throughout your entire application
 *
 * @see: https://codeigniter.com/user_guide/extending/common.html
 */
{}

/**
 * Map an array into an array with key-value pairs using a callback.
 *
 * @param callable $callback The callback that takes an element of the array
 * and returns an array with two elements [key, value].
 * @param array $array The array to map
 */
function key_array(callable $callback, array $array): array
{
    $result = [];
    foreach ($array as $elem) {
        [$key, $value] = $callback($elem);
        $result[$key] = $value;
    }
    return $result;
}
