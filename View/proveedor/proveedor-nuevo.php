<h1 class="page-header">
    Nuevo Registro
</h1>

<ol class="breadcrumb">
  <li><a href="?c=proveedor">Proveedores</a></li>
  <li class="active">Nuevo Registro</li>
</ol>

<form id="frm-proveedor" action="?c=proveedor&a=Guardar" method="post" enctype="multipart/form-data">

    <div class="form-group">
        <label>Nombre</label>
        <input type="text" name="nombreprov" value="<?php echo $pvd->nombreprov; ?>" class="form-control" placeholder="Ingrese Nombre" data-validacion-tipo="requerido|min:100" />
    </div>


    <div class="form-group">
        <label>Teléfono</label>
        <input type="number" name="num_tel" value="<?php echo $pvd->num_tel; ?>" class="form-control" placeholder="Ingrese teléfono proveedor" data-validacion-tipo="requerido|min:10" />
    </div>

    <hr />

    <div class="text-right">
        <button class="btn btn-success">Guardar</button>
    </div>
</form>

<script>
    $(document).ready(function(){
        $("#frm-proveedor").submit(function(){
            return $(this).validate();
        });
    })
</script>
