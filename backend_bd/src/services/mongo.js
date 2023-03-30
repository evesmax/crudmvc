//conexion a API de MONGODB ATLAS

const { MongoClient } = require("mongodb");

const connectionString = "mongodb+srv://mercyrodt:Diego2022@cluster0.v90xa43.mongodb.net/tiendadb?retryWrites=true&w=majority";
const client = new MongoClient(connectionString);


let conn;

async function handleConnection() {
    try {
        conn = await client.connect();
        console.log("Corriendo mongo")
    } catch (e) {
        console.error(e);
    }

    return conn.db("tiendadb");
}

const db= handleConnection();
module.exports = db;