<?php
class proveedor
{
	//Atributo para conexión a SGBD
	private $pdo;

		//Atributos del objeto proveedor
    public $id_prov;
    public $nombreprov;
    public $num_tel;

	//Método de conexión a SGBD.
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

	//Este método selecciona todas las tuplas de la tabla
	//proveedor en caso de error se muestra por pantalla.
	public function Listar()
	{
		try
		{
			$result = array();
			//Sentencia SQL para selección de datos.
			$stm = $this->pdo->prepare("SELECT * FROM proveedor");
			//Ejecución de la sentencia SQL.
			$stm->execute();
			//fetchAll — Devuelve un array que contiene todas las filas del conjunto
			//de resultados
			return $stm->fetchAll(PDO::FETCH_OBJ);
		}
		catch(Exception $e)
		{
			//Obtener mensaje de error.
			die($e->getMessage());
		}
	}

	//Este método obtiene los datos del proveedor a partir del id_prov
	//utilizando SQL.
	public function Obtener($id_prov)
	{
		try
		{
			//Sentencia SQL para selección de datos utilizando
			//la clausula Where para especificar el id_prov del proveedor.
			$stm = $this->pdo->prepare("SELECT * FROM proveedor WHERE id_prov = ?");
			//Ejecución de la sentencia SQL utilizando el parámetro id_prov.
			$stm->execute(array($id_prov));
			return $stm->fetch(PDO::FETCH_OBJ);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}

	//Este método elimina la tupla proveedor dado un id_prov.
	public function Eliminar($id_prov)
	{
		try
		{
			//Sentencia SQL para eliminar una tupla utilizando
			//la clausula Where.
			$stm = $this->pdo
			            ->prepare("DELETE FROM proveedor WHERE id_prov = ?");

			$stm->execute(array($id_prov));
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}

	//Método que actualiza una tupla a partir de la clausula
	//Where y el id_prov del proveedor.
	public function Actualizar($data)
	{
		try
		{
			//Sentencia SQL para actualizar los datos.
			$sql = "UPDATE proveedor SET
						nombreprov          = ?,
            num_tel        = ?
				    WHERE id_prov = ?";
			//Ejecución de la sentencia a partir de un arreglo.
			$this->pdo->prepare($sql)
			     ->execute(
				    array(
                        $data->nombreprov,
                        $data->num_tel,
                        $data->id_prov
					)
				);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}

	public function Registrar(proveedor $data)
	{
		try
		{
			//Sentencia SQL.
			$sql = "INSERT INTO proveedor (id_prov,nombreprov,num_tel)
		        VALUES (?, ?, ?)";

			$this->pdo->prepare($sql)
		     ->execute(
				array(
                    $data->id_prov,
                    $data->nombreprov,
                    $data->num_tel,
                )
			);
		} catch (Exception $e)
		{
			die($e->getMessage());
		}
	}
}
