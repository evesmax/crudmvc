<h1 class="page-header">Proveedores</h1>

<div class="well well-sm text-right">
    <a class="btn btn-primary" href="?c=proveedor&a=Nuevo">Nuevo Proveedor</a>
    <a class="btn btn-primary" href="?c=producto&a=Nuevo">Nuevo Producto</a>
    <a class="btn btn-primary" href="?c=movimientos">Ver Movimientos</a>
    <a class="btn btn-primary" href="?c=saldos">Ver Saldos</a>
</div>

<table class="table table-striped">
    <thead>
        <tr>
            <th style="width:180px;">ID Proveedor</th>
            <th style="width:120px;">Nombre</th>
            <th style="width:120px;">Teléfono</th>
        </tr>
    </thead>
    <tbody>
    <?php foreach($this->model->Listar() as $r): ?>
        <tr>
            <td><?php echo $r->id_prov; ?></td>
            <td><?php echo $r->nombreprov; ?></td>
            <td><?php echo $r->num_tel; ?></td>
            <td>
                <a href="?c=proveedor&a=Crud&id_prov=<?php echo $r->id_prov; ?>">Editar</a>
            </td>
            <td>
                <a onclick="javascript:return confirm('¿Seguro de eliminar este registro?');" href="?c=proveedor&a=Eliminar&id_prov=<?php echo $r->id_prov; ?>">Eliminar</a>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
