<?php

use App\Models\ClassModel;

use App\Entities\ClassEntity;

/* @var CodeIgniter\View\View $this */

/* @var int $academyId */
/* @var int $classId */
/* @var integer $numTimings */
/* @var ClassEntity[] $classes */
$classes = (new ClassModel())
    ->limitByOwner(auth()->id())
    ->includeClassesPerWeek()
    ->where('classes.academy_id', $academyId)
    ->findAll();

$classesMap = key_array(
    fn ($class) => [$class->class_id, [
                'text' => $class->class_name,
                'attributes' => "data-classes-per-week=\"$class->classes_per_week\"",
            ]],
    $classes
);

$academyId = request()->getGet('academy_id');

helper('form');

$optionsDOM = '';
foreach ($classesMap as $value => $obj) {
    $text =  $obj['text'];
    $extraAttributes = $obj['attributes'] ;
    $isSelected = array_key_first($classesMap) == $value ? 'selected' : '';
    $optionsDOM .= "<option value=\"$value\" $isSelected $extraAttributes>$text</option>";
}

echo $optionsDOM;
