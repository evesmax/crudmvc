<?php
// Configuración necesaria para acceder a la base de datos.
function conn(){
    //Generando la conexión
    $conectar = mysqli_connect('localhost','root','','lamanzanilla_db');
    return $conectar;
}
?>