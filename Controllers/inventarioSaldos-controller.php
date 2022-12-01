<?php
class InventariosaldosController {
    public function __CONSTRUCT(){
        require_once "../Models/inventarioSaldos.php";
    }

    public function index() {
        $inventarioSaldos = new InventariosaldosModel();
        $data["titulo"] = "La Manzanilla: Inventario Saldos";
        $data["inventarioSaldos"] = $inventarioSaldos->Listar_InventarioMovimientos();

        require_once "../Views/Inventario_Saldos/inventarioSaldos.php";
    }
}
?>