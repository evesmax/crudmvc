<?php
session_start();
include_once('../Conexion/db.php');
$nombreProd = $_POST['nombreProducto'];
$costo = $_POST['costo'];
$conexion = conn();
$id = $_SESSION['id'];
    $sql = "CALL modificarProducto('$id', '$nombreProd', '$costo')";
    $result = mysqli_query($conexion, $sql) or trigger_error("Query failed: SQL Error: ".mysqli_error($conexion));

    if($result){
        echo "<script>alert('El producto se modificó correctamente');
        location.assign('../View/inicioProducto.php');</script>";
    } else {  
        echo "<script>alert('El producto no pudo modificarse de la base de datos'); 
        location.assign('../View/inicioProducto.php')</script>";
    }


?>