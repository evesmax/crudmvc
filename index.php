<?php
require_once "Models/config.php";
require_once "Core/routes.php";
require_once "Models/database.php";
require_once "Controllers/index-controller.php";
require_once "Controllers/producto-controller.php";

if(isset($_GET['c'])){
    $controlador = cargarControlador($_GET['c']);
    if(isset($_GET['a'])){
        cargarAccion($controlador, $_GET['a']);
    } else{
        cargarAccion($controlador, ACCION_PRINCIPAL);
    }
} else {
    $controlador = cargarControlador(CONTROLADOR_PRINCIPAL);
    $defaultAccion = ACCION_PRINCIPAL;
    $controlador->$defaultAccion();
}
?>