<h1 class="page-header">
    <?php echo $prod->id_prod != null ? $prod->nombreprod : 'Nuevo Registro'; ?>
</h1>

<ol class="breadcrumb">
  <li><a href="?c=producto">Productos</a></li>
  <li class="active"><?php echo $prod->id_prod != null ? $prod->nombreprod : 'Nuevo Registro'; ?></li>
</ol>

<form id="frm-producto" action="?c=producto&a=Editar" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id_prod" value="<?php echo $prod->id_prod; ?>" />

    <div class="form-group">
        <label>Codigo Proveedor</label>
        <input type="number" name="id_prov" value="<?php echo $prod->id_prov; ?>" class="form-control" placeholder="Ingrese id_proveedor" data-validacion-tipo="requerido|min:20" />
    </div>

    <div class="form-group">
        <label>Nombre Producto</label>
        <input type="text" name="nombreprod" value="<?php echo $prod->nombreprod; ?>" class="form-control" placeholder="Ingrese nombre producto" data-validacion-tipo="requerido|min:100" />
    </div>

    <div class="form-group">
        <label>Precio Unitario</label>
        <input type="text" name="costo" value="<?php echo $prod->costo; ?>" class="form-control" placeholder="Ingrese precio unitario" data-validacion-tipo="requerido|min:20" />
    </div>


    <hr />

    <div class="text-right">
        <button class="btn btn-success">Actualizar</button>
    </div>
</form>

<script>
    $(document).ready(function(){
        $("#frm-producto").submit(function(){
            return $(this).validate();
        });
    })
</script>
