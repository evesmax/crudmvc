<h1 class="page-header">
    <?php echo $prod->id_saldo != null ? $prod->bodega : 'Nuevo Registro'; ?>
</h1>

<ol class="breadcrumb">
  <li><a href="?c=saldos">Saldos</a></li>
  <li class="active"><?php echo $prod->id_saldo!= null ? $prod->bodega : 'Agregar Producto'; ?></li>
</ol>

<form id="frm-saldo" action="?c=saldos&a=Quitar" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id_prod" value="<?php echo $prod->id_prod; ?>" />

    <div class="form-group">
        <label>Cantidad</label>
        <input type="text" name="cantidad" value="<?php echo $prod->cantidad; ?>" class="form-control" placeholder="Ingrese la cantidad a quitar" data-validacion-tipo="requerido|min:10" />
    </div>

    <div class="text-right">
        <button class="btn btn-success">Quitar</button>
    </div>
</form>

<script>
    $(document).ready(function(){
        $("#frm-saldo").submit(function(){
            return $(this).validate();
        });
    })
</script>