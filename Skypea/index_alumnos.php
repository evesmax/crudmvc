<?php

include 'funciones.php';

$error = false;
$config = include 'config.php';

try {
  $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
  $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);

$ConsultaAlumnosProcedure = "CALL ListarAlumnos();";
$SentenciaProcedureListar1 = $conexion->prepare($ConsultaAlumnosProcedure);
$SentenciaProcedureListar1->execute();
$alumnos = $SentenciaProcedureListar1->fetchAll();

$dsn1 = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
$conexion1 = new PDO($dsn1, $config['db']['user'], $config['db']['pass'], $config['db']['options']);

$ConsultaMateriasProcedure = "CALL ListarMaterias();";
$SentenciaProcedureListar2 = $conexion1->prepare($ConsultaMateriasProcedure);
$SentenciaProcedureListar2->execute();
$materias = $SentenciaProcedureListar2->fetchAll();

$dsn2 = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
$conexion2 = new PDO($dsn2, $config['db']['user'], $config['db']['pass'], $config['db']['options']);


//print_r ($alumnos);

if (isset($_POST['apellidoBuscar'])) {
  $ConsultaBuscarApellido = "SELECT * FROM alumnos WHERE apellidos LIKE '%" . $_POST['apellidoBuscar'] . "%';";
echo $ConsultaBuscarApellido;
$SentenciaProcedureListar1 = $conexion->prepare($ConsultaBuscarApellido);
$SentenciaProcedureListar1->execute();
$alumnos = $SentenciaProcedureListar1->fetchAll();
if(empty($alumnos)){
  echo '<script language="javascript">alert("No se han encontrado resultados, intenta con diferentes combinaciones.");</script>';
}
} else {
  //echo "no ha habido submit buscar";
}
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

<nav class="navbar navbar-expand-lg " style="background-color: white;">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="logo Skypea.png" alt="Logo" width="400" height="100" class="d-inline-block align-text-top">
                
              </a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="http://localhost/Skypea/inicio/entrada.php">Inicio</a>
              </li>
              <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="http://localhost/Skypea/index_alumnos.php">Alumnos</a>
              </li>
              <li class="nav-item">
                <a class="nav-link active" href="http://localhost/Skypea/index_materias.php">Materias</a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Descubre más
                </a>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="#">Action</a></li>
                  <li><a class="dropdown-item" href="#">Another action</a></li>
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="#">Something else here</a></li>
                </ul>
              </li>
              <li class="nav-item">
                <a class="nav-link disabled">  Pagina Oficial de la Universidad Politecnica de Skypea</a>
              </li>
            </ul>
            <form class="d-flex" role="search">
              <input class="form-control me-2" type="search" placeholder="No funciona" aria-label="Search">
              <button class="btn btn-outline-success" type="submit">Beta</button>
            </form>
          </div>
        </div>
      </nav>



<div class="container">
  <div class="row">
    <div class="col-md-12">
      <a href="crear.php"  class="btn btn-primary mt-4">Agregar Alumno</a>
      <hr>
      <form method="post" class="row g-3">
        <div class="col-auto">
          <input type="text" id="apellidos" name="apellidoBuscar" placeholder="Buscar por apellido" class="form-control">
        </div>
        <div class="col-auto">
          <button id ="mostrarRes" type="submit" name="submit" class="btn btn-success">Buscar</button>
        </div>
      </form>
    </div>
  </div>
</div>

<div class="container">
  <div class="row">
    <div class="col-md-12">
      <h2 id ="tituloAlumnos" class="mt-3">Lista de alumnos</h2>
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
            <th>Opciones</th>
          </tr>
        </thead>
        <tbody>
          <?php
          if ($alumnos && $SentenciaProcedureListar1->rowCount() > 0) {
            foreach ($alumnos as $fila) {
              ?>
              <tr>
                <td><?php $b = $fila["nombres"].' '.$fila["apellidos"];echo escapar($fila["id_alumno"]); ?></td>
                <td><?php echo escapar($fila["nombres"]); ?></td>
                <td><?php echo escapar($fila["apellidos"]); ?></td>
                <td><?php echo escapar($fila["fecha_nac"]); ?></td>
                <td><?php echo escapar($fila["carrera"]); ?></td>
                <td><?php echo escapar($fila["semestre"]); ?></td>
                <td><?php echo escapar($fila["num_materias"]); ?></td>
                <td><?php echo escapar($fila["tipo_curso"]); ?></td>
                <td><?php echo escapar($fila["colegiatura"]); ?></td>
                <td><?php echo escapar($fila["estado"]); ?></td>
                <td>
                <a onclick = "return confirmar('<?php echo $b;?>')" href="<?= 'borrar_alumno.php?id_alumno=' . escapar($fila["id_alumno"]) ?>"><button><span class="material-symbols-outlined">delete</span></button></a>
                <a href="<?= 'editar.php?id_alumno=' . escapar($fila["id_alumno"]) ?>" . ><button><span class="material-symbols-outlined">construction</span></button></a>
                <a href="<?= 'asignarmaterias.php?id_alumno=' . escapar($fila["id_alumno"]) ?>" . ><button><span class="material-symbols-outlined">app_registration</span></button></a>

                </td>
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

