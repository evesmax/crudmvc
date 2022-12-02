<?php
require_once 'model/producto.php';

class ProductoController{

    private $model;

    public function __CONSTRUCT(){
        $this->model = new producto();
    }

    //Llamado plantilla principal
    public function Index(){
        require_once 'view/header.php';
        require_once 'view/producto/producto.php';
        require_once 'view/footer.php';
    }

    public function Crud(){
        $prod = new producto();

        if(isset($_REQUEST['id_prod'])){
            $prod = $this->model->Obtener($_REQUEST['id_prod']);
        }

        require_once 'view/header.php';
        require_once 'view/producto/producto-editar.php';
        require_once 'view/footer.php';
    }

    public function Nuevo(){
        $prod = new producto();

        require_once 'view/header.php';
        require_once 'view/producto/producto-nuevo.php';
        require_once 'view/footer.php';
    }

    public function Guardar(){
        $prod = new producto();

        $prod->nombreprod = $_REQUEST['nombreprod'];
        $prod->id_prov = $_REQUEST['id_prov'];
        $prod->bodega = $_REQUEST['bodega'];
        $prod->cantidad = $_REQUEST['cantidad'];
        $prod->costo = $_REQUEST['costo'];

        $this->model->Registrar($prod);

        header('Location: index.php?c=producto');
    }

    public function Eliminar(){
        $this->model->Eliminar($_REQUEST['id_prod']);
        header('Location: index.php?c=producto');
    }

    public function Editar(){
        $prod = new producto();

        $prod->id_prov = $_REQUEST['id_prov'];
        $prod->nombreprod = $_REQUEST['nombreprod'];
        $prod->costo = $_REQUEST['costo'];

        $this->model->Actualizar($prod);

        header('Location: index.php?c=producto');
    }
}
