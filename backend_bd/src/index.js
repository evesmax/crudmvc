//codigo del servidor

const express = require ('express');
const apiRouter = require('./routes/RouterApi');
const cors = require('cors');
const app = express(); 

app.use(cors());//permite la conexion entre dos archivos 
app.use(express.json());
app.use(express.urlencoded({extended:true})); //para metodo put y post

app.use('/api',apiRouter);

app.listen(4000,()=>{
    console.log('Corriendo en puerto 4000');
});