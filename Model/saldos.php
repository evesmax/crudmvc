<?php
class saldo
{
	private $pdo;

    public $id_saldo;
    public $bodega;
    public $id_prod;
    public $total_entradas;
    public $total_salidas;
    public $saldo;
	public $cantidad;

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

			$stm = $this->pdo->prepare("SELECT * FROM saldos");
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
			$stm = $this->pdo->prepare("SELECT id_saldo FROM saldos WHERE id_saldo = ?");
			$stm->execute(array($id_prod));
			return $stm->fetch(PDO::FETCH_OBJ);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}

	public function Restar($data)
	{
		try
		{
			$sql = "CALL restProd (?, ?)";

			$this->pdo->prepare($sql)
			     ->execute(
				    array(
                        $data->cantidad,
                        $data->id_saldo
					)
				);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}

	public function Sumar($data)
	{
		try
		{
			$sql = "CALL sumProd (?, ?)";

			$this->pdo->prepare($sql)
			     ->execute(
				    array(
                        $data->cantidad,
                        $data->id_saldo
					)
				);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}
}