<?php
class ProductoModel {
    private $db;
    private $productos;

    public function __CONSTRUCT(){
        $this->db = Conectar::conexion();
        $this->productos = array();
    }

    public function Listar_Productos(){
        $sql = "SELECT * FROM productos WHERE estatus = 'ACTIVO'";
        $resultado = $this->db->query($sql);
        while($row = $resultado->fetch_assoc()){
            $this->productos[] = $row;
        }
        return $this->productos;
    }

    public function Insert__($nombreProducto, $costo){
        $resultado = $this->db->query("CALL altaProducto('$nombreProducto','$costo')");
    }

    public function modificar($id, $nombreProducto, $costo){
        $resultado = $this->db->query("CALL modificarProducto('$id', '$nombreProducto', '$costo')");
    }

    public function eliminar($id){
        $resultado = $this->db->query("CALL bajaProducto($id)");
    }

    public function getProductos($id){
        $sql = "SELECT * FROM productos WHERE idProducto='$id' LIMIT 1";
        $resultado = $this->db->query($sql);
        $row = $resultado->fetch_assoc();
        return $row;
    }
}
?>