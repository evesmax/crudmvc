drop database if exists skypea;
create database skypea;
use skypea;

drop table if exists semestres;
create table semestres (
	id_semestre int  not null auto_increment,
    nombre_semestre varchar (50) not null,
    primary key (id_semestre)
);

drop table if exists ramas;
create table ramas (
	id_rama int  not null auto_increment,
    nombre_rama varchar (50) not null,
    primary key (id_rama)
);
insert into ramas(nombre_rama)
values
("ingenierias"),
("economico-administrativas"),
("ciencias de la salud"),
("sociales y humanidades"),
("tronco comun"),
("taller")
;
/*agregar los 9 semestres a la tabla semestres, de forma manual para  no
causar errores despues, ya que solo son 9 semestres, sea la carrera o modo que sea*/
insert into semestres(nombre_semestre)
values
("primero"),
("segundo"),
("tercero"),
("cuarto"),
("quinto"),
("sexo"),
("septimo"),
("octavo"),
("noveno");
select * from semestres;

drop table if exists cursos;
create table cursos (
	id_curso int  not null auto_increment,
    nombre_curso varchar (50) not null,
    primary key (id_curso)
);
insert into cursos (nombre_curso)values
("escolarizado"),
("en linea"),
("impulso"),
("maestria")
;
select * from cursos;
drop table if exists alumnos;
create table alumnos(
    id_alumno int (10) auto_increment not null,
    nombres varchar (40) not null ,
    apellidos varchar (50) not null,
    fecha_nac date not null,
    carrera varchar (30) not null ,
    semestre int not null,
    num_materias int (2) not null,
    tipo_curso int not null,
    colegiatura float not null,
    estado varchar (40) not null default "activo",
    primary key (id_alumno),
    foreign key (semestre) references semestres(id_semestre),
    foreign key (tipo_curso) references cursos(id_curso)
    
);

drop table if exists materias;
create table materias (
 	id_materia int (10) not null auto_increment,
    nombre_materia varchar (100) not null,
    num_creditos int (2) not null,
    rama int (30) not null,
    costo_materia int (6) not null,
    primary key (id_materia),
    foreign key (rama) references ramas(id_rama)
);
insert into materias(nombre_materia, num_creditos, rama, costo_materia)values
("matematicas discretas",40,"1",8300),
("matematicas discretas ii",40,"1",8300),
("matematicas discretas iii",40,"1",8300),
("seminario de ejercicios de programacion",25,"1",5300),
("lengua extranjera i",20,"5",3000),
("lengua extranjera ii",20,"5",3000),
("lengua extranjera iii",20,"5",3000),
("lengua extranjera iv",20,"5",3000),
("lengua extranjera v",20,"5",3000),
("validacion de metodos",30,"1",8300),
("histologia",40,"3",3000),
("introduccion a la anatomia humana",40,"3",6000),
("mercados financieros",40,"2",6000),
("estadistica en la economia",30,"2",7600)
;
select * from materias;
drop table if exists profesores;
create table profesores(
    id_profesor int (10) auto_increment not null,
    nombre varchar (40) not null ,
    segundo_nombre varchar (40),
    fecha_nac date not null,
    area varchar (30) not null ,
    primary key (id_profesor)
);

drop table if exists asignacion_carga;
create table asignacion_carga(
    id_alumno int not null,
    id_materia int not null,
    foreign key (id_alumno) references alumnos(id_alumno),
    foreign key (id_materia)references materias(id_materia)
);

drop table if exists cuentas_por_cobrar;
create table cuentas_por_cobrar(
	id_alumno int (10 )not null,
    semestre int not null,
    total_pago numeric not null,
    foreign key (id_alumno) references alumnos(id_alumno),
    foreign key (semestre) references semestres (id_semestre)
);

/*---------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------creacion de triggers y procedures---------------------*/
delimiter $$
drop procedure if exists agregaralumno$$
create procedure agregaralumno (in pnombres  varchar (40), in papellidos varchar (50), in pfecha_nac date, in pcarrera varchar (30), in psemestre varchar (40),in ptipo_curso varchar (30))
begin 
insert into alumnos (nombres, apellidos, fecha_nac, carrera, semestre,  tipo_curso)
values (pnombres, papellidos, pfecha_nac, pcarrera, psemestre, ptipo_curso);
end $$	
delimiter ;

delimiter $$
drop procedure if exists listaralumnos$$
create procedure listaralumnos ()
begin 
select * from alumnos ; 
end $$	
delimiter ;

delimiter $$
drop procedure if exists eliminaralumno$$
create procedure eliminaralumno (in pid_alumno int (10))
begin 
delete from alumnos where `alumnos`.`id_alumno` = pid_alumno;
end $$	
delimiter ;

delimiter $$
drop procedure if exists agregarmateria$$
create procedure agregarmateria (in pnombre_materia varchar (60), in pnum_creditos int,in prama varchar (50), in pcosto_materia int)
begin 
insert into materias (nombre_materia, num_creditos, rama, costo_materia)
values (pnombre_materia, pnum_creditos, prama, pcosto_materia);
end $$	
delimiter ; 

delimiter $$
drop procedure if exists listarmaterias$$
create procedure listarmaterias ()
begin 
select * from materias ; 
end $$	
delimiter ;

delimiter $$
drop procedure if exists eliminarmateria$$
create procedure eliminarmateria (in pid_materia int (10))
begin 
delete from materias where `materias`.`id_materia` = pid_materia;
end $$	
delimiter ;
