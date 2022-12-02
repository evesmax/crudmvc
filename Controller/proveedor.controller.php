<?php
//Se incluye el modelo donde conectará el controlador.
require_once 'model/proveedor.php';

class ProveedorController{

    private $model;

    //Creación del modelo
    public function __CONSTRUCT(){
        $this->model = new proveedor();
    }

    //Llamado plantilla principal
    public function Index(){
        require_once 'view/header.php';
        require_once 'view/proveedor/proveedor.php';
        require_once 'view/footer.php';
    }

    public function Crud(){
        $pvd = new proveedor();

        if(isset($_REQUEST['id_prov'])){
            $pvd = $this->model->Obtener($_REQUEST['id_prov']);
        }

        require_once 'view/header.php';
        require_once 'view/proveedor/proveedor-editar.php';
        require_once 'view/footer.php';
    }

    public function Nuevo(){
        $pvd = new proveedor();

        require_once 'view/header.php';
        require_once 'view/proveedor/proveedor-nuevo.php';
        require_once 'view/footer.php';
    }

    public function Guardar(){
        $pvd = new proveedor();

        //Captura de los datos del formulario (vista).
        $pvd->id_prov = $_REQUEST['id_prov'];
        $pvd->nombreprov = $_REQUEST['nombreprov'];
        $pvd->num_tel = $_REQUEST['num_tel'];

        $this->model->Registrar($pvd);

        header('Location: index.php');
    }
    
    public function Eliminar(){
        $this->model->Eliminar($_REQUEST['id_prov']);
        header('Location: index.php');
    }
}
