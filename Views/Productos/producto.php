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
            <h1 class="TitleH1">Productos</h1>
        </div>
        
        <div id="divTable">
            <div id="divCont">
            <div id="div-cont-tabla">
                <div id="divBoton">
                    <a class="aBoton" href="indexProductos.php?c=producto&a=nuevo"><button class="boton-nuevo" type="button">Nuevo producto</button></a>
                </div>
            
                <table cellspacing="0" cellpadding="0">
                    <thead>
                        <tr class="trEncabezado">
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
                        foreach($data["productos"] as $dato) {
                            if(strpos($dato['costo'],'.') !== false) 
                                    $costo = $dato['costo'].'0';
                                else{
                                    $costo = $dato['costo'].'.00';
                            }   
                            echo "<tr>
                                <td id='td1'>".$dato["idProducto"]."</td>
                                <td id='td2'>".$dato["nombre"]."</td>
                                <td id='td3'>$ ".$costo."</td>
                                <td id='td4'>".$dato["estatus"]."</td>
                                <td id='td5'><a href='indexProductos.php?c=producto&a=modificar&id=".$dato["idProducto"]."'><img class='editarIcon' src='../assets/Imagenes/icons8-editar-propiedad-30.png'></img></a></td>
                                <td id='td6'><a href='indexProductos.php?c=producto&a=eliminar&id=".$dato["idProducto"]."' onclick='return confirmar()''><svg fill='#000000' xmlns='http://www.w3.org/2000/svg'  viewBox='0 0 24 24' width='24px' height='24px'>    <path d='M 10 2 L 9 3 L 5 3 C 4.448 3 4 3.448 4 4 C 4 4.552 4.448 5 5 5 L 7 5 L 17 5 L 19 5 C 19.552 5 20 4.552 20 4 C 20 3.448 19.552 3 19 3 L 15 3 L 14 2 L 10 2 z M 5 7 L 5 20 C 5 21.105 5.895 22 7 22 L 17 22 C 18.105 22 19 21.105 19 20 L 19 7 L 5 7 z'/></svg></a></td>
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