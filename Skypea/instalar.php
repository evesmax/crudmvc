<?php

$config = include 'config.php';

try{
$conexion = new PDO('mysql:host=' . $config['db']['host'].';dbname='.$config['db']['name'], $config['db']['user'], $config['db']['pass'], $config['db']['options']);
$script = file_get_contents('Script_Proyecto_sql.txt');
echo $script;
$conexion->exec($script);
echo "La conexión se ha establecido, la tabla ha sido creada.";
} catch(PDOException $error){
    echo $error->getMessage();
    echo "";
}

?>