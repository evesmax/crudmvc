<?php
$id = $_GET['idProducto'];
include_once('../Conexion/db.php');

$conexion = conn();

$sql = "CALL bajaProducto($id)";
$result = mysqli_query($conexion, $sql) or trigger_error("Query failed: SQL Error: ".mysqli_error($conexion));

if($result){
    echo "<script>alert('El producto se eliminó de la base de datos');
    location.assign('../View/inicioProducto.php');</script>";
} else {
    echo "<script>alert('El producto no pudo eliminarse de la base de datos'); 
    location.assign('../View/inicioProducto.php')</script>";
}
?>
