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
 try {
  $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
  $conexionMATERIA = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);
  

  $sentencia2 = "CALL ListarMaterias();";
  echo $sentencia2;
  $sentenciaED1 = $conexionMATERIA->prepare($sentencia2);
  $sentenciaED1->execute();
  $listamateriasSELECT = $sentenciaED1->fetchAll();
  /*print_r($listamateriasSELECT);*/
  echo "<br/>";
 

} catch(PDOException $error) {
  $resultado['error'] = true;
  $resultado['mensaje'] = $error->getMessage();
}


try {
  $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
  $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);
    

  $consultaSQL = "SELECT id_alumno,(SELECT nombre_materia from materias where id_materia = asignacion_carga.id_materia) as 'Materia',fecha_asignacion FROM asignacion_carga WHERE id_alumno =" . $id_alumno;

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();
  $listamaterias = $sentencia->fetchAll();
  print_r($listamaterias);
 

  if (!$listamaterias) {
    $resultado['error'] = true;
    $resultado['mensaje'] = 'Este alumno aun no tiene materias, empieza tu aventura universitaria ';
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
/*---      ISSET DEL POST DE LA ASIGNACION NUEVA---*/ 
if (isset($_POST['submit'])) {
 

  
  $config = include 'config.php';

  try {
    $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
    $conexion3 = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);

    $asignacion = [
      "id_alumno"   => $_GET['id_alumno'],
      "id_materia" => $_POST['materia'],
    ];
  
    $resultado = [
      'error' => false,
      'mensaje' => 'La materia' .escapar($listamaterias['Materia']).' ha sido agregada con exito!'
    ];
    if($asignacion['id_materia'] != 0){
    $AgregarMateria = "insert into asignacion_carga (id_alumno,id_materia,fecha_asignacion)values(".$_GET['id_alumno'].",".$asignacion['id_materia'].",now());";
   $sentenciaAgregar = $conexion->prepare($AgregarMateria);
   $sentenciaAgregar->execute();

    }else{
      $resultado['error'] = true;
      $resultado['mensaje'] = "NO selecionaste una materia, intenta con otra";
    }

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
<?php require "templates/header.php"; ?>
<!-- código de la página -->

<div class="container">
  <div class="row">
    <div class="col-md-12">
      <h2 id ="tituloAlumnos" class="mt-3">Lista de materias asignadas</h2>
      <table class="table">
        <thead>
          <tr>
            <th>Alumno</th>
            <th>Materia</th>
            <th>Fecha de Asignacion</th>
          </tr>
        </thead>
        <tbody>
          <?php
          if ($listamaterias && $sentencia->rowCount() > 0) {
            foreach ($listamaterias as $fila) {
              ?>
              <tr>
                <td><?php echo escapar($fila["id_alumno"]); ?></td>
                <td><?php echo escapar($fila["Materia"]); ?></td>
                <td><?php echo escapar($fila["fecha_asignacion"]); ?></td>
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

<a style ="margin-left: 120px "class="btn btn-primary" href="index_alumnos.php">Volver al inicio</a>
<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal"> Agregar Materias</button>
<!-- Button trigger modal -->



<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Asignar nueva materia</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Selecciona la materia que quieras Asignar
        <div class="container">
  <div class="row">
    <div class="col-md-12">
      <hr>
      <form method="post">
        <div class="form-group">
          <label for="materia">Materia</label>
          <select name = "materia" id = "materia"class="form-select" aria-label="Default select example"required>
          <option selected value="0">Selecciona la materia</option>
            <?php
                      if ($listamateriasSELECT && $sentenciaED1->rowCount() > 0) {
                        foreach ($listamateriasSELECT as $fila) {
                          ?>
                          <option value="<?php echo $fila['id_materia'];?>"><?php echo $fila['nombre_materia']?></option>
                          <?php
                        }
                      }
            ?>
            </select>
        </div>
        <div class="form-group">
          <input type="submit" name="submit" class="btn btn-primary" value="Registrar">
        </div>
      </form>
    </div>
  </div>
</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>



<?php require "templates/footer.php"; ?>