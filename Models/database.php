<?php
    class Conectar {
        public static function conexion(){
            $conexion = new mysqli("localhost", "root", "", "lamanzanilla_db");
            return $conexion;
        }
    }
?>