<?php 
session_start();
$_SESSION['id'] = $_GET['idProducto'];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar producto</title>
    <link rel="icon" href="../Imagenes/quesoMesa.png">
    <link rel="stylesheet" href="../css/bootstrapNav.css">
    <link rel="stylesheet" href="../css/editar.css">
    <script src="../Model/bootstrap.js"></script>
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
                            <a class="nav-link" href="../View/inicioProducto.php">Productos</a>
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
            <h1 class="TitleH1">Modificar producto</h1>
        </div>
        <div id="divForm">
            <form name="form" action="editarProd.php" method="post">
                <p>Nuevo nombre del producto:</p>
                <input class="campo" type="text" name="nombreProducto" placeholder="Ingrese el nuevo nombre del producto">
                <p>Costo:</p>
                <input class="campo" type="text" name="costo" placeholder="Ingrese el nuevo costo del producto"><br>
                <input id="botonSub" class="botonForm" type="submit" value="Modificar">
                <input class="botonForm" type="reset" value="Borrar">
            </form>
        </div>
    </div>
</body>
</html>