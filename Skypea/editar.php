<?php
 $id_alumno = $_GET['id_alumno'];
include 'funciones.php';

$config = include 'config.php';

$resultado = [
  'error' => false,
  'mensaje' => ''
];

if (!isset($_GET['id_alumno'])) {
  $resultado['error'] = true;
  $resultado['mensaje'] = 'El alumno no existe';
}
if (isset($_POST['submit'])) {
  try {
    $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
    $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);
    

    $alumno1 = [
      "nombre"   => $_POST['nombres'],
      "apellidos" => $_POST['apellidos'],
      "fecha_nac"    => $_POST['fecha_nac'],
      "carrera"     => $_POST['carrera'],
      "semestre"     => $_POST['semestre'],
      "tipo_curso"     => $_POST['tipo_curso'],
    ];

    $datosAlumnoNuevo1 = $_GET['id_alumno'].','.'"'.$alumno1['nombre'].'","'.$alumno1['apellidos'].'","'.$alumno1['fecha_nac'].'","'.$alumno1['carrera'].'",'.$alumno1['semestre'].','.$alumno1['tipo_curso'];
    echo $datosAlumnoNuevo1;
    echo "<br/>". $_GET['id_alumno'];
    $sentenciaEditar = "CALL editaralumno(".$datosAlumnoNuevo1.");";
    $sentenciaED = $conexion->prepare($sentenciaEditar);
    $sentenciaED->execute($alumno1);
    echo "<br/>".$sentenciaEditar;

  } catch(PDOException $error) {
    $resultado['error'] = true;
    $resultado['mensaje'] = $error->getMessage();
  }
}
try {
  $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
  $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);
    

  $consultaSQL = "SELECT * FROM alumnos WHERE id_alumno =" . $id_alumno;

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();

  $alumno = $sentencia->fetch(PDO::FETCH_ASSOC);
  print_r($alumno);

  if (!$alumno) {
    $resultado['error'] = true;
    $resultado['mensaje'] = 'No se ha encontrado el alumno';
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
          El alumno ha sido actualizado correctamente
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
if (isset($alumno) && $alumno) {
  ?>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h2 class="mt-4">Editando el alumno <?= escapar($alumno['nombres']) . ' ' . escapar($alumno['apellidos'])  ?></h2>
        <hr>
        <form method="post">
          <div class="form-group">
            <label for="nombre">Nombre</label>
            <input type="text" name="nombres" id="nombres" placeholder="<?= escapar($alumno['nombres']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="apellido">Apellidos</label>
            <input type="text" name="apellidos" id="apellidos" placeholder="<?= escapar($alumno['apellidos']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="fecha_nac">Fecha de Nacimiento</label>
            <input type="date" name="fecha_nac" id="fecha_nac" placeholder="<?= escapar($alumno['fecha_nac']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="carrera">Carrera</label>
            <input type="text" name="carrera" id="carrera" placeholder="<?= escapar($alumno['carrera']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="semestre">Semestre (ACTUAL: <?= escapar($alumno['semestre']) ?>#Semestre)</label>
            <select name = "semestre" id = "semestre"class="form-select" aria-label="Default select example">
                <option value = "0" selected>Selecicona el semestre</option>
                <option value="1">Primero</option>
                <option value="2">Segundo</option>
                <option value="3">Tercero</option>
                <option value="4">Cuarto</option>
                <option value="5">Quinto</option>
                <option value="6">Sexto</option>
                <option value="7">Septimo</option>
                <option value="8">Octavo</option>
                <option value="9">Noveno</option>
            </select>
          </div>
          <div class="form-group">
            <label for="tipo_curso">Tipo de Curso: (ACTUAL: <?= escapar($alumno['tipo_curso']) ?>)</label>
            <select name = "tipo_curso" id = "tipo_curso"class="form-select" aria-label="Default select example">
                <option value = "0" selected>Selecciona el Curso</option>
                <option value="1">Escolarizado (1)</option>
                <option value="2">En linea (2)</option>
                <option value="3">Impulso (3)</option>
                <option value="4">Maestria (4)</option>
          </select>
          </div>
          <div class="form-group">
            <input type="submit" name="submit" class="btn btn-primary" value="Actualizar">
            <a class="btn btn-primary" href="index_alumnos.php">Regresar al inicio</a>
          </div>
          
        </form>
      </div>
    </div>
  </div>
  <?php
}
?>




<?php require "templates/footer.php"; ?>