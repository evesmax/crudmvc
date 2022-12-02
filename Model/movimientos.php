<?php
class movimiento
{
	private $pdo;

    public $id_mov;
    public $bodega;
    public $cantidad;
    public $fecha;
    public $id_prod;
    public $tipo;
    
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

			$stm = $this->pdo->prepare("SELECT * FROM movimientos");
			$stm->execute();

			return $stm->fetchAll(PDO::FETCH_OBJ);
		}
		catch(Exception $e)
		{
			die($e->getMessage());
		}
	}

	public function Obtener($id_mov)
	{
		try
		{
			$stm = $this->pdo->prepare("SELECT * FROM movimientos WHERE id_mov = ?");
			$stm->execute(array($id_mov));
			return $stm->fetch(PDO::FETCH_OBJ);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}
}
