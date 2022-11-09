<?php include "templates/header.php"; ?>

<?php
include 'funciones.php';
if (isset($_POST['submit'])) {
 

  
  $config = include 'config.php';

  try {
    $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
    $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);

    $alumno = [
      "nombre"   => $_POST['nombre'],
      "apellidos" => $_POST['apellidos'],
      "fecha_nac"    => $_POST['fecha_nac'],
      "carrera"     => $_POST['carrera'],
      "semestre"     => $_POST['semestre'],
      "tipo_curso"     => $_POST['tipo_curso'],
    ];
    $resultado = [
      'error' => false,
      'mensaje' => 'El alumno ' .escapar($_POST['nombre']).' ha sido agregado con exito!'
    ];

    $datosAlumnoNuevo = '"'.$alumno['nombre'].'","'.$alumno['apellidos'].'","'.$alumno['fecha_nac'].'","'.$alumno['carrera'].'",'.$alumno['semestre'].',"'.$alumno['tipo_curso'].'"';

   $AgregarAlumnos = "CALL AgregarAlumno(".$datosAlumnoNuevo.");";
   $sentenciaAgregar = $conexion->prepare($AgregarAlumnos);
   $sentenciaAgregar->execute($alumno);

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
      <h2 class="mt-4">Dar de Alta Alumno</h2>
      <hr>
      <form method="post">
        <div class="form-group">
          <label for="nombre">Nombre</label>
          <input type="text" name="nombre" id="nombre" class="form-control">
        </div>
        <div class="form-group">
          <label for="apellidos">Apellidos</label>
          <input type="text" name="apellidos" id="apellidos" class="form-control">
        </div>
        <div class="form-group">
          <label for="fecha_nac">Fecha de Nacimiento (AAAA-MM-DD)</label>
          <input type="text" name="fecha_nac" id="fecha_nac" class="form-control">
        </div>
        <div class="form-group">
          <label for="carrera">Carrera</label>
          <input type="text" name="carrera" id="carrera" class="form-control">
        </div>
        <div class="form-group">
          <label for="semestre">Semestre</label>
          <select name = "semestre" id = "semestre"class="form-select" aria-label="Default select example">
                <option value = "0" selected>Selecciona el Semestre</option>
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
          <label for="tipo_curso">Tipo de Curso</label>
          <select name = "tipo_curso" id = "tipo_curso"class="form-select" aria-label="Default select example">
                <option value = "0" selected>Selecciona el Curso</option>
                <option value="1">Escolarizado</option>
                <option value="2">En linea</option>
                <option value="3">Impulso</option>
                <option value="4">Maestria</option>
          </select>
        </div>
        <div class="form-group">
          <input type="submit" name="submit" class="btn btn-primary" value="Enviar">
          <a class="btn btn-primary" href="index.php">Volver al inicio</a>
        </div>
      </form>
    </div>
  </div>
</div>

<?php include "templates/footer.php"; ?>