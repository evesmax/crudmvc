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
    <link rel="stylesheet" href="../assets/CSS/moduloos.css">
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
                                <li><a class="dropdown-item" href="#">Inventario saldos</a></li>
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
        <div id="divTitle">
            <h1 class="TitleH1">Inventario Saldos</h1>
        </div>
        
        <div id="divTable">
            
            <div id="divCont">
            <div id="div-cont-tabla">
                <div id="divBoton">
                    <a class="aDire" id="a1" href="indexInventarioMov.php?c=inventarioMovimientos&a=index">Inventario Movimientos</a>
                    <a class="aDire" id="a2">/</a>
                    <a class="aDire" id="a3">Inventario Saldos</a>
                </div>
            
                <table cellspacing="0" cellpadding="0">
                    <thead>
                        <tr class="trEncabezado">
                            <th id="th1">ID Saldo</th>
                            <th>Bodega</th>
                            <th>ID Producto</th>
                            <th>Total Entradas</th>
                            <th>Total Salidas</th>
                            <th>Saldo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        foreach($data["inventarioSaldos"] as $dato) {
                            echo "<tr>
                                <td id='td1'>".$dato["idSaldo"]."</td>
                                <td id='td22'>".$dato["bodega"]."</td>
                                <td id='td3'>".$dato["idProducto"]."</td>
                                <td id='td4'>".$dato["total_entradas"]."</td>
                                <td id='td4'>".$dato["total_salidas"]."</td>
                                <td id='td4'>".$dato["saldo"]."</td>
                            </tr>";
                        }
                        ?>
                    </tbody>
                </table>
            </div>    
            </div>
                
        </div>
    </div>
</body>
</html>