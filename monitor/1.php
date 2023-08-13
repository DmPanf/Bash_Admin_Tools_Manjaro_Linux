<?php

// Подключаем файл стилей
echo '<head><meta charset="UTF-8"><link rel="stylesheet" type="text/css" href="1.css"></head>';
echo '<body><h1 align="center">✈️  Выполнение команды на сервере 💡</h1><br>';

echo '<nav role="navigation">';

// Если кнопка была нажата, то печатаем значения по имени полей Формы
if (isset($_GET['submit']))
{
$Dir=$_GET['radio1'];
$File=$_GET['radio2'];
$myFile=$Dir . "/" . $File;
$text=$_GET['Code'];

$old=file_get_contents($myFile);
echo '<a href="">☢️ OLD=[' . $old . '] ☢️ </a><br>';
//записываем текст в файл (кодовое значение из Формы)
file_put_contents($myFile, $text);

echo '<a href="">🖥 ' . $Dir . '</a>';
echo '<a href="">🌐 ' . $File . '</a>';
echo '<a href="">💾 ' . $text . '</a><br>';
echo '<a href="">🏠 ' . $myFile . '</a><br>';

}

//выводим текущее время
echo '<br><h1>⏱  ' . date('h:i:s') . ' ⏳(7 сек.)</h1>';
echo '<br><form><input type="button" style="background: #004d40; color: #a0ff2f; font-size: 65px; border-radius: 18px;" value="⬅️ НАЗАД" onClick="history.back();return true;"></form>';
echo '</nav></body>';

$myUrl=$_SERVER["HTTP_REFERER"];
header("Refresh: 7; url=$myUrl");

?>
