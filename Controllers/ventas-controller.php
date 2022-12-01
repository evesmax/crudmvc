<?php
class VentasController {
    private $fun1;
    private $fun2;

    public function __CONSTRUCT(){
        $ventas = new VentasModel();
        require_once "../Models/ventas.php";
    }

    public function index() {
        $ventas = new VentasModel();
        $data["titulo"] = "La Manzanilla: Ventas";
        $data["ventas"] = $ventas->Listar_Ventas();

        require_once "../Views/Ventas/ventas.php";
    }

    public function nuevo(){
        $ventas = new VentasModel();
        $data["titulo"] = "La Manzanilla: Nueva Venta";
        $data["ventas"] = $ventas->GetProductos();

        require_once "../Views/Ventas/ventas_nuevo.php";
    }

    public function detalleVenta($idVenta){
        $ventas = new VentasModel();
        $data["titulo"] = "La Manzanilla: Ventas";
        $data["ventas"] = $ventas->getDetalleVenta($idVenta);

        require_once "../Views/Ventas/ventas_detalle.php";
    }
    
    public function guarda(){
        if(isset($_POST['botonCarrito'])){
            $bodega = $_POST['bodega'];
            $idProductoC = $_POST['idProductos'];
            $idP = explode(" ", $idProductoC);
            $idProd = $idP[0];
            $cantidad = $_POST['cantidad'];
            $ventas = new VentasModel();
            $ventas->Insert__($bodega, $idProd, $cantidad);
            $data["titulo"] = "La Manzanilla: Nueva venta";
            $this->nuevo();
        }
        if(isset($_POST['botonFinalizar'])){
            $bodega = $_POST['bodega'];
            $idProductoC = $_POST['idProductos'];
            $idP = explode(" ", $idProductoC);
            $idProd = $idP[0];
            $cantidad = $_POST['cantidad'];
            $ventas = new VentasModel();
            $ventas->Insert__2($bodega, $idProd, $cantidad);
            $data["titulo"] = "La Manzanilla: Nueva venta";
            $this->index();
        }
    }
}
?>