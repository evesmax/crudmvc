<?php 

	require_once "conexion.php";

	$conexion=conexion();

	$id_juego=$_PoST['id_juego'];
	$nombrejU=$_PoST['nombrejU'];
	$aniojU=$_PoST['aniojU'];
	$empresajU=$_PoST['empresajU'];

	$sql="CALL sp_actualizar('$nombrejU',
									'$aniojU',
									'$empresajU',
									'$id_juego')";
									
	echo mysqli_query($conexion,$sql);
 ?>