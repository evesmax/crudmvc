<h1 class="page-header">Productos </h1>

<div class="well well-sm text-right">
    <a class="btn btn-primary" href="?c=proveedor&a=Nuevo">Nuevo Proveedor</a>
    <a class="btn btn-primary" href="?c=producto&a=Nuevo">Nuevo Producto</a>
    <a class="btn btn-primary" href="?c=movimientos">Ver Movimientos</a>
    <a class="btn btn-primary" href="?c=saldos">Ver Saldos</a>
</div>

<table class="table table-striped">
    <thead>
        <tr>
            <th style="width:180px;">Código Producto</th>
            <th style="width:120px;">NIT Proveedor</th>
            <th style="width:120px;">Nombre Producto</th>
            <th style="width:120px;">Precio Unitario</th>
            <th style="width:120px;">Descripción</th>
        </tr>
    </thead>
    <tbody>
    <?php foreach($this->model->Listar() as $r): ?>
        <tr>
            <td><?php echo $r->id_prod; ?></td>
            <td><?php echo $r->id_prov; ?></td>
            <td><?php echo $r->nombreprod; ?></td>
            <td><?php echo $r->costo; ?></td>
            <td>
                <a href="?c=producto&a=Crud&id_prod=<?php echo $r->id_prod; ?>">Editar</a>
            </td>
            <td>
                <a onclick="javascript:return confirm('¿Seguro de eliminar este registro?');" href="?c=producto&a=Eliminar&id_prod=<?php echo $r->id_prod; ?>">Eliminar</a>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
