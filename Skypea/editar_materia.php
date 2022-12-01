<?php
 $id_materia = $_GET['id_materia'];
include 'funciones.php';

$config = include 'config.php';

$resultado = [
  'error' => false,
  'mensaje' => ''
];

if (!isset($_GET['id_materia'])) {
  $resultado['error'] = true;
  $resultado['mensaje'] = 'La materia no existe';
}
if (isset($_POST['submit'])) {
  try {
    $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
    $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);
    

    $materia1 = [
      "nombre_materia"   => $_POST['nombre_materia'],
      "num_creditos" => $_POST['num_creditos'],
      "rama"    => $_POST['rama'],
      "costo_materia"     => $_POST['costo_materia'],
    ];
    //print_r ($materia1);
    $datosmaterianueva1 = $_GET['id_materia'].','.'"'.$materia1['nombre_materia'].'","'.$materia1['num_creditos'].'","'.$materia1['rama'].'","'.$materia1['costo_materia'].'"';
     echo $datosmaterianueva1;
    //echo "<br/>". $_GET['id_materia'];
    $sentenciaEditar = "CALL editarmateria(".$datosmaterianueva1.");";
   // echo "<br/>".$sentenciaEditar;
    $sentenciaED = $conexion->prepare($sentenciaEditar);
    $sentenciaED->execute($materia1);
    //echo "<br/>".$sentenciaEditar;

  } catch(PDOException $error) {
    $resultado['error'] = true;
    $resultado['mensaje'] = $error->getMessage();
  }
}
try {
  $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
  $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);
    

  $consultaSQL = "SELECT * FROM materias WHERE id_materia =" . $id_materia;

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();

  $materia = $sentencia->fetch(PDO::FETCH_ASSOC);
  //print_r($materia);

  if (!$materia) {
    $resultado['error'] = true;
    $resultado['mensaje'] = 'No se ha encontrado la materia';
  }

} catch(PDOException $error) {
  $resultado['error'] = true;
  $resultado['mensaje'] = $error->getMessage();
}

?>
<?php
if ($resultado['error']) {
  ?>
  <div class="container mt-2">
    <div class="row">
      <div class="col-md-12">
        <div class="alert alert-danger" role="alert">
          <?= $resultado['mensaje'] ?>
        </div>
      </div>
    </div>
  </div>
  <?php
}
?>
<?php
if (isset($_POST['submit']) && !$resultado['error']) {
  ?>
  <div class="container mt-2">
    <div class="row">
      <div class="col-md-12">
        <div class="alert alert-success" role="alert">
          La materia ha sido actualizada correctamente
        </div>
      </div>
    </div>
  </div>
  <?php
}
?>
<?php require "templates/header.php"; ?>
<!-- código de la página -->
<?php
if (isset($materia) && $materia) {
  ?>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h2 class="mt-4">Editando la materia <?= escapar($materia['nombre_materia'])?></h2>
        <hr>
        <form method="post">
          <div class="form-group">
            <label for="nombre_materia">Nombre de la Materia:</label>
            <input type="text" name="nombre_materia" id="nombre_materia" placeholder="<?= escapar($materia['nombre_materia']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="apellido">Numero de Creditos</label>
            <input type="number" min ="0" name="num_creditos" id="num_creditos" placeholder="<?= escapar($materia['num_creditos']) ?>" class="form-control">
          </div>
          <div class="form-group">
          <label for="tipo_curso">Rama</label>
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
            <input type="number" min ="1000" name="costo_materia" id="costo_materia" placeholder="<?= escapar($materia['costo_materia']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <input type="submit" name="submit" class="btn btn-primary" value="Actualizar">
            <a class="btn btn-primary" href="index_materias.php">Regresar al inicio</a>
          </div>
          
        </form>
      </div>
    </div>
  </div>
  <?php
}
?>




<?php require "templates/footer.php"; ?>