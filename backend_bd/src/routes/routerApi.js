const router = require('express').Router();

const apiUsuarios = require('./usuarios');
const apiProductos = require('./productos');

router.use('/usuarios', apiUsuarios);
router.use('/productos', apiProductos);


module.exports= router;