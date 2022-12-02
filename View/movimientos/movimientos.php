<h1 class="page-header">Movimientos</h1>

<div class="well well-sm text-right">
    <a class="btn btn-primary" href="?c=proveedor&a=Nuevo">Nuevo Proveedor</a>
    <a class="btn btn-primary" href="?c=producto&a=Nuevo">Nuevo Producto</a>
    <a class="btn btn-primary" href="?c=movimientos">Ver Movimientos</a>
    <a class="btn btn-primary" href="?c=saldos">Ver Saldos</a>
</div>

<table class="table table-striped">
    <thead>
        <tr>
            <th style="width:180px;">ID Mov</th>
            <th style="width:120px;">Num Bodega</th>
            <th style="width:120px;">Cantidad</th>
            <th style="width:120px;">Fecha</th>
            <th style="width:120px;">Código Producto</th>
            <th style="width:120px;">Tipo</th>
        </tr>
    </thead>
    <tbody>
    <?php foreach($this->model->Listar() as $r): ?>
        <tr>
            <td><?php echo $r->id_mov; ?></td>
            <td><?php echo $r->bodega; ?></td>
            <td><?php echo $r->cantidad; ?></td>
            <td><?php echo $r->fecha; ?></td>
            <td><?php echo $r->id_prod; ?></td>
            <td><?php echo $r->tipo; ?></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
