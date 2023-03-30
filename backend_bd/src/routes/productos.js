const { request } = require("express");
const express = require("express");
const { Result } = require("express-validator");
const { ObjectId } = require("mongodb");
const mongo = require('../services/mongo');
const router = express.Router();

//get all pedidos para el administrador
router.get('/admin', async (req, res) => {
   let collection = await (await mongo).collection("pedidos");
   let pedidos = await collection.find({})
      .limit(50)
      .toArray();
      let collection_productos = await (await mongo).collection("productos");
   pedidos_con_productos = []
   for (var i = 0; i < pedidos.length; i++) {
      let producto = await collection_productos.findOne({ clave: pedidos[i].clave});
     
      producto["estatus_pedido"] = pedidos[i].estatus_pedido;
      producto["correo"] = pedidos[i].cliente;
      producto["id_pedido"] = pedidos[i]._id.toString();
      
      pedidos_con_productos.push(producto)
  }
   res.send(pedidos_con_productos);

});

//create product
router.post('/', async (req, res) => {
   let collection = await (await mongo).collection("productos");
   let results = await collection.insertOne(req.body);
   res.send(results);
});


//get all products
router.get('/', async (req, res) => {
   let collection = await (await mongo).collection("productos");
   let results = await collection.find({})
      .limit(50)
      .toArray();
   res.send(results);
});

//get pedidos usuario
router.get('/usuario/:usuario', async (req, res) => {
   const { usuario } = req.params;
   let collection = await (await mongo).collection("pedidos");
   let pedidos = await collection.find({cliente: usuario})
      .limit(50)
      .toArray();
      let collection_productos = await (await mongo).collection("productos");
   pedidos_con_productos = []

   for (var i = 0; i < pedidos.length; i++) {
      let producto = await collection_productos.findOne({ clave: pedidos[i].clave});
      producto["estatus_pedido"] = pedidos[i].estatus_pedido;
      producto["correo"] = pedidos[i].cliente;
      pedidos_con_productos.push(producto);
  }

   res.send(pedidos_con_productos);
});

//get only one product
router.get("/:clave", async (req, res) => {
   try {
      const { clave } = req.params;
      let collection = await (await mongo).collection("productos");
      let results = await collection.findOne({ clave: parseInt(clave) });
      res.send(results);
   } catch (error) {
      console.log(error)
   }

});

//get solo un pedido
router.get("/pedir/:id", async (req, res) => {
   try {
      const { id } = req.params;
      let collection = await (await mongo).collection("pedidos");
      let results = await collection.findOne({ _id: new ObjectId(id) });
      res.send(results);
   } catch (error) {
      console.log(error)
   }

});


//editar estatus de pedidos
router.put("/pedidos/:id", async (req, res) => {
   try {
      const { id } = req.params;
      const { estatus_pedido } = req.body;
      let collection = await (await mongo).collection("pedidos");
      let results = await collection.updateOne(
         { _id: new ObjectId(id) }, 
         { $set: { estatus_pedido } }
      )
      res.send(results);
   } catch (error) {
      res.send(error);
   }

});








//editar productos
router.put("/:clave", async (req, res) => {
   try {
      const { clave } = req.params;
      const { nombre, descripcion, precio, cantidad_disponible } = req.body;
      let collection = await (await mongo).collection("productos");
      let results = await collection.updateOne({ clave: parseInt(clave) }, {
         $set: { ...req.body } //desestructurado
      })
      res.send(results);
   } catch (error) {
      res.send(error);
   }

});

//Comprar producto
router.post("/compra/:clave", async (req, res) => {
   try {
      const { clave } = req.params;
      const { email_cliente } = req.body;
      
      let pedido = {
       
         estatus_pedido: "En proceso",
         clave: parseInt(clave),
         cliente: email_cliente
      }

         let collection_productos = await (await mongo).collection("productos");
         let producto = await collection_productos.findOne({ clave: parseInt(clave) });

         let result = await collection_productos.updateOne({ clave: parseInt(clave) }, {
            $set: { cantidad_disponible: producto['cantidad_disponible']-1}
         });

         let collection_pedidos = await (await mongo).collection("pedidos");
         let results = await collection_pedidos.insertOne(pedido);

         res.send(result);

      } catch (error) {
         res.send(error);
      }
});

//Delete only one product
router.delete("/:clave", async (req, res) => {
   try {
      const { clave } = req.params;
      let collection = await (await mongo).collection("productos");
      let results = await collection.deleteOne({ clave: parseInt(clave) });
      res.send(results);
   } catch (error) {
      res.send(error);
   }


});



module.exports = router;