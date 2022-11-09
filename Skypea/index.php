<?php
include 'funciones.php';

$error = false;
$config = include 'config.php';

try {
  $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
  $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);

$ConsultaAlumnosProcedure = "CALL ListarAlumnos();";
$SentenciaProcedureListar = $conexion->prepare($ConsultaAlumnosProcedure);
$SentenciaProcedureListar->execute();
$alumnos = $SentenciaProcedureListar->fetchAll();
//print_r ($alumnos);

} catch(PDOException $error) {
  $error = $error->getMessage();
}
?>
<?php include "templates/header.php"; ?>  
<?php
if ($error) {
  ?>
  <div class="container mt-2">
    <div class="row">
      <div class="col-md-12">
        <div class="alert alert-danger" role="alert">
          <?= $error ?>
        </div>
      </div>
    </div>
  </div>
  <?php
}
?>



<div class="container">
  <div class="row">
    <div class="col-md-12">
      <a href="crear.php"  class="btn btn-primary mt-4">Crear alumno</a>
      <hr>
      <form method="post" class="form-inline">
        <div class="form-group mr-3">
          <input type="text" id="apellidos" name="apellidos" placeholder="Buscar por apellido" class="form-control">
        </div>
        <button type="submit" name="submit" class="btn btn-primary">Aun no funciona</button>
      </form>
    </div>
  </div>
</div>

<div class="container">
  <div class="row">
    <div class="col-md-12">
      <h2 class="mt-3">Lista de alumnos</h2>
      <table class="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellidos</th>
            <th>Fecha de Nacimiento</th>
            <th>Carrera</th>
            <th>Semestre</th>
            <th>Numero de Materias</th>
            <th>Modalidad</th>
            <th>Colegiatura Total</th>
            <th>Estado</th>
          </tr>
        </thead>
        <tbody>
          <?php
          if ($alumnos && $SentenciaProcedureListar->rowCount() > 0) {
            foreach ($alumnos as $fila) {
              ?>
              <tr>
                <td><?php echo escapar($fila["id_alumno"]); ?></td>
                <td><?php echo escapar($fila["nombres"]); ?></td>
                <td><?php echo escapar($fila["apellidos"]); ?></td>
                <td><?php echo escapar($fila["fecha_nac"]); ?></td>
                <td><?php echo escapar($fila["carrera"]); ?></td>
                <td><?php echo escapar($fila["semestre"]); ?></td>
                <td><?php echo escapar($fila["num_materias"]); ?></td>
                <td><?php echo escapar($fila["tipo_curso"]); ?></td>
                <td><?php echo escapar($fila["colegiatura"]); ?></td>
                <td><?php echo escapar($fila["estado"]); ?></td>
              </tr>
              <?php
            }
          }
          ?>
        <tbody>
      </table>
    </div>
  </div>
</div>
   <?php  include "templates/footer.php"; ?>

