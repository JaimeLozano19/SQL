
-- punto 1--
-- creamos la base de datos--

create database if not exists JAIMELO character set = "utf32" collate = "utf32_bin";

-- punto 2--
-- creamos la tabla de usuario --
USE JAIMELO;
create table if not exists USUARIO(
	Id_Usuario int auto_increment,
	Nombre_Usuario varchar(20) not null,
    Clave_Usuario varchar(20) not null,
    Mail_Usuario varchar(70) not null,
    Tel_Usuario varchar(12) not null,
    constraint cons_PK_Cliente primary key (Id_Usuario)
);

-- creamos la tabla rol--
create table if not exists Rol(
	Id_Rol int auto_increment,
	Nombre_Rol varchar(20) not null,
    Ruta_defecto varchar(70) not null,
    Descripcion varchar(70) not null,
    
    constraint cons_PK_Cliente primary key (Id_Rol)
);

-- creamos la tabla usuarioRol--
create table if not exists UsuarioRol(
	Id_Usuario int not null,
	Id_Rol int not null,
 
	foreign key (Id_Usuario) references Usuario (Id_Usuario),
    foreign key (Id_Rol) references Rol (Id_Rol)
);

-- punto 3--
-- creamos la tabla de auditoria de rol--

create table if not exists Aud_Rol(
	Id_Rol int,
    Nombre_Rol varchar(20),
    Ruta_defecto varchar(70),
    descripcion varchar(70),
    evento varchar(15),
    fecha_evento datetime
);
-- creamos el trigger--
create trigger Tr_Update_Rol before update on Rol
FOR each row
insert into aud_rol
values (old.Id_rol, old.Nombre_rol , old.Ruta_defecto, old.descripcion,'actualización' ,NOW());





-- punto 4--
-- creamos la tabla UsuariosGmail--
create table if not exists UsuariosGmail(
	Id_Usuario int auto_increment,
	Nombre_Usuario varchar(20) not null,
    Clave_Usuario varchar(20) not null,
    Mail_Usuario varchar(70) not null,
    Tel_Usuario varchar(12) not null,
    constraint cons_PK_Cliente primary key (Id_Usuario)
);

-- Creamos el procedimiento almacenado--
DELIMITER $$
CREATE PROCEDURE Realizar_Copia_Usuario ()
    BEGIN 
    TRUNCATE  TABLE UsuariosGmail;
    INSERT INTO UsuariosGmail SELECT * FROM Usuario u where u.Mail_usuario like '%@gmail.com' ;
END$$

-- revisamos la tabla usuariosGmail--
select * from usuariosgmail;
-- llamamos el procedimiento --
call Realizar_Copia_usuario();


-- punto 5--
-- insertamos valores en la tabla usuario--
insert into usuario (nombre_usuario, clave_usuario, mail_usuario, tel_usuario)
values('Jaime lozano','garciaLibre19','jolozanog@ut.edu.co','3123182473');
insert into usuario (nombre_usuario, clave_usuario, mail_usuario, tel_usuario)
values('Pedro perez','pedro12','pedro12@gmail.com','3113182473');
insert into usuario (nombre_usuario, clave_usuario, mail_usuario, tel_usuario)
values('Carlos rojas','carroj','carroj@gmail.com','3133182473');
insert into usuario (nombre_usuario, clave_usuario, mail_usuario, tel_usuario)
values('Alberto perez','alpe12','alberperez@ut.edu.co','3003182473');
insert into usuario (nombre_usuario, clave_usuario, mail_usuario, tel_usuario)
values('Camilo rojas','caro19','camiloroja@hotmail.com','3153182473');
insert into usuario (nombre_usuario, clave_usuario, mail_usuario, tel_usuario)
values('cristian rojas','criro19','criroja@gmail.com','3173182473');
insert into usuario (nombre_usuario, clave_usuario, mail_usuario, tel_usuario)
values('pedro aguacate','peragua','peagua@hotmail.com','3007672812');

-- insertamos valores en la tabla rol --
insert into rol (nombre_rol, ruta_defecto, descripcion)
values('Estudiante','/Colegio/curso/estudiante','Persona que cursa estudios en un centro docente');
insert into rol (nombre_rol, ruta_defecto, descripcion)
values('Profesor','/colegio/empleados/profesor','Se dedica profesionalmente a la enseñanza');
insert into rol (nombre_rol, ruta_defecto, descripcion)
values('Rector','/colegio/empleados/rector','Aquel o aquello que rige o gobierna');
insert into rol (nombre_rol, ruta_defecto, descripcion)
values('Administrador','/colegio/empleados/administrador','Se ocupa de realizar la tarea administrativa');
insert into rol (nombre_rol, ruta_defecto, descripcion)
values('Administrador','/colegio/empleados/administrador','Se ocupa de realizar la tarea administrativa');
insert into rol (nombre_rol, ruta_defecto, descripcion)
values('Administrador','/colegio/empleados/administrador','Se ocupa de realizar la tarea administrativa');

select * from usuario;
select * from rol;
-- insertamos valores en la tabla usuariorol--
insert into usuariorol ( Id_Usuario, Id_rol)
values ('1', '1');
insert into usuariorol ( Id_Usuario, Id_rol)
values ('2', '2');
insert into usuariorol ( Id_Usuario, Id_rol)
values ('3', '3');
insert into usuariorol ( Id_Usuario, Id_rol)
values ('4', '4');
insert into usuariorol ( Id_Usuario, Id_rol)
values ('5', '5');
insert into usuariorol ( Id_Usuario, Id_rol)
values ('6', '6');

select * from usuariorol;

-- creamos la consulta--
select u.nombre_usuario, u.mail_usuario, r.nombre_rol, r.descripcion
from usuario u, rol r
where u.id_usuario=r.id_rol;

-- punto 6--
-- creamos la consulta--
select u.nombre_usuario, u.tel_usuario, count(ur.id_rol)
from usuario u, rol r, usuariorol ur
where u.id_usuario = ur.id_usuario
and ur.id_rol = r.id_rol
group by u.nombre_usuario, u.tel_usuario
having count(ur.id_rol)>1;



-- punto 7--
-- creamos la consulta--
SELECT u.nombre_usuario, r.nombre_rol, u.mail_usuario,
      CASE
          WHEN  u.Mail_usuario like '%@ut.edu.co'
          THEN 'Correo institucional'
          WHEN u.Mail_usuario not like '%@ut.edu.co'
          THEN 'Correo personal'
		
	  END AS 'Tipo de correo'
FROM usuario u, rol r
where u.id_usuario=r.id_rol;

