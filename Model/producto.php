<?php

$producto;
class producto 
{
	private $pdo;
    public $id_prod;
    public $id_prov;
    public $nombreprod;
    public $costo;
	public $cantidad;
	public $bodega;
	public function __CONSTRUCT()
	{
		try
		{
			$this->pdo = Database::Conectar();
		}
		catch(Exception $e)
		{
			die($e->getMessage());
		}
	}

	public function Listar()
	{
		try
		{
			$result = array();

			$stm = $this->pdo->prepare("SELECT * FROM producto");
			$stm->execute();

			return $stm->fetchAll(PDO::FETCH_OBJ);
		}
		catch(Exception $e)
		{
			die($e->getMessage());
		}
	}

	public function Obtener($id_prod)
	{
		try
		{
			$stm = $this->pdo->prepare("SELECT * FROM producto WHERE id_prod = ?");
			$stm->execute(array($id_prod));
			return $stm->fetch(PDO::FETCH_OBJ);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}

	public function Eliminar($id_prod)
	{
		try
		{
			$stm = $this->pdo->prepare("DELETE FROM producto WHERE id_prod = ?");
			$stm->execute(array($id_prod));
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}

	public function Actualizar($data)
	{
		try
		{
			//Sentencia SQL para actualizar los datos.
			$sql = "UPDATE producto SET
						nombreprod          = ?,
            			costo        = ?
				    WHERE id_prod = ?";
			//Ejecución de la sentencia a partir de un arreglo.
			$this->pdo->prepare($sql)
			     ->execute(
				    array(
                        $data->nombreprod,
                        $data->costo,
                        $data->id_prod
					)
				);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}

	public function Registrar(producto $data){
		try{
			$sql = "CALL altaProducto (?,?,?,?,?)";
			$this->pdo->prepare($sql)->execute(
				array(
					$data->nombreprod,
					$data->id_prov,
					$data->bodega,
					$data->cantidad,
					$data->costo
				)
			);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}
}
