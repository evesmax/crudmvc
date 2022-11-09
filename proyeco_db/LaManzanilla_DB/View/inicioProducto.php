<?php
include_once('../Conexion/db.php');

$conectar = conn();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>La Manzanilla: Productos</title>
    <link rel="icon" href="../Imagenes/quesoMesa.png">
    <link rel="stylesheet" href="../css/bootstrapNav.css">
    <link rel="stylesheet" href="../css/inicioProd.css">
    <script src="../Model/bootstrap.js"></script>
    <script type="text/javascript">
        function confirmar(){
            return confirm('¿Estas seguro de eliminar el producto?');
        }
    </script>
</head>
<body>
    <header>
        <div class="fondo-nav">
            <nav class="navbar navbar-expand-lg bg-light">
                <div id="divHeader">
                    <img src="../Imagenes/quesoMesa.png" alt="...">
                    <h1 class="headerH1">LA MANZANILLA</h1><h1 class="marcaReg">®</h1>
                </div>
                <div class="container-fluid">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Productos</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Inventarios
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Inventario movimeintos</a></li>
                                <li><a class="dropdown-item" href="#">Inventario saldos</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Ventas</a>
                        </li>
                    </ul>
                </div>
                </div>
            </nav>
        </div>
    </header>
    <div id="divContainer">
        <div id="divTitle">
            <h1 class="TitleH1">Productos</h1>
            <a href="nuevoProducto.html"><button type="button" class="nuevoP">Nuevo producto</button></a>
        </div>
        <div id="divTable">
            <table cellspacing="0" cellpadding="0">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Nombre de producto</th>
                        <th>Costo</th>
                        <th>Estado</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>

                    <?php
                    $sqlConsult="SELECT * FROM productos WHERE estatus='ACTIVO'";
                    $result = mysqli_query($conectar, $sqlConsult) or trigger_error("Query failed: SQL Error: ".mysqli_error($conectar, $sqlConsult));
                    
                    while($mostrar=mysqli_fetch_array($result)){
                    ?>

                    <tr>
                        <td id="td1"><?php echo $mostrar['idProducto']?></td>
                        <td id="td2"><?php echo $mostrar['nombre']?></td>
                        <td id="td3"><?php echo $mostrar['costo']?></td>
                        <td id="td4"><?php echo $mostrar['estatus']?></td>
                        <td>
                            <?php echo "<a class='aEditar' href='../Model/editar.php?idProducto=".$mostrar['idProducto']."'>Editar</a>";?>
                        </td>
                        <td>
                            <?php echo "<a class='aEliminar' href='../Model/eliminar.php?idProducto=".$mostrar['idProducto']."' onclick='return confirmar()'>Eliminar</a>";?>
                        </td>
                    </tr>
                        
                    <?php
                    }
                    ?>
                    
                </tbody>
            </table>
            
        </div>
    </div>
</body>
</html>
