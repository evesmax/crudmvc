<?php 

	require_once "conexion.php";

	$conexion=conexion();

	$nombre=$_PoST['nombrej'];
	$anio=$_PoST['anioj'];
	$empresa=$_PoST['empresaj'];

	$sql="CALL sp_insertarDatos('$nombre','$anio','$empresa')";

	echo mysqli_query($conexion,$sql);

 ?>