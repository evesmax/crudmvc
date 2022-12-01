<?php
session_start();
$_SESSION['idV'];

class VentasModel {
    private $db;
    private $ventasT;
    private $ventasD;

    public function __CONSTRUCT(){
        $this->db = Conectar::conexion();
        $this->ventasT = array();
        $this->ventasD = array();
    }

    public function Listar_Ventas(){
        $sql = "SELECT * FROM totalVentas";
        $resultado = $this->db->query($sql);
        while($row = $resultado->fetch_assoc()){
            $this->ventasT[] = $row;
        }
        return $this->ventasT;
    }

    public function Insert__($bodega, $idProducto, $cantidad){
        if(isset($_SESSION['idV'])){
            $_SESSION['idV']=$_SESSION['idV'];
        } else{
            $select = $this->db->query("SELECT MAX(idVenta) FROM ventas");
            $row=mysqli_fetch_array($select,MYSQLI_NUM);
            $_SESSION['idV'] = $row[0];
            if(isset($_SESSION['idV'])){
                $_SESSION['idV'] = $row[0];
            } else{
                $_SESSION['idV'] = 1;
            }
        }
        $idV = $_SESSION['idV'];
        $resultado = $this->db->query("INSERT INTO VENTAS (idVenta, fecha, bodega, idProducto, cantidad) VALUES ($idV, now(), $bodega, $idProducto, $cantidad)");
        $resultado2 = $this->db->query("CALL ventasTotal();");
    }

    public function Insert__2($bodega, $idProducto, $cantidad){
        if(isset($_SESSION['idV'])){
            $_SESSION['idV'] = $_SESSION['idV'];
            $idV = $_SESSION['idV'];
            $resultado = $this->db->query("INSERT INTO VENTAS (idVenta, fecha, bodega, idProducto, cantidad) VALUES ($idV, now(), $bodega, $idProducto, $cantidad)");
            $resultado2 = $this->db->query("CALL ventasTotal();");
            $_SESSION['idV'] = $_SESSION['idV']+1;
        }
        
    }

    public function getDetalleVenta($idVenta){
        $sql = "SELECT * FROM ventas WHERE idVenta = $idVenta";
        $resultado = $this->db->query($sql);
        while($row = $resultado->fetch_assoc()){
            $this->ventasD[] = $row;
        }
        return $this->ventasD;
    }

    public function GetProductos(){
        $sql = "SELECT * FROM productos WHERE estatus='ACTIVO'";
        $resultado = $this->db->query($sql);
        while($row = $resultado->fetch_assoc()){
            $this->inventarioMovimientos[] = $row;
        }
        return $this->inventarioMovimientos;
    }
}
?>