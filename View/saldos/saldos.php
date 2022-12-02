<h1 class="page-header">Saldos</h1>

<div class="well well-sm text-right">
    <a class="btn btn-primary" href="?c=proveedor&a=Nuevo">Nuevo Proveedor</a>
    <a class="btn btn-primary" href="?c=producto&a=Nuevo">Nuevo Producto</a>
    <a class="btn btn-primary" href="?c=movimientos">Ver Movimientos</a>
    <a class="btn btn-primary" href="?c=saldos">Ver Saldos</a>
</div>

<table class="table table-striped">
    <thead>
        <tr>
            <th style="width:120px;">Bodega</th>
            <th style="width:120px;">Codigo Producto</th>
            <th style="width:120px;">Entradas</th>
            <th style="width:120px;">Salidas</th>
            <th style="width:120px;">Saldo</th>
            <th style="width:120px;">Opciones</th>
        </tr>
    </thead>
    <tbody>
    <?php foreach($this->model->Listar() as $r): ?>
        <tr>
            <td><?php echo $r->bodega; ?></td>
            <td><?php echo $r->id_prod; ?></td>
            <td><?php echo $r->total_entradas; ?></td>
            <td><?php echo $r->total_salidas; ?></td>
            <td><?php echo $r->saldo; ?></td>

            <td>
                <a href="?c=saldos&a=Mas&id_prod=<?php echo $r->id_prod; ?>">Agregar</a>
            </td>
            <td>
                <a href="?c=saldos&a=Menos&id_prod=<?php echo $r->id_prod; ?>">Quitar</a>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>