<?php
include_once('../Conexion/db.php');
//Recibo todos los datos del formulario
$nombreProd = $_POST['nombreProducto'];
$costo = $_POST['costo'];

$conectar = conn(); //Ejecuta la conexion a la base de datos.
$sql="CALL altaProducto('$nombreProd','$costo')";
$resul = mysqli_query($conectar, $sql) or trigger_error("Query failed: SQL Error: ".mysqli_error($conectar, $sql));

echo "<script>alert('El producto ya se registró'); 
    location.assign('../View/inicioProducto.php')</script>";
?>

    
