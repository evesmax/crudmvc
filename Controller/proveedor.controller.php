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

    //Llamado a la vista proveedor-editar
    public function Crud(){
        $pvd = new proveedor();

        //Se obtienen los datos del proveedor a editar.
        if(isset($_REQUEST['id_prov'])){
            $pvd = $this->model->Obtener($_REQUEST['id_prov']);
        }

        //Llamado de las vistas.
        require_once 'view/header.php';
        require_once 'view/proveedor/proveedor-editar.php';
        require_once 'view/footer.php';
  }

    //Llamado a la vista proveedor-nuevo
    public function Nuevo(){
        $pvd = new proveedor();

        //Llamado de las vistas.
        require_once 'view/header.php';
        require_once 'view/proveedor/proveedor-nuevo.php';
        require_once 'view/footer.php';
    }

    //Método que registrar al modelo un nuevo proveedor.
    public function Guardar(){
        $pvd = new proveedor();

        //Captura de los datos del formulario (vista).
        $pvd->id_prov = $_REQUEST['id_prov'];
        $pvd->nombreprov = $_REQUEST['nombreprov'];
        $pvd->num_tel = $_REQUEST['num_tel'];

        //Registro al modelo proveedor.
        $this->model->Registrar($pvd);

        header('Location: index.php');
    }

    //Método que modifica el modelo de un proveedor.
    public function Editar(){
        $pvd = new proveedor();

        $pvd->id_prov = $_REQUEST['id_prov'];
        $pvd->nombreprov = $_REQUEST['nombreprov'];
        $pvd->num_tel = $_REQUEST['num_tel'];

        $this->model->Actualizar($pvd);

        header('Location: index.php');
    }

    //Método que elimina la tupla proveedor con el id_prov dado.
    public function Eliminar(){
        $this->model->Eliminar($_REQUEST['id_prov']);
        header('Location: index.php');
    }
}
