<?php
require_once 'model/saldos.php';

class SaldosController{

    private $model;

    public function __CONSTRUCT(){
        $this->model = new saldo();
    }

    //Llamado plantilla principal
    public function Index(){
        require_once 'view/header.php';
        require_once 'view/saldos/saldos.php';
        require_once 'view/footer.php';
    }

    public function Crud(){
        $prod = new saldo();

        if(isset($_REQUEST['id_saldo'])){
            $prod = $this->model->Obtener($_REQUEST['id_saldo']);
        }

        require_once 'view/header.php';
        require_once 'view/saldos/saldos-editar.php';
        require_once 'view/footer.php';
    }

    public function Nuevo(){
        $prod = new saldo();

        require_once 'view/header.php';
        require_once 'view/saldos/saldos-nuevo.php';
        require_once 'view/footer.php';
    }
    public function Agregar(){
        $prod = new saldo();

        $prod->id_prod = $_REQUEST['id_prod'];
        $prod->cantidad = $_REQUEST['cantidad'];
    
        $this->model->Sumar($prod);

        header('Location: index.php?c=saldos');
    }
    public function Quitar(){
        $prod = new saldo();

        $prod->id_prod = $_REQUEST['id_prod'];
        $prod->cantidad = $_REQUEST['cantidad'];
    
        $this->model->Restar($prod);

        header('Location: index.php?c=saldos');
    }
    public function Mas(){
        $prod = new saldo();

        require_once 'view/header.php';
        require_once 'view/saldos/saldos-agregar.php';
        require_once 'view/footer.php';
    }

    public function Menos(){
        $prod = new saldo();

        require_once 'view/header.php';
        require_once 'view/saldos/saldos-quitar.php';
        require_once 'view/footer.php';
    }
}
