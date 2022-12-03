<h1 class="page-header">
    Nuevo Registro
</h1>

<ol class="breadcrumb">
  <li><a href="?c=producto">Productos</a></li>
  <li class="active">Nuevo Registro</li>
</ol>

<form id="frm-producto" action="?c=producto&a=Guardar" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label>ID proveedor</label>
        <input type="text" name="id_prov" value="<?php echo $prod->id_prov; ?>" class="form-control" placeholder="Ingrese ID de proveedor" data-validacion-tipo="requerido|min:20" />
    </div>

<!--<div class="form-group">
        <label>Bodega</label>
        <select class="form-select" aria-label="Default select example">
            <option selected value="<?php echo $prod->bodega; ?>">Bodega1</option>
            <option value="<?php echo $prod->bodega; ?>">Bodega2</option>
            <option value="<?php echo $prod->bodega; ?>">Bodega3</option>
        </select>
    </div>-->

    <div class="form-group">
        <label>Bodega</label>
        <input type="text" name="bodega" value="<?php echo $prod->bodega; ?>" class="form-control" placeholder="Ingrese Bodega" data-validacion-tipo="requerido|min:20" />
    </div>

    <div class="form-group">
        <label>Cantidad</label>
        <input type="number" name="cantidad" value="<?php echo $prod->cantidad; ?>" class="form-control" placeholder="Ingrese Cantidad" data-validacion-tipo="requerido|min:20" />
    </div>

    <div class="form-group">
        <label>Nombre Producto</label>
        <input type="text" name="nombreprod" value="<?php echo $prod->nombreprod; ?>" class="form-control" placeholder="Ingrese Nombre Producto" data-validacion-tipo="requerido|min:100" />
    </div>

    <div class="form-group">
        <label>Precio Unitario</label>
        <input type="text" name="costo" value="<?php echo $prod->costo; ?>" class="form-control" placeholder="Ingrese Precio Unitario" data-validacion-tipo="requerido|min:20" />
    </div>

    <hr />

    <div class="text-right">
        <button class="btn btn-success">Guardar</button>
    </div>
</form>

<script>
    $(document).ready(function(){
        $("#frm-producto").submit(function(){
            return $(this).validate();
        });
    })
</script>
