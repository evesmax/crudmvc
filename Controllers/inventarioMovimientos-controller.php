<?php
class InventariomovimientosController {
    public function __CONSTRUCT(){
        require_once "../Models/inventarioMovimientos.php";
    }

    public function index() {
        $inventarioMovimientos = new InventariomovimientosModel();
        $data["titulo"] = "La Manzanilla: Inventario Movimientos";
        $data["inventarioMovimientos"] = $inventarioMovimientos->Listar_InventarioMovimientos();

        require_once "../Views/Inventario_Movimientos/inventarioMovimientos.php";
    }

    public function nuevo(){
        $inventarioMovimientos = new InventariomovimientosModel();
        $data["titulo"] = "La Manzanilla: Nuevo Registro";
        $data["inventarioMovimientos"] = $inventarioMovimientos->GetProductos();

        require_once "../Views/Inventario_Movimientos/inventarioMovimientos_nuevo.php";
    }
    

    public function guarda(){
        $bodega = $_POST['bodega'];
        $idProducto = $_POST['idProductos'];
        $cantidad = $_POST['cantidad'];

        $inventarioMovimientos = new InventariomovimientosModel();
        $inventarioMovimientos->Insert__($bodega, $idProducto, $cantidad);
        $data["titulo"] = "La Manzanilla: Inventario Movimientos";
        $this->index();
    }
}
?>