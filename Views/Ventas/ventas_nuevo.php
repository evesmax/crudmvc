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
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="../assets/JS/ventas.js"></script>
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
                <h1 class="TitleH1">Nueva Venta</h1>
            </div>
        </div>
        <div id="divDirectorio">
            <div id="divA">
                <a class="aDire" id="a1" href="indexVentas.php?c=ventas">Productos</a>
                <a class="aDire" id="a2">/</a>
                <a class="aDire" id="a3">Nueva Venta</a>
            </div>
        </div>
        <div id="divTable">
            <form id="nuevo-producto" name="nueva-venta" method="post" action="indexVentas.php?c=ventas&a=guarda" autocomplete="off">

                <p>Bodega:</p>
                    <select name="bodega" id="numBodega">
                        <option class="select" value="Seleccionar">Seleccionar bodega</option>
                        <option value="1">1</option>
                    </select>
                    <br>
                    <p>Id Producto:</p>
                    <select name="idProductos" id="idProd">
                    <option class="select" value="">Selecciona el ID del Producto</option>
                    <?php
                        foreach($data["ventas"] as $dato) {
                            echo "<tr><option class='options' value='$dato[idProducto] $dato[costo]'>$dato[idProducto] $dato[nombre]</option></tr>";
                        }  
                    ?>
                    </select>
                    <p>Cantidad:</p>
                    <input class="campo" type="text" id="cantidad" name="cantidad" value="" required>
                    <p>Costo Unitario:</p>
                    <input class='campo' type='text' id="costoU" name="costoU" value="">
                    
                <input id="botonSub" class="botonForm" type="submit" value="Agregar al carrito" name="botonCarrito">
                <input id="botonSub2" class="botonForm" type="submit" value="Finalizar venta" name="botonFinalizar">
                <input class="botonForm" type="reset" value="Borrar">
            </form>
        </div>
    </div>
    <script>
        $("#idProd").change(function() {
        var valor = $(this).val(); // Capturamos el valor del select   
        var val = valor.split(" ");
        if(val[1].includes('.')) 
            var total = val[1] + '0';
        else{
            var total = val[1] + '.00';
        }         
        $("#costoU").val('$ ' + total);
        });
    </script>
</body>
</html>