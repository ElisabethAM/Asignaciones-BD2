--------------------	CONSIDERACIONES 	-------------------------------
--se realizó un mapeado del diagrama ER dado en la tarea a uno relacional (disponible en el repositorio como una imagen)
--Ejecutar cada paso en orden: 1 , 2 , 3 , 4 , 5 Y 6
--son 5 tablas en total: Hotel, Cliente, Aerolinea, Boleto y Hotel_Cliente
--se realizaron inserts respectivos para cada tabla para demostrar la funcionalidad de la base de datos
--las restricciones detalladas en la tarea están acompañadas por un comentario que las distingue en el codigo de creacion de tablas( paso 3)
--en el caso de las PK se asigna un tipo de dato NVARCHAR de 10 caracteres máximo a excepcion de la PK Clientes
--se crearon primero las tablas que no tienen referencias hacia otras y posteriormente, las tablas con LLaves foráneas

-------------------	CREACION DE LA BASE (PASO1)	-------------------------------
CREATE DATABASE VIAJES

-------------------	USO DE LA BASE (PASO2)	-------------------------------
USE VIAJES 

-------------------	CREACION DE TABLAS (PASO3)	-------------------------------

CREATE TABLE Hotel
(
	codigoHotel		NVARCHAR(10) NOT NULL,
	nombreHotel		NVARCHAR(40) NOT NULL,
	direccionHotel	NVARCHAR(40) NOT NULL,

	CONSTRAINT PK_Hotel PRIMARY KEY (codigoHotel),
)

CREATE TABLE Cliente
(
	idCliente		NVARCHAR(30) NOT NULL,
	nombreCliente	NVARCHAR(100) NOT NULL,
	telefonoCliente	NVARCHAR(10) NOT NULL,

	CONSTRAINT PK_Cliente PRIMARY KEY (idCliente),
)

CREATE TABLE aerolinea
(
	codigoAerolinea	NVARCHAR(10) NOT NULL,
	descuento		DECIMAL NOT NULL,

	CONSTRAINT PK_Aerolinea PRIMARY KEY (codigoAerolinea),
	CONSTRAINT CHK_Aerolinea1 CHECK (descuento > 10 or descuento = 10) ---RESTRICCION DE LA TAREA----
)

CREATE TABLE Boleto
(
	codigoBoleto	NVARCHAR(10) NOT NULL,
	numVuelo		NVARCHAR(10) NOT NULL,
	fecha			DATE NOT NULL,
	destino			NVARCHAR(30) NOT NULL,
	idCliente		NVARCHAR(30) NOT NULL,
	codigoAerolinea	NVARCHAR(10) NOT NULL,

	CONSTRAINT PK_Boleto	PRIMARY KEY (codigoBoleto),
	CONSTRAINT FK_Boleto1	FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
	CONSTRAINT FK_Boleto2	FOREIGN KEY (codigoAerolinea) REFERENCES Aerolinea(codigoAerolinea),
	CONSTRAINT CHK_Boleto1	CHECK (destino= 'México' or destino= 'Guatemala' or destino= 'Panamá') ---RESTRICCION DE LA TAREA----
)

CREATE TABLE Hotel_Cliente
(
	codigoHotel			NVARCHAR(10) NOT NULL,
	idCliente			NVARCHAR(30) NOT NULL,
	fechaIn				DATE NOT NULL,
	fechaOut			DATE NOT NULL,
	cantidadPersonas	INT DEFAULT 0, ---RESTRICCION DE LA TAREA----

	CONSTRAINT PK_Hotel_Cliente PRIMARY KEY (codigoHotel,idCliente),
	CONSTRAINT FK_Hotel_Cliente1 FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
	CONSTRAINT FK_Hotel_Cliente2 FOREIGN KEY (codigoHotel) REFERENCES Hotel(codigoHotel),
)

--------------------	SELECTS PARA VISUALIZAR TABLAS SIN TUPLAS (PASO 4) 	-------------------------------
SELECT *FROM Hotel
SELECT *FROM Cliente
SELECT *FROM Aerolinea
SELECT *FROM Boleto
SELECT *FROM Hotel_Cliente

--------------------	INSERTS PARA LAS TABLAS (PASO 5) 	-------------------------------

INSERT INTO Hotel VALUES ('001','Hotel Intercontinental','Las Bahamas')
INSERT INTO Hotel VALUES ('002','Hotel Isla Bonita','Tegucigalpa')
INSERT INTO Hotel VALUES ('003','Hotel Vegetta777','Planeta vegetta')
INSERT INTO Hotel VALUES ('004','Hotel Billy Amstrong','Las Vegas')
INSERT INTO Hotel VALUES ('005','Hotel Victoria','Brazil')

INSERT INTO Cliente VALUES ('0801 2000 0000','Elisabeth Maradiaga','98010000')
INSERT INTO Cliente VALUES ('0801 1999 0000','Carlos Donaire','32456980')
INSERT INTO Cliente VALUES ('0715 2002 0030','Erick Molina','34561289')
INSERT INTO Cliente VALUES ('0801 1970 0230','Daniel Arguijo','92348967')
INSERT INTO Cliente VALUES ('0801 1989 0000','Yensi Armijo','98010000')

INSERT INTO aerolinea VALUES ('001',15.5)
INSERT INTO aerolinea VALUES ('002',12.5)
INSERT INTO aerolinea VALUES ('003',18.5)
INSERT INTO aerolinea VALUES ('004',20.0)
INSERT INTO aerolinea VALUES ('005',30.5)
--INSERT INTO aerolinea VALUES ('006',5.7) PRUEBA DE ERROR PARA EL DESCUENTO DE LA AEROLINEA

INSERT INTO Boleto VALUES ('001','102','14-09-2022','México','0801 2000 0000','003')
INSERT INTO Boleto VALUES ('002','203','05-05-2021','Panamá','0715 2002 0030','001')
INSERT INTO Boleto VALUES ('003','120','23-08-2020','México','0801 1999 0000','002')
INSERT INTO Boleto VALUES ('004','056','04-04-2021','Panamá','0801 1970 0230','004')
INSERT INTO Boleto VALUES ('005','391','07-02-2022','Guatemala','0801 1989 0000','005')
--INSERT INTO Boleto VALUES ('006','901','07-02-2022','Honduras','0801 1989 0000','005') PRUEBA DE ERROR PARA DESTINO

INSERT INTO Hotel_Cliente VALUES ('001','0801 2000 0000','10-09-2022','13-09-2022','') --PRUEBA DE CANTIDAD DE PERSONAS POR DEFAULT =0
INSERT INTO Hotel_Cliente VALUES ('002','0801 1999 0000','20-08-2020','22-08-2020','3')
INSERT INTO Hotel_Cliente VALUES ('003','0715 2002 0030','01-05-2021','04-05-2021','1')
INSERT INTO Hotel_Cliente VALUES ('004','0801 1970 0230','30-03-2021','02-04-2021','2')
INSERT INTO Hotel_Cliente VALUES ('005','0801 1989 0000','05-02-2022','06-02-2022','5')

--------------------	VISUALIZACION DE LAS TABLAS CON SUS FILAS (PASO 6) 	-------------------------------
SELECT *FROM Hotel
SELECT *FROM Cliente
SELECT *FROM Aerolinea
SELECT *FROM Boleto
SELECT *FROM Hotel_Cliente

--------------------	FIN DEL SCRIPT :) 	-------------------------------