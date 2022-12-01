<?php

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $data["titulo"]; ?></title>
    <link rel="icon" href="../assets/Imagenes/quesoMesa.png">
    <link rel="stylesheet" href="../assets/CSS/bootstrapNav.css">
    <link rel="stylesheet" href="../assets/CSS/headeeer.css">
    <link rel="stylesheet" href="../assets/CSS/modulos-nuevo.css">
    <script src="../assets/JS/bootstrap.js"></script>
</head>
<body>
    <header>
        <div class="fondo-nav">
            <nav class="navbar navbar-expand-lg bg-light">
                <div id="divHeader">
                    <img src="../assets/Imagenes/quesoMesa.png" alt="...">
                    <h1 class="headerH1">LA MANZANILLA</h1><h1 class="marcaReg">®</h1>
                </div>
                <div class="container-fluid">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                            <a class="nav-link" href="../index.php?">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="indexProductos.php?c=producto&a=index">Productos</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Inventarios
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="indexInventarioMov.php?c=inventarioMov&a=index">Inventario movimeintos</a></li>
                                <li><a class="dropdown-item" href="indexInventarioSal.php?c=inventarioSal&a=index">Inventario saldos</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="indexVentas.php?c=ventas&a=index">Ventas</a>
                        </li>
                    </ul>
                </div>
                </div>
            </nav>
        </div>
    </header>
    <div id="divContainer">
        <div id="div-cont-titulo">
            <div id="divTitle">
                <h1 class="TitleH1">Modificar Producto</h1>
            </div>
        </div>
        <div id="divDirectorio">
            <div id="divA">
                <a class="aDire" id="a1" href="indexProductos.php?c=producto">Productos</a>
                <a class="aDire" id="a2">/</a>
                <a class="aDire" id="a3">Modificar Producto</a>
            </div>
        </div>
        <div id="divTable">
            <form id="nuevo-producto" name="nuevo-producto" method="post" action="indexProductos.php?c=producto&a=actualizar" autocomplete="off">
                <input type="hidden" id="id" name="id" value="<?php echo $data["idProducto"]; ?>">
                <p>Nuevo nombre producto:</p>
                <input class="campo" type="text" name="nombreProducto" value="<?php echo $data["productos"]["nombre"]; ?>" placeholder="Ingrese el nuevo nombre del producto">
                <p class="p2">Nuevo costo:</p>
                <input class="campo" type="text" name="costo" value="<?php echo $data["productos"]["costo"]; ?>" placeholder="Ingrese el nuevo costo del producto"><br>
                <input id="botonSub" class="botonForm" type="submit" value="Registrar">
                <input class="botonForm" type="reset" value="Borrar">
            </form>
        </div>
    </div>
</body>
</html>