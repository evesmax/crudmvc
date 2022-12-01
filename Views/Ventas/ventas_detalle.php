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
                            <a class="nav-link" href="#">Productos</a>
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
        <div id="divTitle">
            <h1 class="TitleH1">Ventas</h1>
        </div>
        
        <div id="divTable">
            <div id="divCont">
            <div id="div-cont-tabla">
                <div id="divBoton">
                    <a class="aBoton" href="indexVentas.php?c=ventas&a=nuevo"><button class="boton-nuevo" type="button">Nueva Venta</button></a>
                </div>
            
                <table cellspacing="0" cellpadding="0">
                    <thead>
                        <tr class="trEncabezado">
                            <th>Id Venta</th>
                            <th>Fecha</th>
                            <th>Bodega</th>
                            <th>Id Producto</th>
                            <th>Cantidad</th>
                            <th>Costo Unitario</th>
                            <th>Total Venta</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        foreach($data["ventas"] as $dato) {
                            if(strpos($dato['total'],'.') !== false) 
                                    $total = $dato['total'].'0';
                                else{
                                    $total = $dato['total'].'.00';
                            }   
                            if(strpos($dato['costoUnitario'],'.') !== false) 
                                    $costo = $dato['costoUnitario'].'0';
                                else{
                                    $costo = $dato['costoUnitario'].'.00';
                            }
                            echo "<tr>
                                <td id='td1'>".$dato["idVenta"]."</td>
                                <td id='td22'>".$dato["fecha"]."</td>
                                <td id='td3'>".$dato["bodega"]."</td>
                                <td id='td3'>".$dato["idProducto"]."</td>
                                <td id='td3'>".$dato["cantidad"]."</td>
                                <td id='td3'>$ ".$costo."</td>
                                <td id='td4'>$ ".$total."</td>
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