-- ########### CONSULTAS PARA BITACORA DE MANUEL CANUL ###########

-- 1- Sql de creación de tabla principal (a la cual se realizará la bitáora).
CREATE TABLE depositos (
  id_deposito int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fecha_deposito date NOT NULL,
  hora_deposito time NOT NULL,
  cantidad_deposito decimal(7,2) NOT NULL,
  motivo_deposito varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  id_caja int(11) NOT NULL,
  id_usuario int(11) NOT NULL
)engine=innodb;

-- 2- Sql de creación tabla para bitácora
create table bitacora (
    id_bitacora int (30) auto_increment primary key,
    nombre_tabla varchar(40),
    id_vinculado int (11),
    nuevo_dato VARCHAR(100), 
    viejo_dato VARCHAR(100),
    usuario varchar (30), 
    fecha datetime, 
    accion varchar (15)
)engine=innodb;

-- 3- Sql de triger para la creación de la bitácora al insertar.
CREATE TRIGGER insertar_tbldepositos AFTER INSERT
ON depositos
for each row
INSERT INTO bitacora (nombre_tabla,
                      id_vinculado, 
                      nuevo_dato, 
                      viejo_dato, 
                      usuario, 
                      fecha, 
                      accion) 
                      VALUES ('depositos',
                      new.id_deposito, 
                      new.cantidad_deposito, 
                      old.cantidad_deposito, 
                      user(), 
                      now(), 
                      'Inserto');

-- 4- Sql de triger para la creación de la bitácora al actualizar.
CREATE TRIGGER actualizar_tbldepositos AFTER UPDATE
ON depositos
for each row
INSERT INTO bitacora (nombre_tabla,id_vinculado, nuevo_dato, viejo_dato, usuario, fecha, accion) 
            VALUES ('depositos',old.id_deposito, new.cantidad_deposito, old.cantidad_deposito, user(), now(), 'Actualizo');

-- 5- Sql de triger para la creación de la bitácora al eliminar.
CREATE TRIGGER eliminar_tbldepositos AFTER DELETE
ON depositos
for each row
INSERT INTO bitacora (nombre_tabla,id_vinculado, nuevo_dato, viejo_dato, usuario, fecha, accion) 
            VALUES ('depositos',old.id_deposito, old.cantidad_deposito, old.cantidad_deposito, user(), now(), 'Elimino');

-- 6.- Documento de evidencia del correcto funcionamiento de su bitácora