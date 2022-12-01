<?php
class InventariomovimientosModel {
    private $db;
    private $inventarioMovimientos;

    public function __CONSTRUCT(){
        $this->db = Conectar::conexion();
        $this->inventarioMovimientos = array();
    }

    public function Listar_InventarioMovimientos(){
        $sql = "SELECT * FROM inventario_movimientos";
        $resultado = $this->db->query($sql);
        while($row = $resultado->fetch_assoc()){
            $this->inventarioMovimientos[] = $row;
        }
        return $this->inventarioMovimientos;
    }

    public function GetProductos(){
        $sql = "SELECT * FROM productos WHERE estatus='ACTIVO'";
        $resultado = $this->db->query($sql);
        while($row = $resultado->fetch_assoc()){
            $this->inventarioMovimientos[] = $row;
        }
        return $this->inventarioMovimientos;
    }

    public function Insert__($bodega, $idProducto, $cantidad){
        $resultado = $this->db->query("INSERT INTO inventario_movimientos (fecha, bodega, idProducto, cantidad, tipo) VALUES (now(), $bodega, $idProducto, $cantidad, 'Entrada')");
    }
}
?>