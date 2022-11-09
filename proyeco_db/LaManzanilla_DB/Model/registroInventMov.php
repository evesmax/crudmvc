<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>La Manzanilla: Nuevo producto</title>
    <link rel="icon" href="../Imagenes/quesoMesa.png">
    <link rel="stylesheet" href="../css/bootstrapNav.css">
    <link rel="stylesheet" href="../css/nuevoProd.css">
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
                            <a class="nav-link" href="inicioProducto.php">Productos</a>
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
            <h1 class="TitleH1">Nuevo Registro</h1>
            <a href="inicioProducto.php"><button type="button" class="nuevoP">Productos</button></a>
        </div>
        <div id="divForm">
            <form name="form" action="../Model/invMovDB.php" method="post">
                <p>Nombre registro:</p>
                <input class="campo" type="text" name="nombreProducto" placeholder="Ingrese el nombre del nuevo producto" required>
                <p>Costo:</p>
                <input class="campo" type="text" name="costo" placeholder="Ingrese el costo del nuevo producto" required><br>
                <input id="botonSub" class="botonForm" type="submit" value="Registrar">
                <input class="botonForm" type="reset" value="Borrar">
            </form>
        </div>
    </div>
</body>
</html>