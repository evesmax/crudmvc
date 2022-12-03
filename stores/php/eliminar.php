<?php 

	require_once "conexion.php";

	$conexion=conexion();
	$id=$_PoST['idjuego'];
	$sql="CALL sp_eliminarDatos('$id')";
	echo mysqli_query($conexion,$sql);
 ?>