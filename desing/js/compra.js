async function  hacer_compra (id_producto, ) {
    const correo = sessionStorage.getItem("correo");
    await fetch("http://ec2-54-162-46-225.compute-1.amazonaws.com:4000/api/productos/compra/"+ id_producto, {
        method: "POST",
        body: JSON.stringify({
          "email_cliente": correo
        }),
        headers: {
          "Content-type": "application/json; charset=UTF-8"
        }
      });
      window.location.href = "./comprados.html";
}