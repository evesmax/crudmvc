<?php include "templates/header.php"; ?>

<?php
include 'funciones.php';
if (isset($_POST['submit'])) {
 

  
  $config = include 'config.php';

  try {
    $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
    $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);

    $materia = [
      "nombre_materia"   => $_POST['nombre_materia'],
      "num_creditos" => $_POST['num_creditos'],
      "rama"  => $_POST['rama'],
      "costo_materia"     => $_POST['costo_materia'],
    ];
    $resultado = [
      'error' => false,
      'mensaje' => 'La materia: ' .escapar($_POST['nombre_materia']).' ha sido agregada con exito!'
    ];

    $datosMateriaNueva = '"'.$materia['nombre_materia'].'","'.$materia['num_creditos'].'","'.$materia['rama'].'","'.$materia['costo_materia'].'"';

   $AgregarMateria = "CALL AgregarMateria(".$datosMateriaNueva.");";
   $sentenciaAgregar = $conexion->prepare($AgregarMateria);
   echo $AgregarMateria;
   $sentenciaAgregar->execute($materia);

  } catch(PDOException $error) {
    $resultado['error'] = true;
    $resultado['mensaje'] = $error->getMessage();
  }
  ?>
  <div class="container mt-3">
    <div class="row">
      <div class="col-md-12">
        <div class="alert alert-<?= $resultado['error'] ? 'danger' : 'success' ?>" role="alert">
          <?= $resultado['mensaje'] ?>
        </div>
      </div>
    </div>
  </div>
  <?php
}else{
  echo "PRUEBA: NO HA HABIDO SUBMIT";
}
?>
<div class="container">
  <div class="row">
    <div class="col-md-12">
      <h2 class="mt-4">Nueva Materia:</h2>
      <hr>
      <form method="post">
        <div class="form-group">
          <label for="nombre_materia">Nombre de la Materia</label>
          <input type="text" name="nombre_materia" id="nombre_materia" class="form-control">
        </div>
        <div class="form-group">
          <label for="num_creditos">Numero de Creditos</label>
          <input type="text" name="num_creditos" id="num_creditos" class="form-control">
        </div>
        <div class="form-group">
          <label for="rama">Semestre</label>
          <select name = "rama" id = "rama"class="form-select" aria-label="Default select example">
                <option value = "0" selected>Selecciona la Rama</option>
                <option value="1">Ingenierias</option>
                <option value="2">Economico-Administrativas</option>
                <option value="3">Ciencias de la Salud</option>
                <option value="4">Sociales y Humanidades</option>
                <option value="5"> Tronco Comun</option>
                <option value="6">Taller</option>
            </select>
        </div>
        <div class="form-group">
          <label for="costo_materia">Costo de la Materia</label>
          <input type="text" name="costo_materia" id="costo_materia" class="form-control">
        </div>
        <div class="form-group">
          <input type="submit" name="submit" class="btn btn-primary" value="Enviar">
          <a class="btn btn-primary" href="index_materias.php">Volver al inicio</a>
        </div>
      </form>
    </div>
  </div>
</div>

<?php include "templates/footer.php"; ?>