const express = require('express')
const router = express.Router()
const connection = require("../services/mysql");

//get usuario
router.get('/', async (req, res) => {

    try {
        const db = (await connection);
        const [usuarios] = await db.execute('SELECT * FROM usuarios');
        res.send(usuarios);
    } catch (error) {
        console.log(error);
    }

})

//get un solo usuario
router.get('/:usuario', async (req, res) => {
    try {
        const db = (await connection);
        
        const [usuarios] = await db.execute('SELECT * FROM usuarios WHERE correo=?', [req.params.usuario]);
        res.send(usuarios);
    } catch (error) {
        console.log(error);
        res.send(error);
    }

})

//login usuarios
router.post('/login', async (req, res) => {
    try {
        const {usuario, contraseña} = req.body
        
        const db = (await connection);
        const [usuarios] = await db.execute('SELECT * FROM usuarios WHERE correo=? and contraseña=?', [usuario,contraseña]);

        if (usuarios.length == 0){
            res.status(503).send('Usuario invalido')
        }else{
            res.send(usuarios[0].tipo);
        }

       
    } catch (error) {
        console.log(error);
        res.send(error);
    }

})

//insert usuarios
router.post('/', async (req, res) => {
    try {
        const {nombre, apellido, correo, contraseña, tipo}=req.body;
        const db = (await connection);
        const result = await db.execute('INSERT INTO usuarios set nombre=?, apellido=?,correo=?,contraseña=?, tipo=?' ,[nombre,apellido,correo,contraseña, tipo]);
        res.send(result);
    } catch (error) {
        console.log(error);
        res.send(error);
    }
})

//delete usuarios
router.delete('/:id', async(req, res) => {
    try {
        const db = (await connection);
        const result = await db.execute('DELETE FROM usuarios WHERE id_usuario = ?', [req.params.id]);
        res.send(result);
    } catch (error) {
        console.log(error);
        res.send(error);
    }
})


//update id usuarios  
router.put('/:id', async(req, res) => {

    try {
        const {nombre, apellido, correo, contraseña}=req.body;
        const db = (await connection);
        const result = await db.execute('UPDATE usuarios set nombre=?, apellido=?,correo=?,contraseña=? WHERE id_usuario= ?', [nombre,apellido,correo,contraseña,req.params.id]);
        res.send(result);
    } catch (error) {
        console.log(error);
        res.send(error);
    }
})

module.exports = router
