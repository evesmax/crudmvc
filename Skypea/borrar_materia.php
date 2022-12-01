<?php
 $id_materia = $_GET['id_materia'];
include 'funciones.php';

$config = include 'config.php';

$resultado = [
  'error' => false,
  'mensaje' => ''
];

try {
  $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
  $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);
    
 
  $consultaSQL = "CALL eliminarmateria(".$id_materia.");";

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();

  header('Location: /Skypea/index_materias.php');

} catch(PDOException $error) {
  $resultado['error'] = true;
  $resultado['mensaje'] = $error->getMessage();
}
?>
<?php require "templates/header.php"; ?>
<div class="container mt-2">
  <div class="row">
    <div class="col-md-12">
      <div class="alert alert-danger" role="alert">
        <?= $resultado['mensaje'] ?>
      </div>
    </div>
  </div>
</div>
<!-- código de la página -->
<?php require "templates/footer.php"; ?>