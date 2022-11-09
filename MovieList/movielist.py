from flask import Flask
from flask import render_template,request, redirect, url_for
from flaskext.mysql import MySQL
from flask import send_from_directory
from datetime import datetime
import os

app= Flask(__name__)

mysql = MySQL()
app.config['MYSQL_DATABASE_HOST']='localhost'
app.config['MYSQL_DATABASE_USER']='root'
app.config['MYSQL_DATABASE_PASSWORD']=''
app.config['MYSQL_DATABASE_DB']='movielist'
mysql.init_app(app)

CARPETA = os.path.join('uploads')
app.config['CARPETA'] = CARPETA

@app.route('/uploads/<nombreImagen>')
def uploads(nombreImagen):
    return send_from_directory(app.config["CARPETA"], nombreImagen)

@app.route('/')
def index():

    sql = "SELECT * FROM `bdprincipal`"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(sql)

    peliculas= cursor.fetchall()
    print(peliculas)

    conn.commit()
    return render_template('peliculas/index.html', peliculas=peliculas)

@app.route('/destroy/<int:id>')
def destroy(id):
    conn = mysql.connect()
    cursor = conn.cursor()
    
    cursor.execute("SELECT imagen FROM bdprincipal WHERE Idpeli=%s", id)
    fila=cursor.fetchall()
    os.remove(os.path.join(app.config['CARPETA'], fila[0][0]))

    cursor.execute("DELETE FROM `bdprincipal` WHERE `idpeli` = %s", (id))
    conn.commit()
    return redirect('/')

@app.route('/edit/<int:id>')
def edit(id):

    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM `bdprincipal` WHERE idPeli=%s", (id))
    peliculas= cursor.fetchall()
    conn.commit()

    return render_template('peliculas/edit.html', peliculas=peliculas)

@app.route('/update', methods = ['POST'])
def update():
    
    _nombre = request.form['txtNombre']
    _genero = request.form['txtGenero']
    _director = request.form['txtDirector']
    _año = request.form['txtAño']
    _imagen = request.files['txtImagen']
    id= request.form['txtID']

    sql = '''UPDATE `BDPrincipal` SET `Nombre`=%s, `Genero`=%s, `Director`=%s, `Año`=%s WHERE  idPeli=%s'''

    datos=(_nombre,_genero,_director,_año,id)

    conn = mysql.connect()
    cursor = conn.cursor()

    now= datetime.now()
    tiempo = now.strftime("%Y%H%M%S")

    if _imagen.filename != '':
        nuevoNombreImagen =tiempo+_imagen.filename
        _imagen.save("uploads/"+nuevoNombreImagen)

        cursor.execute("SELECT imagen FROM bdprincipal WHERE Idpeli=%s", id)
        fila=cursor.fetchall()

        os.remove(os.path.join(app.config['CARPETA'], fila[0][0]))
        cursor.execute("UPDATE `bdprincipal` SET imagen=%s WHERE Idpeli=%s", (nuevoNombreImagen, id))
        conn.commit()

    cursor.execute(sql,datos)
    conn.commit()

    return redirect('/')

@app.route('/create')
def create():
    return render_template('peliculas/create.html')

@app.route('/store', methods=['POST'])
def storage():
    _nombre = request.form['txtNombre']
    _genero = request.form['txtGenero']
    _director = request.form['txtDirector']
    _año = request.form['txtAño']
    _imagen = request.files['txtImagen']

    now= datetime.now()
    tiempo = now.strftime("%Y%H%M%S")

    if _imagen.filename != '':
        nuevoNombreImagen =tiempo+_imagen.filename
        _imagen.save("uploads/"+nuevoNombreImagen)

    sql = '''INSERT INTO `BDPrincipal` (Nombre, Genero, Director, Año, imagen) VALUES (%s, %s, %s, %s,%s)'''

    datos=(_nombre,_genero,_director,_año,nuevoNombreImagen)

    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(sql,datos)
    conn.commit()
    return redirect('/')


if __name__ == '__main__':
    app.run(debug=True)