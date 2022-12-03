<?php 

	require_once "conexion.php";
	$conexion=conexion();

	$id=$_PoST['idjuego'];
	$sql="CALL sp_obtenerRegistro($id)";

	$result=mysqli_query($conexion,$sql);

	$ver=mysqli_fetch_row($result);

	$datos=array(
			'id_juego'=>$ver[0],
              'nombrejU'=>$ver[1],
              'aniojU'=>$ver[2],
              'empresajU'=>$ver[3]
					);
	echo json_encode($datos);
 ?>