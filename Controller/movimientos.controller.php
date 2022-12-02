<?php
//Se incluye el modelo donde conectará el controlador.
require_once 'model/movimientos.php';

class MovimientosController{

    private $model;

    //Creación del modelo
    public function __CONSTRUCT(){
        $this->model = new movimiento();
    }

    //Llamado plantilla principal
    public function Index(){
        require_once 'view/header.php';
        require_once 'view/movimientos/movimientos.php';
        require_once 'view/footer.php';
    }
}
