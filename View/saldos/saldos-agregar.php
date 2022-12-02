<h1 class="page-header">
    <?php echo $prod->id_saldo != null ? $prod->bodega : 'Nuevo Registro'; ?>
</h1>

<ol class="breadcrumb">
  <li><a href="?c=proveedor">Proveedores</a></li>
  <li class="active"><?php echo $prod->id_saldo!= null ? $prod->bodega : 'Quitar Producto'; ?></li>
</ol>

<form id="frm-saldo" action="?c=saldos&a=Agregar" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id_prod" value="<?php echo $prod->id_prod; ?>" />

    <div class="form-group">
        <label>Cantidad</label>
        <input type="text" name="cantidad" value="<?php echo $prod->cantidad; ?>" class="form-control" placeholder="Ingrese la cantidad a agregar" data-validacion-tipo="requerido|min:10" />
    </div>

    <div class="text-right">
        <button class="btn btn-success">Agregar</button>
    </div>
</form>

<script>
    $(document).ready(function(){
        $("#frm-saldo").submit(function(){
            return $(this).validate();
        });
    })
</script>
