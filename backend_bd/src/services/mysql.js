//conexion a API  de MySQL
const MySQL=require('mysql2/promise');

const dbOptions={
    host: '34.222.130.2',
    user:'univar',
    password:'Univar98.',
    database:'db0122210826'
}

async function  handleConnection(){
    console.log("conectando a Mysql")
    try{

        let globalPool = MySQL.createPool(dbOptions);
    
        await globalPool.getConnection( (err, connection) => {
    
          if(err){
            switch (err) {
              case "PROTOCOL_CONNECTION_LOST":
                console.error('Database connection was closed.')
                break;
    
              case "ER_CON_COUNT_ERROR":
                console.error('Database has too many connections.')
                break;
    
              case "ECONNREFUSED":
                console.error('Database connection was refused.')
                break;
    
              default:
                console.log("Database connection error: ", err);
                break;
            }
    
            globalPool.end();
    
            globalPool = MySQL.createPool(config);
    
          }else{
            connection.release();
          }
        });
    
        return globalPool;
    
      }catch(error){
        console.log(error);
      // return handleConnection();
      
      }
}

const connection=handleConnection();
module.exports=connection;