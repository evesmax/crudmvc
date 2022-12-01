<?php
function cargarControlador($controlador){
    $nombreControlador = ucwords(strtolower($controlador))."Controller";
    $archivoControlador = 'Controllers/'.strtolower($controlador).'-controller'.'.php';
    if(!is_file($archivoControlador)){
        $archivoControlador = 'Controllers/'.CONTROLADOR_PRINCIPAL.'-controller'.'.php';
        $nombreControlador  = ucwords(strtolower(CONTROLADOR_PRINCIPAL))."Controller";
    }
    require_once $archivoControlador;
    $control = new $nombreControlador();
    return $control;
}   
?>