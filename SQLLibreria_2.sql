CREATE DATABASE LIBRERIA_2
GO

USE LIBRERIA_2
GO

--Crear tablas

CREATE TABLE barrios (
	cod_barrio int NOT NULL ,
	barrio nvarchar (50) NULL ,
	CONSTRAINT PK_barrios PRIMARY KEY (cod_barrio)
)

CREATE TABLE articulos (
	cod_articulo int IDENTITY (1, 1) NOT NULL ,
	descripcion nvarchar (50) NULL ,
	stock_minimo smallint NULL ,
	stock smallint NOT NULL,
	pre_unitario decimal(10, 2) NOT NULL ,
	observaciones nvarchar (50)NULL ,
	CONSTRAINT PK_articulos PRIMARY KEY (cod_articulo)
)

CREATE TABLE clientes (
	cod_cliente int IDENTITY (1, 1) NOT NULL ,
	nom_cliente nvarchar (50) NOT NULL ,
	ape_cliente nvarchar (50) NOT NULL ,
	calle nvarchar (50) NOT NULL ,
	altura int,
	cod_barrio int NOT NULL,
	nro_tel bigint NULL ,
	[e-mail] nvarchar (50) NULL,
	CONSTRAINT PK_clientes PRIMARY KEY (cod_cliente),
	CONSTRAINT FK_clientes_barrios FOREIGN KEY (cod_barrio) REFERENCES barrios (cod_barrio)
)

CREATE TABLE vendedores (
	cod_vendedor int IDENTITY (1, 1) NOT NULL ,
	nom_vendedor nvarchar (50) NOT NULL ,
	ape_vendedor nvarchar(50) not null,
	calle nvarchar (50) NOT NULL ,
	altura int,
	cod_barrio int NOT NULL,
	nro_tel bigint NULL ,
	[e-mail] nvarchar (50) NULL ,
	fec_nac smalldatetime NULL ,
	CONSTRAINT PK_vendedores PRIMARY KEY (cod_vendedor),
	CONSTRAINT FK_vendedores_barrios FOREIGN KEY (cod_barrio) REFERENCES barrios (cod_barrio)
)
CREATE TABLE facturas (
	nro_factura int IDENTITY (1, 1) NOT NULL ,
	fecha datetime NOT NULL ,
	cod_cliente int NOT NULL ,
	cod_vendedor int NOT NULL ,
	CONSTRAINT PK_facturas PRIMARY KEY (nro_factura),
	CONSTRAINT FK_facturas_clientes FOREIGN KEY (cod_cliente) REFERENCES clientes (cod_cliente),
	CONSTRAINT FK_facturas_vendedores FOREIGN KEY (cod_vendedor) REFERENCES vendedores (cod_vendedor)
)

CREATE TABLE detalle_facturas (
	nro_factura int NOT NULL ,
	cod_articulo int NOT NULL ,
	pre_unitario numeric(18, 2) NOT NULL ,
	cantidad smallint NOT NULL ,
	CONSTRAINT PK_detalle PRIMARY KEY  (nro_factura, cod_articulo),
	CONSTRAINT FK_detalle_articulos FOREIGN KEY (cod_articulo) REFERENCES articulos (cod_articulo),
	CONSTRAINT FK_detalle_facturas FOREIGN KEY (nro_factura) REFERENCES facturas (nro_factura)
)

CREATE TABLE historial_precios (
	id int IDENTITY (1,1) NOT NULL ,
	cod_articulo int NOT NULL ,
	precio numeric(18, 2),
	fecha_desde datetime,
	fecha_hasta datetime,
	CONSTRAINT PK_historial PRIMARY KEY (id)
)

CREATE TABLE auditorias (
	id int IDENTITY (1,1) NOT NULL ,
	tabla varchar(20),
	fecha datetime,
	detalle varchar(200),
	cod_entidad int,
	movimiento varchar(20) 
	CONSTRAINT PK_auditorias PRIMARY KEY (id)
)

--cambiar el formato de la fecha a d�a,mes y a�o (DMY: day, month, year)
SET DATEFORMAT DMY

-- Insertar registros a las tablas

--BARRIOS
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (1,'CENTRO') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (2,'ALTO ALBERDI') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (3,'OBSERVATORIO') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (4,'JARD�N') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (5,'GENERAL PAZ') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (6,'PUEYRRED�N') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (7,'PARQUE HORIZONTE') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (8,'SAN MART�N') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (9,'SAN VICENTE') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (10,'NUEVA C�RDOBA') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (11,'MAIP�') 
INSERT INTO BARRIOS(cod_barrio, BARRIO) VALUES (12,'PANAMERICANO') 

--ARTICULOS
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('L�piz Evolution HB2 * 4 u',null,150, 160.00, null);--1
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Papel p/forrar Fantas�a * 10 u',100,100,500.00, null);--2
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Papel p/forrar Ara�a * 10 u',20,155,600.00, 'Color rojo - azul - verde');
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('L�pices Color cortos  * 12 u',50,100, 120.50, null);--4
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Fibras cortas * 6',50,50,125.30,null);--5
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('L�pices Color largos * 12 u',null,0,130,null);--6
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Separadores tama�o rivadavia * 6 u',null,100, 85.70,'Motivos de Disney');
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Carpeta fibra negra - Tama�o rivadavia',null,54, 202.90,'3 anillos');--8
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Carpeta Fantas�a - Tama�o Rivadavia',60,100, 250.90,'3 anillos');
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Adhesivo sint�tico 30 gr',NULL,20,56.00, null);--10

insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Cuaderno Tama�o rivadavia rayado',150,180,52.70,null);
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Cuaderno Tama�o rivadavia cuadriculado',50,65,52.70,null);--12
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Repuesto Gloria rallado',150,120, 641.00,'400 hojas');
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Repuesto Gloria cuadriculado',20,90, 641.00,'400 hojas');--14
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Conjunto Geom�trico',null,20,185.90,'Regla - escuadra - transportador');
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Cartuchera Lata',5,60, 565.50,'2 pisos');--16
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Cartuchera de Tela',30,55,262.60,null);
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Correctores Bic L�piz * 1 u',null,3,81.40,null);--18
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('R�tulos * 18 u',100,120,75.90,null);
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Resma hoja A4',50,45,585.00,null);--20

insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Portaminas',null,3,248.90, null);
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('L�pices con goma * 2 u',50,30,65.50,null);
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Goma para L�piz * 10 u',50,100,87.50,null);
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Goma para lapicera * 10 u',50,40,99.50,null);
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('L�pices Color largos * 12 FABER',null,2,178.99,null);
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Lapicera Bic Azul trazo fino',null,100,54.99,null);
insert into articulos (descripcion, stock_minimo, stock, pre_unitario, observaciones) values ('Cuaderno tapa dura rayado',10,20,102.99,null);

--CLIENTES
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Perez', 'Rodolfo','San Mart�n', 120,1,NULL,NULL);
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Castillo', 'Marta Anal�a','Pedro Lozano', 1450,7,NULL,'castillo_marta@yahoo.com');
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Abarca', 'H�ctor','Luis Gongora', 160,12,4701314,'habarca@hotmail.com');
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Morales','Santiago','Le�n y Pizarro', 55,2,155471516,NULL);
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Perez', 'Carlos Antonio','A. Garz�n', 455,2,4554466,NULL);
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Morales', 'Pilar','Le�n y Pizarro', 55,2,155471516,NULL);
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Paez', 'Roque','Humberto Primo', 79,1,4262630,NULL);
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Luque', 'Elvira Josefa','Mariano Usandivaras', 360,3,4502829,NULL);
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Ruiz', 'Marcos','Rivera Indarte', 780,1,NULL,'ruiz_marcos@hotmail.com');
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Moriel', 'Roberto','Santa Rosa', 73,1,NULL,NULL);
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Perez', 'Ana Mar�a','Av. Col�n', 1655,2,NULL,NULL);
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Gonzalez', 'Adriana','San Jer�nimo', 763,1,NULL,NULL);	--Cod_cliente=12
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Moralez', 'Juana','Salamanca', 2345,11,3516111222,'juanita_2018@gmail.com');
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Ariza', 'Sof�a','Derqui', 876,10,3512333444,NULL);
insert into clientes (ape_cliente, nom_cliente, calle, altura, cod_barrio, nro_tel, [e-mail]) values ('Angellozzi', 'Matias','Ituzaing�', 1127,10,3516012345,NULL);	--Cod_cliente=15

--VENDEDORES
insert into vendedores (ape_vendedor, nom_vendedor, calle, altura, cod_barrio, nro_tel, [e-mail], fec_nac) values ('Carrizo', 'Mart�n','San Lorenzo', 369,2,NULL,'mcarrizo@latinmail.com',null);
insert into vendedores (ape_vendedor, nom_vendedor, calle, altura, cod_barrio, nro_tel, [e-mail], fec_nac) values ('Ledesma', 'Mariela','Chachapoyas', 1560,5,4526060,NULL,'22/2/1979');
insert into vendedores (ape_vendedor, nom_vendedor, calle, altura, cod_barrio, nro_tel, [e-mail], fec_nac) values ('Lopez', 'Alejandro','Alsina', 12,3,4612525,'NULL','6/3/1975');
insert into vendedores (ape_vendedor, nom_vendedor, calle, altura, cod_barrio, nro_tel, [e-mail], fec_nac) values ('Miranda', 'Marcelo','Rivera Indarte', 320,1,NULL,NULL,'7/10/1986');
insert into vendedores (ape_vendedor, nom_vendedor, calle, altura, cod_barrio, nro_tel, [e-mail], fec_nac) values ('Monti', 'Gabriel','Altoaguirre', 1245,4,4522122,NULL,'Jul 30 1982');
insert into vendedores (ape_vendedor, nom_vendedor, calle, altura, cod_barrio, nro_tel, [e-mail], fec_nac) values ('Juarez','Susana','Antofagasta', 1785,9,458976,NULL,'30/7/1982'); --Cod_vendedor=6


--FACTURAS
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'02/02/2005');--1
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'13/03/2005');--2
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'30/04/2005');--3
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'03/05/2005');--4
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'06/06/2005');--5
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'03/09/2005');--6
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'09/09/2005');--7
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'14/02/2006');--8
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'14/02/2006');--9
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'15/02/2006');--10
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,5,'16/02/2006');--11
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,6,'17/02/2006');--12
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'17/02/2006');--13
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'17/02/2006');--14
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'12/07/2006');--15
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'13/07/2006');--16
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'12/02/2007');--17
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'12/02/2007');--18
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,5,'13/02/2007');--19
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'13/02/2007');--20
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,6,'13/02/2007');--21
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'15/02/2007');--22
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'10/07/2007');--23
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'10/07/2007');--24
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'12/02/2008');--25
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'12/02/2008');--26
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,2,'13/02/2008');--27
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,5,'13/02/2008');--28
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'14/02/2008');--29
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'16/07/2008');--30
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'16/07/2008');--31
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,5,'17/07/2008');--32
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'17/07/2008');--33
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'10/02/2009');--34
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'10/02/2009');--35
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'11/02/2009');--36
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'12/02/2009');--37
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'12/02/2009');--38
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'13/02/2009');--39
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,6,'12/02/2010');--40
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'12/02/2010');--41
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'13/02/2011');--42
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'13/02/2011');--43
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'13/02/2012');--44
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'13/02/2012');--45
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'14/02/2012');--46
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,5,'14/02/2012');--47
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'08/02/2013');--48
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'15/02/2013');--49
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'08/03/2013');--50
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'08/03/2013');--51
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'04/08/2014');--52
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'01/08/2014');--53
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'01/08/2014');--54
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'04/08/2014');--55
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'31/07/2015');--56
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'31/07/2015');--57
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'05/08/2015');--58
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'07/08/2015');--59
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'10/08/2015');--60
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'10/08/2015');--61

-------
--2012
-------
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'01/08/2016');--62
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/08/2016');--63
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'08/02/2016');--64
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'15/02/2016');--65
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'08/03/2016');--66
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'08/03/2016');--67
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'04/08/2016');--68
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'01/08/2016');--69
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'01/08/2016');--70
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'04/08/2016');--71
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'31/07/2016');--72
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'31/07/2016');--73
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'05/08/2016');--74
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'07/08/2016');--75
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'10/08/2016');--76
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/08/2016');--77
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'08/02/2016');--78
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'15/02/2016');--79
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'08/03/2016');--80
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'08/03/2016');--81
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'04/08/2016');--82
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'01/08/2016');--83
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'01/08/2016');--84
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'04/08/2016');--85
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'31/07/2016');--86
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'31/07/2016');--87
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'05/08/2016');--88
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'07/08/2016');--89
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'10/08/2016');--90
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/08/2016');--91
----------
--2013
----------
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'08/02/2017');--92
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'15/02/2017');--93
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'08/03/2017');--94
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'08/03/2017');--95
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'04/08/2017');--96
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'01/08/2017');--97
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'01/08/2017');--98
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'04/08/2017');--99
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'31/07/2017');--100
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'31/07/2017');--101
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'05/08/2017');--102
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'07/08/2017');--103
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'10/08/2017');--104
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/08/2017');--105
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'08/02/2017');--106
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'15/02/2017');--107
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'08/03/2017');--108
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'08/03/2017');--109
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'04/08/2017');--110
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'01/08/2017');--111
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'01/08/2017');--112
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'04/08/2017');--113
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'31/07/2017');--114
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'31/07/2017');--115
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'05/08/2017');--116
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'07/08/2017');--117
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'10/08/2017');--118
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/08/2017');--119
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'08/02/2017');--120
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'15/02/2017');--121
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'08/03/2017');--122
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'08/03/2017');--123
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'04/08/2017');--124
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'01/08/2017');--125
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'01/08/2017');--126
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'04/08/2017');--127
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'31/07/2017');--128
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'31/07/2017');--129
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'05/08/2017');--130
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'07/08/2017');--131
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'10/08/2017');--132
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/08/2017');--133
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'21/09/2017');--134
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'11/10/2017');--135
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'15/10/2017');--136
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,2,'27/11/2017');--137
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,8,'13/12/2017');--138
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'19/12/2017');--139

----------
--2018
----------
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'18/01/2018');--140
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'25/01/2018');--141
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'03/02/2018');--142
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'16/02/2018');--143
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'18/03/2018');--144
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'28/03/2018');--145
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'17/04/2018');--146
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'28/04/2018');--147
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'07/04/2018');--148
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'12/05/2018');--149
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'15/05/2018');--150
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'26/05/2018');--151
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'04/06/2018');--152
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'09/06/2018');--153
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'13/06/2018');--154
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'14/01/2018');--155
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'11/02/2018');--156
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'11/03/2018');--157
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'14/04/2018');--158
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'11/06/2018');--159
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'21/07/2018');--160
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'24/07/2018');--161
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'31/07/2018');--162
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'31/07/2018');--163
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'05/01/2018');--164
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,6,'17/01/2018');--165
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'10/02/2018');--166
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/03/2018');--167
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'08/02/2018');--168
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'15/02/2018');--169
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'18/03/2018');--170
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'08/03/2018');--171
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'14/03/2018');--172
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'11/03/2018');--173
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'01/04/2018');--174
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'01/04/2018');--175
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'31/07/2018');--176
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'31/07/2018');--177
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'05/07/2018');--178
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'05/07/2018');--179
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'10/06/2018');--180
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'10/05/2018');--181
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'28/02/2018');--182
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'15/02/2018');--183
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'18/03/2018');--184
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'18/03/2018');--185
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'14/03/2018');--186
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'11/03/2018');--187
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'05/06/2018');--188
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'06/06/2018');--189
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'01/07/2018');--190
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'01/07/2018');--191
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'04/08/2018');--192
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'03/08/2018');--193
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'01/08/2018');--194
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'02/08/2018');--195

-------------------------------------------------------------------------------
--2019
-------------------------------------------------------------------------------
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'02/01/2019');--196
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'05/01/2019');--197
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'06/01/2019');--198
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'07/01/2019');--199
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'09/01/2019');--200
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'12/01/2019');--201
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'15/01/2019');--202
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,1,'17/01/2019');--203
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'18/01/2019');--204
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,8,'20/01/2019');--205
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,9,'21/01/2019');--206
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'22/01/2019');--207
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'25/01/2019');--208
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'27/01/2019');--209
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,9,'31/01/2019');--210
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,5,'01/02/2019');--211
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'02/02/2019');--212
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,6,'05/02/2019');--213
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'07/02/2019');--214
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'08/02/2019');--215
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'09/02/2019');--216
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/02/2019');--217
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'12/02/2019');--218
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'13/02/2019');--219
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'15/02/2019');--220
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,1,'16/02/2019');--221
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,2,'18/02/2019');--222
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'19/02/2019');--223
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'21/02/2019');--224
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,5,'25/02/2019');--225
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'27/02/2019');--226
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'01/03/2019');--227
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'05/03/2019');--228
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'06/03/2019');--229
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,9,'08/03/2019');--230
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'09/03/2019');--231
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'10/03/2019');--232
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'11/03/2019');--233
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'14/03/2019');--234
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,5,'16/03/2019');--235
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,6,'18/03/2019');--236
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,7,'20/03/2019');--237
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'21/03/2019');--238
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,9,'24/03/2019');--239
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'26/03/2019');--240
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'28/03/2019');--241
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'01/04/2019');--242
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,9,'03/04/2019');--243
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,2,'05/04/2019');--244
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'06/04/2019');--245
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'07/04/2019');--246
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,5,'08/04/2019');--247
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,7,'10/04/2019');--248
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'11/04/2019');--249
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,8,'12/04/2019');--250
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,9,'15/04/2019');--251
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,9,'16/04/2019');--252
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,7,'18/04/2019');--253
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,7,'19/04/2019');--254
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'20/04/2019');--255
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,3,'21/04/2019');--256
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,2,'22/04/2019');--257
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'23/04/2019');--258
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'23/04/2019');--259
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'25/04/2019');--260
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'25/04/2019');--261
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'28/04/2019');--262
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'30/04/2019');--263
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'30/04/2019');--264
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'30/04/2019');--265
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'01/05/2019');--266
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'01/05/2019');--267
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'02/05/2019');--268
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'03/05/2019');--269
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'03/05/2019');--270
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'04/05/2019');--271
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'05/05/2019');--272
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,6,'06/05/2019');--273
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'07/05/2019');--274
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,7,'08/05/2019');--275
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'09/05/2019');--276
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'10/05/2019');--277
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'11/05/2019');--278
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'12/05/2019');--279
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,1,'14/05/2019');--280
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'15/05/2019');--281
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'16/05/2019');--282
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'16/05/2019');--283
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'16/05/2019');--284
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,6,'17/05/2019');--285
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,7,'19/05/2019');--286
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,8,'20/05/2019');--287
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,9,'22/05/2019');--288
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'24/05/2019');--289
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,1,'26/05/2019');--290
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'28/05/2019');--291
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'28/05/2019');--292
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'31/05/2019');--293
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'01/06/2019');--294
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,6,'02/06/2019');--295
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'04/06/2019');--296
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'04/06/2019');--297
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'06/06/2019');--298
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'07/06/2019');--299
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,9,'08/06/2019');--300
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'09/06/2019');--301
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'10/06/2019');--302
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'12/06/2019');--303
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,6,'13/06/2019');--304
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'15/06/2019');--305
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,3,'16/06/2019');--306
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,2,'16/06/2019');--307
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,1,'18/06/2019');--308
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'19/06/2019');--309
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'19/06/2019');--310
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'20/06/2019');--311
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,6,'21/06/2019');--312
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'22/06/2019');--313
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'23/06/2019');--314
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'24/06/2019');--315
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'25/06/2019');--316
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'26/06/2019');--317
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'27/06/2019');--318
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'28/06/2019');--319
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,9,'28/06/2019');--320
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'29/06/2019');--321
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,7,'30/06/2019');--322

-------------------------------------------------------------------------------
--2020
-------------------------------------------------------------------------------
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'02/01/2020');--323
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'05/01/2020');--324
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'06/01/2020');--325
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'07/01/2020');--326
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,5,'09/01/2020');--327
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,6,'12/01/2020');--328
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'15/01/2020');--329
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'17/01/2020');--330
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'18/01/2020');--331
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,9,'20/01/2020');--332
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'21/01/2020');--333
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'22/01/2020');--334
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'25/01/2020');--335
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'27/01/2020');--336
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'31/01/2020');--337
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'01/02/2020');--338
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,2,'02/02/2020');--339
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'05/02/2020');--340
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'07/02/2020');--341
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'08/02/2020');--342
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'09/02/2020');--343
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,9,'10/02/2020');--344
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'12/02/2020');--345
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,5,'13/02/2020');--346
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'15/02/2020');--347
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,6,'16/02/2020');--348
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'18/02/2020');--349
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,8,'19/02/2020');--350
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,9,'21/02/2020');--351
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,1,'25/02/2020');--352
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,2,'27/02/2020');--353
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'01/03/2020');--354
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'05/03/2020');--355
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,6,'06/03/2020');--356
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,2,'08/03/2020');--357
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'09/03/2020');--358
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'10/03/2020');--359
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'11/03/2020');--360
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,6,'14/03/2020');--361
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,2,'16/03/2020');--362
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,3,'18/03/2020');--363
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'20/03/2020');--364
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'21/03/2020');--365
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'24/03/2020');--366
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'26/03/2020');--367
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'28/03/2020');--368
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'01/04/2020');--369
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'03/04/2020');--370
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'05/04/2020');--371
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,9,'06/04/2020');--372
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'07/04/2020');--373
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'08/04/2020');--374
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'10/04/2020');--375
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'11/04/2020');--376
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'12/04/2020');--377
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'15/04/2020');--378
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,9,'16/04/2020');--379
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'18/04/2020');--380
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'19/04/2020');--381
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'20/04/2020');--382
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'21/04/2020');--383
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'22/04/2020');--384
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,7,'23/04/2020');--385
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,8,'23/04/2020');--386
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,9,'25/04/2020');--387
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,6,'25/04/2020');--388
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'28/04/2020');--389
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'30/04/2020');--390
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,1,'30/04/2020');--391
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'30/04/2020');--392
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,2,'01/05/2020');--393
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'01/05/2020');--394
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,6,'02/05/2020');--395
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'03/05/2020');--396
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'03/05/2020');--397
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,5,'04/05/2020');--398
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'05/05/2020');--399
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,1,'06/05/2020');--400
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,2,'07/05/2020');--401
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'08/05/2020');--402
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'09/05/2020');--403
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/05/2020');--404
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'11/05/2020');--405
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,1,'12/05/2020');--406
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,2,'14/05/2020');--407
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'15/05/2020');--408
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'16/05/2020');--409
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'16/05/2020');--410
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'16/05/2020');--411
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'17/05/2020');--412
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'19/05/2020');--413
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'20/05/2020');--414
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,9,'22/05/2020');--415
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,9,'24/05/2020');--416
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'26/05/2020');--417
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'28/05/2020');--418
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'28/05/2020');--419
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,6,'31/05/2020');--420
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,5,'01/06/2020');--421
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,6,'02/06/2020');--422
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,8,'04/06/2020');--423
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,9,'04/06/2020');--424
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,1,'14/06/2020');--425
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'16/07/2020');--426
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'17/07/2020');--427
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'19/07/2020');--428
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'20/08/2020');--429
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,9,'22/09/2020');--430
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'24/09/2020');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'26/09/2020');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,5,'28/09/2020');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'28/09/2020');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'01/10/2020');--435
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'09/10/2020');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'19/11/2020');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,9,'22/11/2020');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'09/12/2020');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,2,'18/12/2020');--440
-------------------------------------------------------------------------------
--2021
-------------------------------------------------------------------------------
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'25/01/2021');--441
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'25/01/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'26/01/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'27/01/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,5,'29/01/2021');--445
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,6,'30/01/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'01/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'01/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'08/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,9,'08/02/2021');--450
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'10/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'12/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'15/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'17/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'18/02/2021');--455
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'19/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,2,'20/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'20/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'21/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'22/02/2021');--460
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'22/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,9,'22/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'23/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,5,'26/02/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'01/03/2021');--465
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,6,'02/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'02/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,8,'03/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,9,'04/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,1,'05/03/2021');--470
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,2,'07/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'08/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'09/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,6,'10/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,2,'11/03/2021');--475
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'12/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,5,'13/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'13/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,6,'14/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,2,'16/03/2021');--480
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,3,'18/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'20/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'21/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'24/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'26/03/2021');--485
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,4,'28/03/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'01/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,7,'02/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'03/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,9,'05/04/2021');--490
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'05/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'06/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'07/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'08/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,8,'09/04/2021');--495
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'10/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,9,'12/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'13/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'14/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'15/04/2021');--500
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'16/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'17/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,7,'19/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,8,'20/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,9,'21/04/2021');--505
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,6,'22/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,7,'23/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'24/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,1,'25/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'26/04/2021');--510
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,2,'27/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,4,'27/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,6,'29/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,4,'30/04/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'03/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,1,'04/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,2,'05/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,3,'06/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,4,'07/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,2,'08/05/2021');--520
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'10/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,6,'10/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'11/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,3,'12/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,6,'12/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,5,'13/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,6,'14/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'15/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,9,'17/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,1,'17/05/2021');--530
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,9,'18/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'19/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(5,2,'20/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,9,'20/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'21/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'22/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,3,'23/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,10,'23/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,9,'26/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,8,'27/05/2021');--540
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'28/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'29/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,2,'29/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'31/05/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'02/06/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,6,'03/06/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,11,'04/06/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'05/06/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,10,'06/06/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'06/06/2021');--550
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'08/06/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'19/06/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,2,'29/06/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,1,'30/06/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'16/07/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,6,'23/07/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,11,'24/07/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,2,'25/07/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,1,'26/07/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,8,'26/07/2021');--560
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,7,'28/07/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,3,'29/07/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(2,10,'30/07/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,5,'02/08/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,6,'03/08/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,11,'04/08/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(3,8,'05/08/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,9,'06/08/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(4,4,'09/08/2021');
insert into facturas (cod_vendedor, cod_cliente, fecha) values(1,10,'12/08/2021');--570
-------------------------------------------------------------------------------
--detalle_facturas FACTURAS
-------------------------------------------------------------------------------
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(1,16,2.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(1,23,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(2,6,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(2,16,1.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(3,7,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(3,8,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(4,16,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(4,18,5.00,24);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(5,11,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(5,18,4.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(6,4,2.00,33);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(6,7,1.00,60);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(7,17,31.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(7,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(8,3,4.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(8,8,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(8,10,1.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(9,23,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(10,2,2.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(10,13,101.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(11,8,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(11,15,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(12,20,6.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(13,13,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(14,16,2.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(14,18,4.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(15,3,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(15,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(16,13,101.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(17,3,4.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(17,6,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(17,19,15.90,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(18,2,3.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(19,6,5.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(19,18,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(20,23,1.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(21,8,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(22,8,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(22,20,6.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(23,16,1.00,45);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(23,17,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(24,3,4.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(25,6,6.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(25,20,6.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(26,2,2.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(26,18,5.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(27,23,1.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(28,11,1.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(29,20,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(30,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(30,11,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(30,16,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(31,15,1.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(32,15,1.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(33,2,2.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(33,16,2.00,44);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(33,23,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(34,8,2.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(34,9,2.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(34,13,101.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(34,17,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(34,20,7.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(35,2,4.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(35,15,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(35,18,5.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(36,13,101.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(37,4,1.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(37,17,1.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(38,2,4.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(38,7,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(38,8,2.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(39,15,1.00,45);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(39,23,1.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(40,7,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(40,15,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(41,15,1.00,60);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(42,2,4.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(42,15,4.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(43,18,5.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(43,20,4.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(44,2,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(44,17,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(44,23,1.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(45,4,1.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(45,13,101.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(46,18,5.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(47,2,4.00,45);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(47,8,2.00,32);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(47,15,1.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(47,23,1.00,11);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(48,13,101.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(48,15,1.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(48,24,3.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(49,3,6.00,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(50,1,2.00,9);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(50,3,6.00,8);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(51,5,6.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(51,17,4.00,36);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(52,11,13.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(52,1,9.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(53,10,3.00,7);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(53,16,8.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(53,19,15.90,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(53,20,21.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(54,9,18.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(55,5,12.00,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(55,14,17.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(56,7,7.85,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(56,10,6.30,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(56,15,13.90,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(57,17,6.60,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(58,5,15.50,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(58,15,13.90,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(58,17,6.75,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(59,9,15.90,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(59,25,20.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(60,5,15.30,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(60,14,18.10,2);
-------
--2016
-------
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(61,16,2.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(61,23,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(62,6,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(62,16,1.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(63,7,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(63,8,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(64,16,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(64,18,5.00,24);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(65,11,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(65,18,4.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(66,4,2.00,33);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(66,7,1.00,60);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(67,17,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(67,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(68,3,4.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(68,8,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(68,10,1.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(69,23,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(70,2,2.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(71,13,101.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(71,8,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(71,15,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(72,20,6.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(73,13,101.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(74,16,2.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(74,18,4.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(75,3,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(75,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(76,13,101.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(77,3,4.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(77,6,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(77,19,16.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(78,2,3.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(79,6,5.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(79,18,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(80,23,1.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(81,8,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(82,8,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(82,20,6.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(83,16,1.00,45);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(83,17,1.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(84,3,4.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(85,6,6.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(85,20,6.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(86,2,2.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(86,18,5.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(87,23,1.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(88,11,1.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(89,20,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(90,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(90,16,2.00,40);
------
--2017
------
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(91,16,25.50,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(91,23,5.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(92,6,26.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(92,16,25.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(93,7,15.70,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(93,8,10.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(94,16,21.70,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(94,18,25.00,24);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(95,11,4.5,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(95,18,24.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(96,4,12.00,33);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(96,7,15.70,60);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(97,17,9.40,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(97,20,15.10,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(98,3,24.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(98,8,10.70,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(98,10,1.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(99,23,5.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(100,2,2.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(100,13,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(101,8,10.90,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(101,15,1.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(102,20,16.10,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(103,13,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(104,16,21.50,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(104,18,24.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(105,3,24.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(105,20,15.10,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(106,13,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(107,3,24.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(107,6,26.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(107,19,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(108,2,3.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(109,6,25.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(109,18,24.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(110,23,5.50,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(110,8,10.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(111,8,10.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(111,20,16.10,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(112,16,21.50,45);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(112,17,17.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(112,3,24.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(113,6,26.00,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(113,20,16.10,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(114,2,2.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(115,18,25.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(115,23,5.50,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(116,11,4.50,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(116,20,16.10,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(116,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(117,16,21.50,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(117,18,24.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(118,3,24.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(118,20,15.10,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(119,13,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(120,3,24.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(121,6,26.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(122,19,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(122,2,3.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(123,6,15.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(123,18,24.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(124,23,1.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(124,8,12.00,32);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(125,8,12.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(126,20,16.10,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(126,16,21.00,45);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(127,17,17.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(127,3,24.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(128,6,26.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(128,20,26.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(128,2,2.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(129,18,5.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(129,23,1.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(130,11,1.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(130,20,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(131,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(131,16,2.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(132,18,4.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(132,3,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(132,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(133,20,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(134,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(135,16,22.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(135,1,12.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(135,11,4.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(136,18,24.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(137,3,24.00,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(138,20,45.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(138,25,25.00,7);

----------
--2018
----------
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(139,16,22.00,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(140,23,7.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(141,6,27.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(142,16,25.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(143,7,15.70,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(143,8,12.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(144,16,25.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(144,18,31.00,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(145,11,12.70,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(145,18,31.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(146,4,20.00,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(146,7,15.70,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(147,17,9.60,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(147,20,52.90,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(148,3,25.50,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(148,8,12.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(148,10,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(149,23,7.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(150,2,22.30,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(150,13,41.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(151,8,12.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(151,15,13.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(152,20,52.90,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(153,13,41.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(154,16,27.50,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(154,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(155,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(155,20,52.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(156,13,41.90,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(157,3,25.50,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(157,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(157,19,1.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(158,2,22.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(159,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(159,18,31.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(160,23,7.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(160,8,12.90,26);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(161,8,12.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(161,20,52.90,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(162,16,27.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(162,17,9.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(162,3,25.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(163,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(163,20,52.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(164,2,22.30,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(165,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(165,23,7.50,27);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(166,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(166,20,52.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(166,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(167,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(167,18,31.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(168,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(168,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(169,13,41.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(170,3,25.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(171,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(172,19,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(172,2,3.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(173,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(173,18,31.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(174,23,1.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(174,8,12.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(175,8,12.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(176,20,6.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(176,16,27.00,45);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(177,17,9.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(177,3,25.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(178,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(178,20,52.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(178,2,22.30,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(179,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(179,23,7.50,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(180,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(180,20,52.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(181,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(181,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(182,18,4.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(182,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(182,20,52.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(183,20,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(184,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(185,16,27.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(185,1,12.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(185,11,12.70,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(186,18,24.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(187,3,24.00,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(188,20,45.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(188,25,25.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(189,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(189,23,7.50,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(190,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(190,20,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(191,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(191,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(192,18,31.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(192,3,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(192,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(193,20,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(194,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(195,3,7.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(195,6,4.00,8);

----------
--2019
----------

insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(196,16,22.00,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(196,23,7.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(196,6,27.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(197,16,25.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(198,7,15.70,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(198,8,12.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(199,16,25.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(199,18,31.00,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(200,11,12.70,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(200,18,31.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(201,4,20.00,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(201,7,15.70,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(202,17,9.60,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(202,20,52.90,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(203,3,25.50,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(203,8,12.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(203,10,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(204,23,7.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(204,2,22.30,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(205,13,41.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(205,8,12.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(206,15,13.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(206,20,52.90,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(207,13,41.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(207,16,27.50,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(208,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(208,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(209,20,52.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(209,13,41.90,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(210,3,25.50,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(210,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(211,19,1.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(211,2,22.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(212,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(212,18,31.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(213,23,7.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(213,8,12.90,26);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(214,8,12.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(214,20,52.90,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(215,16,27.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(216,17,9.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(216,3,25.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(217,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(218,20,52.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(219,2,22.30,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(220,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(221,23,7.50,27);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(221,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(222,20,52.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(222,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(223,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(223,18,31.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(223,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(224,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(224,13,41.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(225,3,25.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(225,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(226,19,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(226,2,3.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(227,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(227,18,31.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(228,23,1.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(229,8,12.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(229,1,9,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(230,20,6.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(231,16,27.00,45);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(232,17,9.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(233,3,25.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(234,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(235,20,52.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(236,2,22.30,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(236,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(237,23,7.50,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(237,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(238,20,52.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(239,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(240,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(241,18,4.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(241,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(241,20,52.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(242,20,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(242,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(243,16,27.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(243,1,12.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(244,11,12.70,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(245,18,24.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(246,3,24.00,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(246,20,45.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(247,25,50.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(248,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(248,23,7.50,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(249,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(250,20,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(251,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(251,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(252,18,31.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(252,3,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(253,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(254,20,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(254,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(255,3,7.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(255,6,4.00,8);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(256,16,22.00,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(256,23,7.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(257,6,27.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(257,16,25.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(258,7,15.70,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(259,8,12.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(259,16,25.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(260,18,31.00,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(261,11,12.70,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(262,18,31.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(262,4,20.00,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(263,7,15.70,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(264,17,9.60,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(265,20,52.90,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(265,3,25.50,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(265,8,12.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(266,10,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(267,23,7.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(267,2,22.30,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(268,13,41.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(268,8,12.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(268,15,13.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(269,20,52.90,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(269,13,41.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(270,16,27.50,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(271,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(271,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(272,20,52.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(273,13,41.90,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(273,3,25.50,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(274,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(274,19,1.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(275,2,22.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(275,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(276,18,31.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(276,23,7.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(277,8,12.90,26);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(278,8,12.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(278,20,52.90,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(279,16,27.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(279,17,9.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(280,3,25.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(280,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(281,20,52.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(282,2,22.30,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(283,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(284,23,7.50,27);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(285,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(286,20,52.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(286,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(287,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(287,18,31.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(288,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(288,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(289,13,41.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(289,3,25.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(290,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(291,19,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(292,2,3.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(293,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(294,18,31.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(294,23,1.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(295,8,12.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(296,8,12.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(296,20,6.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(297,16,27.00,45);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(297,17,9.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(298,3,25.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(298,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(298,20,52.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(299,2,22.30,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(299,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(300,23,7.50,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(300,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(301,20,52.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(302,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(302,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(303,18,4.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(303,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(304,20,52.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(304,5,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(305,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(305,16,27.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(306,1,12.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(306,11,12.70,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(307,18,24.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(307,3,24.00,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(308,20,45.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(308,25,50.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(309,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(309,23,7.50,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(310,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(310,20,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(310,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(311,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(311,18,31.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(312,3,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(313,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(313,2,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(314,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(314,3,7.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(315,6,4.00,8);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(315,16,27.00,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(316,18,31.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(317,3,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(317,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(318,20,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(318,9,5.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(318,3,7.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(319,6,4.00,8);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(319,9,5.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(320,3,7.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(320,6,4.00,8);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(321,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(321,3,7.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(322,6,4.00,8);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(322,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(322,3,7.00,5);

----------
--2020
----------

insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(323,16,22.00,18);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(323,23,7.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(324,6,27.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(324,16,25.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(324,7,15.70,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(325,8,12.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(326,16,25.00,23);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(327,18,31.00,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(328,11,12.70,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(328,18,31.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(329,4,20.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(329,7,15.70,16);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(330,17,9.60,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(331,20,52.90,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(332,3,25.50,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(332,8,12.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(333,10,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(333,23,7.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(334,2,22.30,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(334,13,41.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(335,8,12.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(336,15,13.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(336,20,52.90,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(337,13,41.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(337,16,27.50,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(337,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(338,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(338,20,52.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(339,13,41.90,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(339,3,25.50,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(339,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(339,19,1.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(340,2,22.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(341,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(342,18,31.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(343,23,15.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(344,8,12.90,26);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(344,3,12,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(345,20,52.90,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(345,16,27.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(346,17,9.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(347,3,25.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(347,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(348,20,52.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(348,2,22.30,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(349,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(349,23,15.50,7);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(349,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(350,20,52.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(351,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(352,16,27.00,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(353,18,31.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(354,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(354,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(355,13,41.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(356,3,25.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(356,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(357,19,1.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(358,2,3.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(359,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(360,18,31.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(361,23,15.00,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(361,8,12.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(362,8,12.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(363,20,6.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(364,16,27.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(365,17,9.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(365,3,25.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(366,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(366,20,52.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(367,2,22.30,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(367,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(368,23,27.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(368,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(369,20,52.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(370,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(371,16,55.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(372,18,4.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(373,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(374,20,52.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(375,20,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(376,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(377,16,55.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(377,1,12.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(378,11,12.70,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(378,18,24.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(379,3,24.00,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(379,20,45.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(380,25,50.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(380,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(381,23,27.50,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(382,11,12.70,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(382,20,6.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(383,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(383,16,60.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(384,18,31.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(385,3,4.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(386,20,5.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(387,20,46.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(388,9,5.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(388,3,7.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(389,6,4.00,8);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(390,16,60.00,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(390,23,27.00,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(391,6,27.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(392,16,60.00,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(393,7,15.70,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(393,8,12.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(394,16,60.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(395,18,31.00,14);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(396,11,12.70,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(396,18,31.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(397,4,20.00,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(398,7,15.70,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(399,17,9.60,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(399,20,152.90,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(400,3,25.50,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(400,8,12.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(401,10,6.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(401,23,27.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(402,2,22.30,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(402,13,41.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(402,8,12.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(403,15,13.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(403,20,152.90,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(404,13,41.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(404,16,60.50,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(405,18,31.00,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(405,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(406,20,152.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(407,13,41.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(408,3,25.50,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(408,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(409,19,15.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(410,2,22.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(410,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(411,18,31.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(411,23,27.50,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(412,8,12.90,6);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(413,8,12.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(414,20,152.90,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(414,16,64.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(415,17,9.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(415,3,25.50,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(415,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(416,20,15.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(416,2,22.30,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(417,18,31.00,22);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(418,23,27.50,7);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(418,11,12.70,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(419,20,152.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(419,9,1.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(420,16,65.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(420,18,31.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(421,3,25.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(422,20,152.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(423,13,41.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(424,3,25.50,2);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(424,6,27.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(425,19,15.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(425,2,3.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(425,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(426,1,15.50,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(427,2,22.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(427,3,22.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(428,4,22.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(429,5,25.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(430,8,12.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(431,3,22.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(432,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(433,7,15.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(434,10,5.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(434,12,12.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(435,13,101.60,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(435,11,12.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(435,16,65.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(436,20,152.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(436,12,12.30,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(437,8,12.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(438,3,22.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(438,1,15.50,9);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(439,2,22.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(439,19,15.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(440,6,27.00,4);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(440,8,12.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(440,1,15.00,25)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(441,2,22.00,5)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(442,9,15.00,15)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(443,2,12.00,12)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(443,6,27.00,20)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(444,7,15.00,5)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(445,4,20.00,8)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(445,1,12.00,2)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(446,8,12.00,3)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(447,5,23.00,2)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(448,4,20.00,2)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(449,7,15.00,5)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(450,2,22.00,10)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(450,8,12.00,10)

----------
--2021
----------
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(451,3,450.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(451,5,122.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(451,13,640.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(452,6,27.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(453,7,55.90,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(454,1,140.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(454,12,62.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(455,3,600.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(455,11,72.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(455,6,127.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(456,12,62.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(456,15,12.30,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(457,8,212.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(458,13,640.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(458,10,5.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(459,12,62.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(459,19,45.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(460,16,465.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(460,18,41.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(461,11,75.00,15)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(461,3,600.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(461,13,640.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(461,6,127.50,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(462,16,465.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(463,17,130.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(464,10,5.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(464,12,62.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(465,13,640.60,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(465,11,72.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(465,16,465.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(466,20,352.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(466,12,62.30,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(467,8,12.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(468,3,600.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(468,1,150.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(469,2,500.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(469,19,55.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(470,16,65.00,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(470,8,212.90,40);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(470,5,125.00,20)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(471,3,600.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(471,4,22.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(471,6,127.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(472,6,127.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(473,7,55.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(474,10,35.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(474,12,62.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(475,13,640.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(475,11,72.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(475,16,465.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(476,20,352.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(476,12,62.30,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(477,8,212.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(478,3,600.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(478,1,150.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(479,2,500.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(479,19,55.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(480,6,127.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(480,8,212.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(480,1,150.00,20)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(481,11,72.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(481,10,36.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(481,9,15.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(482,16,465.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(483,17,32.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(484,12,62.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(484,15,16.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(485,13,640.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(485,1,129.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(485,6,127.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(486,2,500.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(486,12,62.30,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(487,5,122.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(488,3,600.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(488,1,150.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(489,2,500.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(489,19,55.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(490,6,127.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(490,8,212.90,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(491,1,150.00,20)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(491,8,12.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(492,5,122.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(492,7,45.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(492,3,600.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(493,1,149.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(494,1,149.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(495,2,500.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(495,3,600.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(495,17,132.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(495,16,465.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(496,20,352.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(497,12,62.30,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(497,8,12.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(497,3,600.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(498,1,150.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(499,2,500.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(499,19,55.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(500,6,127.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(500,8,212.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(500,1,150.00,10)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(501,3,600.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(501,11,72.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(501,4,122.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(502,6,127.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(503,7,55.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(504,10,36.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(504,12,62.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(505,13,640.60,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(505,11,72.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(505,16,565.90,3);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(506,20,352.90,9);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(506,12,62.30,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(507,8,212.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(508,3,600.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(508,1,150.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(509,2,500.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(509,19,55.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(509,6,127.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(510,2,500.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(510,6,27.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(511,18,51.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(511,23,87.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(512,8,12.90,26);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(513,8,212.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(513,20,352.90,17);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(514,16,565.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(515,17,132.60,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(515,3,600.00,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(515,6,27.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(516,20,352.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(517,2,500.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(517,18,41.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(517,23,87.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(518,11,72.70,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(519,20,352.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(519,9,226.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(520,6,127.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(521,8,13.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(521,13,640.50,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(522,20,352.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(523,13,640.90,1);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(524,13,640.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(524,16,65.50,24);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(525,9,16.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(525,12,63.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(525,3,600.00,18);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(526,11,75.50,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(527,12,60.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(527,6,127.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(528,14,640.30,13);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(529,5,75.90,19);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(530,8,212.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(531,3,600.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(532,20,385.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(533,13,640.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(534,3,600.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(535,6,127.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(535,9,260.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(535,12,63.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(535,1,150.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(536,14,640.50,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(537,20,385.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(537,5,82.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(538,14,640.30,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(539,5,85.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(540,8,200.00,10);

insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(541,10,35.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(542,11,80.00,9);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(543,13,640.90,8);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(544,13,640.50,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(544,2,500.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(545,1,150.00,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(546,4,101.30,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(546,11,75.90,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(546,8,200.00,26);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(547,13,640.50,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(548,20,385.00,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(549,13,640.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(550,13,640.50,21);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(550,6,30.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(550,14,650.30,23);

insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(551,11,75.00,20)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(552,3,600.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(552,13,640.50,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(552,6,127.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(552,16,465.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(553,17,130.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(554,10,5.90,55);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(554,12,62.00,35);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(554,13,640.60,12);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(555,11,72.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(556,16,465.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(557,20,352.90,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(558,10,5.50,28);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(559,12,62.90,50);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(559,19,45.00,19);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(560,16,465.00,5);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(560,18,41.00,30);

insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(561,16,465.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(561,18,41.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(561,11,75.00,15)
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(562,3,600.00,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(562,13,640.50,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(562,6,127.50,30);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(562,16,465.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(563,17,130.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(564,10,5.90,10);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(564,12,62.00,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(564,13,640.60,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(565,11,72.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(566,16,465.90,20);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(567,20,352.90,15);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(568,10,5.50,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(569,12,62.90,25);
insert into detalle_facturas (nro_factura, cod_articulo, pre_unitario, cantidad) values(570,19,45.00,10);
