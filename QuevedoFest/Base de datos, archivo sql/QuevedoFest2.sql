
DROP DATABASE IF EXISTS QuevedoFest;
CREATE DATABASE QuevedoFest;
CREATE TABLE quevedofest (
    id INT CONSTRAINT quevedofest_pk PRIMARY KEY,
    nombre VARCHAR(15),
    ubicacion VARCHAR(10),
    capacidad INT,
    web VARCHAR(255)
);
--
INSERT INTO quevedofest VALUES (5,'QuevedoFest', 'Madrid', 15000, 'https://www.QuevedoFest.es');
--
--

CREATE TABLE departamentos (
    id INT CONSTRAINT departamentos_pk PRIMARY KEY,
    nombre VARCHAR(20),
    competencias VARCHAR(100),
    id_quevedofest INT,
    CONSTRAINT departamentos_quevedofest_fk FOREIGN KEY (id_quevedofest) REFERENCES quevedofest (id)
);
--
INSERT INTO departamentos VALUES (5, 'Area Financiera', 'Lleva el balance contable del festival', 5),
(10, 'Area Organizativa', 'Montaje y mantenimiento del festival', 5),
(15, 'Area Artistica', 'Contratacion y contacto con la prensa', 5);
--
--

CREATE TABLE escenarios (
id INT CONSTRAINT escenarios_pk PRIMARY KEY,
nombre_escenario VARCHAR(20),
capacidad INT,
id_departamento_monta INT,
id_departamento_organiza INT,
CONSTRAINT escenarios_monta_fk FOREIGN KEY (id_departamento_monta)
REFERENCES departamentos (id),
CONSTRAINT escenarios_organiza_fk FOREIGN KEY (id_departamento_organiza)
REFERENCES departamentos (id)  
);
--
INSERT INTO escenarios VALUES (5, 'QuevedoFestSounds', 7000, 10, 15),
(10,'DAW Sonar', 4000, 10, 15);
--
--


CREATE TABLE invitaciones (
    id INT CONSTRAINT invitaciones_pk PRIMARY KEY,
    email VARCHAR(50),
    nombre_invitado VARCHAR(50),
    medio VARCHAR(300),
    id_departamento INT,
    CONSTRAINT invitaciones_departamento_fk FOREIGN KEY (id_departamento)
REFERENCES departamentos (id)
);
--
INSERT INTO invitaciones VALUES (5, 'rollingStone@gmail.com', null, 'Rolling Stone',15),
(10, 'contacto@ruta66.org', null, 'Ruta 66',15),
(15, 'cultura@elpais.com',null,'ElPais',15),
(20,'contacto.cultura.20m@gmail.com',null,'20m',15),
(25,'contactoRockdelux@gmail.com',null,'Rockdeluxe',15),
(30,'contacto@efeeme.org',null,'Efe Eme',15),
(40,'DaniMartinContratacion@gmail.com','Dani Martin',null,15),
(45,'Leiva.contacto@gmail.com','Jose Miguel Conejo, Leiva',null,15),
(50,'Fitogrupo@gmail.com','Adolfo Cabrales, Fito',null,15),
(55,'sfdkgrupo@gmail.com','Saturnino Rey, Zatu',null,15),
(60,'DavidHuertascontacto@gmail.com','Juan David Huertas',null,15),
(70,'zaharaproducciones@gmail.com','Maria Zahara Gordillo',null,5),
(75,'Joaquinmandragora@gmail.com','Joaquin Sabina',null,15),
(80,'IgnatiusFarray@gmail.com','Juan Iganacio Delgado, Ignatius',null,15),
(85,'Albafarelocontacto@gmail.com','Alba Farelo,Bad Gyal',null,15),
(90,'Jeneaispopmusic@gamil.com',null,'Jeneaispop',15),
(95,'BertoRomeroElTerrat@gmail.com','Berto Romero',null,15),
(100,'Queque@ser.es','Hector de Miguel Martinez',null,15),
(105,'ValeriaRos@ser.es','Valeria Ros',null,15);
--
--


CREATE TABLE puestos_de_venta (
id INT CONSTRAINT puestos_de_venta_pk PRIMARY KEY,
marca VARCHAR(20),
numero_de_puestos SMALLINT,
id_departamento INT,
CONSTRAINT puestos_venta_departamentos_fk FOREIGN KEY (id_departamento) REFERENCES departamentos (id)
);
--
INSERT INTO puestos_de_venta VALUES (5,'Telepizza',2,10),
(10,'Brugal',2,10),
(15,'Quevedo Fest',2,10);
--
--


CREATE TABLE balance (
id INT CONSTRAINT balance_pk PRIMARY KEY,
coste NUMERIC,
beneficio NUMERIC,
id_departamento INT,
CONSTRAINT balance_departamento_fk FOREIGN KEY (id_departamento) REFERENCES departamentos (id)
);
--
INSERT INTO balance VALUES 
(5,12000,null,5),(10,50000,null,5),(15,10000,null,5),(20,12000,null,5),(25,20000,null,5),
(30,7000,null,5),(35,3500,null,5),(40,5000,null,5),(45,4500,null,5),(50,7000,null,5),
(55,2500,null,5),(60,3750,null,5),(65,4500,null,5),(70,6000,null,5),(75,10000,null,5),
(80,6700,null,5),(85,3500,null,5),(90,4000,null,5),(95,8000,null,5),(100,15000,null,5),
(105,7500,null,5),(110,6000,null,5),(115,30000,null,5),(120,7000,null,5),(125,null,143836.75,5),
(130,null,44975.7,5),(135,null,354925.2,5),(140,null,33821,5),(145,null,220000,5),
(150,null,30000,5),(155,null,25000,5),(160,null,22000,5),(165,null,6550,5),(170,null,5000,5),
(175,null,4750,5),(180,null,5000,5),(185,null,3350,5),(190,null,25000,5),(195,700,null,5),
(200,700,null,5),(205,500,null,5),(210,500,null,5),(215,500,null,5),(220,500,null,5),
(225,500,null,5),(230,500,null,5),(235,500,null,5),(240,500,null,5),(245,675,null,5),
(250,675,null,5),(255,675,null,5),(260,675,null,5),(265,50,null,5),(270,50,null,5),
(275,40,null,5),(280,40,null,5),(285,40,null,5),(290,40,null,5),(295,40,null,5),
(300,40,null,5),(305,40,null,5),(310,40,null,5),(315,40,null,5),(320,40,null,5),
(325,325,null,5),(330,325,null,5),(335,325,null,5),(340,325,null,5),(345,325,null,5),
(350,325,null,5),(355,325,null,5),(360,325,null,5),(365,325,null,5),
(370,325,null,5),(375,325,null,5),(380,325,null,5),(390,325,null,5),(395,325,null,5),(400,325,null,5),
(405,325,null,5),(410,325,null,5),(415,325,null,5),(420,450,null,5),(425,450,null,5),(430,450,null,5),
(435,450,null,5),(440,450 ,null,5),(445,450,null,5),(450,27000,null,5),(455,47000,null,5),
(460,17000,null,5),(465,50000,null,5),(470,12575,null,5),(480,6000,null,5),(485,12500,null,5),
(490,3000,null,5),(495,7000,null,5),(500,null,22500,5),(505,null,2100,5),(510,null,8400,5),
(515,null,2280,5),(520,null,4080,5),(525,null,1700,5),(530,null,7650,5),(535,null,2700,5),
(540,null,3550,5);
--
--




CREATE TABLE productos (
id INT CONSTRAINT productos_pk PRIMARY KEY,
nombre VARCHAR(20),
precio_venta_unidad NUMERIC,
cantidad INT,
CONSTRAINT balance_productos_fk FOREIGN KEY (id) REFERENCES balance (id)
);
--
INSERT INTO productos VALUES  
(500,'Bebidas alcolicas',9,2500),(505,'Refrescos',3,700),(510,'Cerveza',7,1200),
(515,'Hamburguesas',4,570),(520,'Pizzas',6,680),(525,'Gorras',10,170),
(530,'Camisetas',17,450),(535,'Pulseras',3,900),(540,'Posters',10,355);

CREATE TABLE artista (
id INT CONSTRAINT artista_pk PRIMARY KEY, 
nombre VARCHAR(50),
num_componente SMALLINT,
contacto VARCHAR(50),
telefono_agente VARCHAR(9),
id_departamento_contrata INT,
CONSTRAINT balance_artista_fk FOREIGN KEY (id) REFERENCES balance (id),
CONSTRAINT artista_departamento_contrata_fk FOREIGN KEY (id_departamento_contrata) REFERENCES departamentos (id)
);
--
INSERT INTO artista VALUES  (5,'SFDK',2,'contratacionesdunasshow@gmail.com','678543267',15),
(10,'Blink 182',3,'contacto@kadenza.org','654893267',15),
(15,'Los delincuentes',3,'contratacionesdunasshow@gmail.com','698432356',15),
(20,'L.A.M.O.D.A',7,'TomarBautista@gmail.com','684223356',15),
(25,'La Raiz',11,'Laraizcontacto@gmail.com','689788932',15),
(30,'Kase O',1,'contratacionesdunasshow@gmail.com','678324565',15),
(35,'Veintiuno',4,'AgenciaKamala@gmail.com','687932454',15),
(40,'Extremoduro',4,'contratacionesludezete@gmail.com','689345632',15),
(45,'Cupido',5,'contacto@kadenza.org','634898877',15),
(50,'Ella baila sola',2,'contacto@kadenza.org','678454367',15),
(55,'La polla records',4,'TomarBautista@gmail.com','654324268',15),
(60,'Lendakaris muertos',3,'Lendakarisconciertos@gmail.com','654643456',15),
(65,'Rozalen',1,'RozalenMusic@gmail.com','653454677',15),
(70,'Don Patricio',1,'ContratacionesSyntorama@gmail.com','677890903',15),
(75,'Nator y Wor',2,'Natos@gmail.com','624578682',15),
(80,'La casa azul',5,'ContratacionesLCA@gmail.com','698788802',15),
(85,'Celtas cortos',4,'unaplusocontrataciones@gmail.com','645347898',15),
(90,'Amaral',2,'amaralymario@gmail.com','623412489',15),
(95,'Heroes del silencio',5,'contratacionesdunasshow@gmail.com','666842345',15),
(100,'Vetusta Morla',6,'agenciaKamala@gmail.com','623434723',15),
(105,'Pereza',2,'TomarBautista@gmail.com','622211446',15),
(110,'Ayax y Prok',2,'AyaxyProk.contacto@gmail.com','642344511',15),
(115,'Estopa',2,'Estopa@gmail.com','623244782',15),
(120,'Dellafuente',1,'Dellaconciertos@gmail.com','686734524',15);
--
--

CREATE TABLE entradas (
id INT CONSTRAINT entradas_pk PRIMARY KEY,
precio_por_entrada NUMERIC,
tipo VARCHAR(20),
dias INT,
cantidad_vendida INT,
CONSTRAINT entradas_dias_ck CHECK (dias IN (1,2)),
CONSTRAINT entradas_tipo_ck CHECK (tipo IN ('normal','vip')),
CONSTRAINT entradas_balance_fk FOREIGN KEY (id) REFERENCES balance (id)
);
--
INSERT INTO entradas VALUES (125,24.95,'normal',1,5765),
(130,54.45,'vip',1,826),
(135,44.95,'normal',2,7896),
(140,89.95,'vip',2,376);
--
--

CREATE TABLE publicidad (
id INT CONSTRAINT publicidad_pk PRIMARY KEY,
marca VARCHAR (30),
tipo_patrocinador VARCHAR (30),
CONSTRAINT publicidad_balance_fk FOREIGN KEY (id) REFERENCES balance (id)
);
--
INSERT INTO publicidad VALUES (145,'Telepizza','principal'),
(150,'Twicht','plataforma de stream'),
(155,'Brugal','secundario'),
(160,'Coca Cola','secundario'),
(165,'Red&Bull','secundario'),
(170,'Burguer King','carteles publicitarios'),		
(175,'Repsol','carteles publicitarios'),
(180,'Jonhnie Walker','carteles publicitarios'),
(185,'Vevo LLC','carteles publicitarios'),
(190,'Comunidad de Madrid','publicidad institucional');
--
--

CREATE TABLE alquileres (
id INT CONSTRAINT alquileres_pk PRIMARY KEY,
concepto VARCHAR(50),
CONSTRAINT alquileres_balance_fk FOREIGN KEY (id) REFERENCES balance (id)
);
--
INSERT INTO alquileres VALUES (450,'luces'),(455,'sonido'),(460,'terreno'),(465,'montaje_escenarios'),(470,'montaje_puestos');
--
--

CREATE TABLE empleados (
id INT CONSTRAINT empleados_pk PRIMARY KEY,
nombre VARCHAR(50),
puesto VARCHAR(50),
telefono VARCHAR(9),
id_escenario_trabaja INT,
id_puesto_trabaja INT,
CONSTRAINT empleados_puesto_trabaja_fk FOREIGN KEY (id_puesto_trabaja) REFERENCES puestos_de_venta (id),
CONSTRAINT empleados_escenarios_trabaja_fk FOREIGN KEY (id_escenario_trabaja) REFERENCES escenarios (id)
);
INSERT INTO empleados VALUES (195,'Carlos Serrano López','Jefe seguridad','678346575',5,null),
(200,'Sara Garrido Pérez','Jefe seguridad','623478533',10,null),
(205,'Alberto Pérez Sotillo','seguridad','623343472',10,null),
(210,'Andrés Caseiro Coto','seguridad','678877733',10,null),
(215,'Álvaro Rodríguez Arevalillo','seguridad','642323456',10,null),
(220,'Carmen Serrador Ibáñez','seguridad','643542335',10,null),
(225,'Álvaro Ibáñez Aizpum','seguridad','678999332',5,null),
(230,'Carlos Garrido Oleart','seguridad','645238793',5,null),
(235,'Olivier Prego Colet','seguridad','678764543',5,null),
(240,'Pedro Torres López','seguridad','623423548',5,null),
(245,'Ana Torrijos Labrador','tecnico','623452358',5,null),
(250,'Abel Porto Porto','tecnico','624532358',5,null),
(255,'Mario Herrero Rodríguez','tecnico','613867564',10,null),
(260,'Maria Luisa Rivero Ordóñez','tecnico','687675456',10,null),
(265,'Luis Ferro Serrano','Organizador voluntariado','676745653',10,null),
(270,'Alfredo Pérez Cobos','Organizador voluntariado','634546743',5,null),
(275,'Pedro Bouzas Iglesias','voluntario','634543589',10,null),
(280,'Juan Guarnizo Ayuso','voluntario','669934567',10,null),
(285,'David Delgado Huertas','voluntario','613867665',10,null),
(290,'Daniel Bouzas Iglesias','voluntario','625345231',10,null),
(295,'Andrés López López','voluntario','611344673',10,null),
(300,'Sandra Gil Marín','voluntario','677345221',5,null),
(305,'Carlota Marín Garrido','voluntario','688787983',5,null),
(310,'Álvaro Montero Herrero','voluntario','657684563',5,null),
(315,'Judith Rodas Alfonso','voluntario','686546728',5,null),
(320,'Ismael Galán Álvaro','voluntario','673456424',5,null),
(325,'Irene Zurita Torres','vendedor','658752686',null,15),
(330,'Javier Padilla Montero','vendedor','623423587',null,15),
(335,'Oscar Anton Anton','vendedor','611456778',null,15),
(340,'Jesus Auseron Usero','vendedor','689900853',null,10),
(345,'Pablo García Caseiro','vendedor','600784532',null,10),
(350,'Manuel Daza Regidor','vendedor','623456000',null,10),
(355,'Alexis Donato Hidalgo','vendedor','634534589',null,5),
(360,'Juan Luis Nevado Serano','vendedor','677890034',null,5),
(365,'Alejandro de Llano de Nicolas','vendedor','645232068',null,5),
(370,'Layla Martínez Rosa','vendedor','678832346',null,5),
(375,'Iván Fernández Delgado','vendedor','687894323',null,15),
(380,'Andrés Maeso Cano','vendedor','628943739',null,15),
(390,'Rodrigo Pascual Madrigal','vendedor','635442780',null,10),
(395,'Ricardo Royo Villanueva','vendedor','600846735',null,10),
(400,'Juan Correllano Serrat','vendedor','698980454',null,10),
(405,'Joan Pérez Frias','vendedor','668795322',null,5),
(410,'Javier Cuesta','vendedor','687980034',null,5),
(415,'Manuel Padilla Díaz','vendedor','687090342',null,5),
(420,'Cristina Sánchez Mato','Jefe puesto de venta','676575221',null,5),
(425,'Federico Quesada Herzog','Jefe puesto de venta','645436577',null,5),
(430,'Baltasar Monasterio Campazzo','Jefe puesto de venta','654345234',null,10),
(435,'Sofía Rincon Martin','Jefe puesto de venta','623434378',null,10),
(440,'Miguel Dieguez Quintana','Jefe puesto de venta','634143414',null,15),
(445,'Javier Majan Donato','Jefe puesto de venta','687878325',null,15);


CREATE TABLE asuntos_legales (
id INT CONSTRAINT asuntos_legales_pk PRIMARY KEY,
nombre VARCHAR(50),
bufete VARCHAR(50),
especialidad VARCHAR (50),
telefono VARCHAR(9),
id_departamento_asesora INT,
CONSTRAINT asuntos_legales_asesora_departamento_fk FOREIGN KEY (id_departamento_asesora) REFERENCES departamentos (id),
CONSTRAINT asuntos_legales_balance_fk FOREIGN KEY (id) REFERENCES balance (id) 
);
INSERT INTO asuntos_legales VALUES (480,'Irantzu Varela Moreno','Arriaga&Asociados','Derecho laboral','634534523',5),
(485,'Juan Carlos Soto Rallo','Pelaez Rodriguez','Contratación de artistas','634523421',15),
(490,'Juan Ramonet Marsa','Legalitas','Permisos publicos','608978093',10),
(495,'Diego Ferran Nevado','Garrigues','Derecho Administrativo','686732134',10);

CREATE TABLE actuaciones (
id_escenario INT,
id_artista INT,
dia SMALLINT,
hora TIME,
CONSTRAINT actuaciones_pk PRIMARY KEY (id_escenario, id_artista), 
CONSTRAINT actuaciones_dias_ck CHECK (dia IN (1,2)),
CONSTRAINT actuaciones_escenarios_fk FOREIGN KEY (id_escenario) REFERENCES escenarios (id),
CONSTRAINT actuaciones_artista_fk FOREIGN KEY (id_artista) REFERENCES artista (id)
);
--
INSERT INTO actuaciones VALUES (5,60,1,'18:00:00'),(5,55,1,'19:30:00'),(5,50,1,'21:00:00'),(5,120,1,'22:30:00'),(5,115,1,'00:00:00'),(5,110,1,'01:30:00'),(5,20,2,'18:00:00'),(5,25,2,'19:30:00'),(5,30,2,'21:00:00'),(5,65,2,'22:30:00'),(5,70,2,'00:00:00'),(5,75,2,'01:30:00'),(10,45,1,'18:00:00'),(10,40,1,'19:30:00'),(10,35,1,'21:00:00'),(10,90,1,'22:30:00'),(10,85,1,'00:00:00'),(10,80,1,'01:30:00'),(10,5,2,'18:00:00'),(10,10,2,'19:30:00'),(10,15,2,'21:00:00'),(10,105,2,'22:30:00'),(10,95,2,'00:00:00'),(10,100,2,'01:30:00');
--
--

CREATE TABLE puesto_vende_productos (
    id_puesto INT,
    id_producto INT,
    CONSTRAINT puesto_vende_productos_pk PRIMARY KEY (id_puesto, id_producto),
    CONSTRAINT puesto_venta_fk FOREIGN KEY (id_puesto) REFERENCES puestos_de_venta (id),
    CONSTRAINT producto_venta_fk FOREIGN KEY (id_producto) REFERENCES productos (id)
);

INSERT INTO puesto_vende_productos VALUES (5,505),(5,510),(5,515),(5,520),(10,500),(10,505),(10,510),(15,525),(15,530),(15,535),(15,540);

