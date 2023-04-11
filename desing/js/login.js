function log_in(correo, contraseña){
    var myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");

    var raw = JSON.stringify({
    "usuario": correo,
    "contraseña": contraseña
    });

    var requestOptions = {
    method: 'POST',
    headers: myHeaders,
    body: raw,
    redirect: 'follow'
    };

    fetch("http://ec2-54-162-46-225.compute-1.amazonaws.com:4000/api/usuarios/login", requestOptions)
     .catch(error => console.log('error', error))
    .then(response => response.text())
    .then( result => {
        if(result!='Usuario invalido'){
            console.log(result)
            sessionStorage.setItem("correo", correo);
            sessionStorage.setItem("tipo_usuario", result);
            window.location.href = "./index.html";
        }
       
    })
    
    }

function sign_in(nombre, apellido, correo, contraseña){
   

    var myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");

    var raw = JSON.stringify({
    "nombre": nombre,
    "apellido": apellido,
    "correo": correo,
    "contraseña": contraseña,
    "tipo": "cliente"
    });

    var requestOptions = {
    method: 'POST',
    headers: myHeaders,
    body: raw,
    redirect: 'follow'
    };

    fetch("http://ec2-54-162-46-225.compute-1.amazonaws.com:4000/api/usuarios", requestOptions)
    .then(async result => console.log(await result.json()))
    .catch(error => console.log('error', error));

    log_in(nombre, correo, 'cliente')
    // window.location.href = "./index.html";
}


