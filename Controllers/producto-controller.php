<?php
class ProductoController {
    public function __CONSTRUCT(){
        require_once "../Models/producto.php";
    }

    public function index() {
        $productos = new ProductoModel();
        $data["titulo"] = "La Manzanilla: Productos";
        $data["productos"] = $productos->Listar_Productos();

        require_once "../Views/Productos/producto.php";
    }

    public function nuevo(){
        $data["titulo"] = "La Manzanilla: Nuevo producto";
        require_once "../Views/Productos/producto_nuevo.php";
    }

    public function guarda(){
        $nombre = $_POST['nombreProducto'];
        $costo = $_POST['costo'];

        $productos = new ProductoModel();
        $productos->Insert__($nombre, $costo);
        $data["titulo"] = "La Manzanilla: Nuevo producto";
        $this->index();
    }

    public function modificar($id){
        $productos = new ProductoModel();
        
        $data["idProducto"] = $id;
        $data["productos"] = $productos->getProductos($id); 
        $data["titulo"] = "La Manzanilla: Modificar producto";
        require_once "../Views/Productos/producto_modifica.php";
    }

    public function actualizar(){
        $id = $_POST["id"];
        $nombreProducto = $_POST["nombreProducto"];
        $costo = $_POST["costo"];
        $productos = new ProductoModel();
        $productos->modificar($id, $nombreProducto, $costo);
        $data["titulo"] = "La Manzanilla: Modificar producto";
        $this->index();
    }

    public function eliminar($id){
        $productos = new ProductoModel();
        $productos->eliminar($id);
        $data["titulo"] = "La Manzanilla: Productos";
        $this->index();
    }
}
?>