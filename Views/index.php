<?php

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>La Manzanilla</title>
    <link rel="icon" href="assets/Imagenes/quesoMesa.png">
    <link rel="stylesheet" href="assets/CSS/indexMVC.css">
    <script src="assets/JS/bootstrap.js"></script>
    <script src="assets/JS/index.js"></script>
</head>
<body>
    <div id="divContainer">
        <header class="header">
            <div class="divLogo">
                <a href="#"><img class="logo" src="assets/Imagenes/quesoMesa.png" alt=""></a>
                <h1 class="tituloNav">LA  MANZANILLA</h1><h1 class="marcaReg">®</h1>
            </div>
            <nav class="navbar">
                <ul class="ulNavbar">
                    <li class="item2">
                        <a class="link2" href="Views/indexProductos.php?c=producto&a=index">Productos</a>
                    </li>
                    <li class="item3">
                        <a class="link3" href="Views/indexInventarioMov.php?c=inventarioMov&a=index">Inventario movimientos</a>
                    </li>
                    <li class="item4">
                        <a class="link4" href="Views/indexInventarioSal.php?c=inventarioSal&a=index">Inventario Saldos</a>
                    </li>
                    <li class="item1">
                        <a class="link1" href="Views/indexVentas.php?c=ventas&a=index">Ventas</a>
                    </li>
                </ul>
            </nav>
        </header>
        <div id="contain">
            <div id="fondo">

            </div>
        </div>
        
    </div>
    <div class="anuncio-container">
        <div class="anuncio">
            <div id="text1" class="textoFondo">LA</div>
            <div class="textoFondo">MANZANILLA</div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="assets/JS/jquery.js"></script>
</body>
</html>