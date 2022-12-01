<?php
class InventariosaldosModel {
    private $db;
    private $inventarioSaldos;

    public function __CONSTRUCT(){
        $this->db = Conectar::conexion();
        $this->inventarioSaldos = array();
    }

    public function Listar_InventarioMovimientos(){
        $sql = "SELECT * FROM inventario_saldos";
        $resultado = $this->db->query($sql);
        while($row = $resultado->fetch_assoc()){
            $this->inventarioSaldos[] = $row;
        }
        return $this->inventarioSaldos;
    }
}
?>