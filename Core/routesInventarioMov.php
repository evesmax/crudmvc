<?php
function cargarControlador($controlador){
    $nombreControlador = ucwords(strtolower($controlador))."Controller";
    $archivoControlador = '../Controllers/'.strtolower($controlador).'-controller'.'.php';
    if(!is_file($archivoControlador)){
        $archivoControlador = '../Controllers/'.CONTROLADOR_INVENTARIOMOV.'-controller'.'.php';
        $nombreControlador  = ucwords(strtolower(CONTROLADOR_INVENTARIOMOV))."Controller";
    }
    require_once $archivoControlador;
    $control = new $nombreControlador();
    return $control;
}   

function cargarAccion($controller, $accion, $id = null){
    if(isset($accion) && method_exists($controller, $accion)){
        if($id == null){
            $controller->$accion();
        } else{
            $controller->$accion($id);
        }
        

    } else {
        $defaultAccion = ACCION_PRINCIPAL;
        $controller->$defaultAccion();
    }

}
?>