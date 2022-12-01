<?php
require_once "../Models/config.php";
require_once "../Core/routesProducto.php";
require_once "../Models/database.php";
require_once "../Controllers/producto-controller.php";

if(isset($_GET['c'])){
    $controlador = cargarControlador($_GET['c']);
    if(isset($_GET['a'])){
        if(isset($_GET['id'])){
            cargarAccion($controlador, $_GET['a'], $_GET['id']);
        } else {
            cargarAccion($controlador, $_GET['a']);
        }
    } else{
        cargarAccion($controlador, ACCION_PRINCIPAL);
    }
} else {
    $controlador = cargarControlador(CONTROLADOR_PRODUCTO);
    $defaultAccion = ACCION_PRINCIPAL;
    $controlador->$defaultAccion();
}
?>