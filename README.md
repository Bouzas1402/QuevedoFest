# QuevedoFest

- [ ] 1. Introducción
- [x] 2. Modelo Conceptual
   - [x] 2.1. Especificaciones
   - [x] 2.2. Diagrama Entidad-Relación
- [x] 3. Modelo Lógico 
   - [x] 3.1. Modelo Relacional
   - [x] 3.2. Normalización/Desnormalización
- [x] 4. Modelo Físico
   - [x] 4.1. Diagrama de base de datos (notación "Crow's feet" o IDEF1X)
   - [x] 4.2. Creación de tablas y otros objetos
   - [x] 4.3. Carga de datos de prueba
- [x] 5. Consultas de la base de datos
   - [x] 5.1. Consultas más frecuentes
   - [x] 5.2. Consultas sencillas
   - [x] 5.3. Consultas de agregación y resumen
   - [x] 5.4. Consultas con subconsultas
- [ ] 6. Vistas, secuencias e índices
- [ ] 7. Scripts en PL/pgSQL
- [ ] 8. Extras
   - [ ] 8.1. Cursores
   - [ ] 8.2. Prototipo de interfaz de usuario
   - [ ] 8.3. Plan de pruebas
   - [x] 8.4. Especificaciones de pruebas en [formato features Gherkin (ver ejemplo)](features/admin-carteles.feature) 
   - [ ] 8.5. Diagrama de clases
   - [ ] 8.6. Ejemplo de acceso a la base de datos con Java y JDBC

[link img]: https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/img%20Diagrama%20entidad%20relacion/QuevedoFest.png
[link img2]: https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/img%20Diagrama%20Crow%C2%B4s%20feet/crow%C2%B4s%20feet.png

   ## 1. Introducción:

---

   ## 2. Modelo Conceptual:
    - 2.1 Especificaciones:

         Se quiere hacer una base de datos para organizar el festival de musica QuevedoFest, queremos guardar la ubicacion 
         la capacidad y la pagina web del festival. 
         
         El festival esta organizado por tres departamentos distintos que se encargan del area financiera ,area organizativa 
         y area artistica.

         El departamento que se encarga de la parte artistica contrata a los artistas que actuaran en el festival y de enviar 
         las invitaciones a los medios y parsonas famosas y de organizar los escenarios.

         De los artistas queremos saber su nombre (o nombre del grupo), el numero de componentes, la forma de contacto y el 
         numero de telefono del agente.

         De las invitaciones quiero guardar un id y un email de contacto donde enviar las invitaciones, las invitaciones pueden 
         ser a personas vip o a medios que queremos que cubran el festival, de las personas vip queremos guardar el nombre de 
         las invitaciones de prensa el medio de comunicacion al que se lo enviamos ya que no es una invitacion personal.

         El departamento que se encarga del area organizativa controla el montaje y mantenimiento de los escenarios y los puestos 
         de venta de el festival, de los escenarios guardaremos el nombre y la capacidad, de los puestos de venta la marca que 
         patrocina el puesto de venta y el numero de puestos que patrocina cada marca, ya que los productos que se vendan en los 
         puestos dependera de la marca que lo patrocine.

         El departamento que se encarga de la parte financiera lleva un balance que registra de los gastos y los ingresos, en los 
         gastos registraremos el gasto que supone la contratacion de artistas, los alquileres, la contratacion de los empleados y 
         la contratación
         de la asesoria legal del festival. En los ingresos llevaremos la cuenta de los beneficios que nos proporcionara el festival
         en cuestion de los productos que vendamos en los puestos de venta,  las entradas vendidas y los contratos publicitarios y 
         los sponsor del festival.

         De los alquileres guardaremos el concepto por el que hacemos el alquiler que sera el objeto alquilado.
         
         De los asuntos legales el nombre, el bufete al que pertenece la especialidad legal que tiene y un telefono de contacto, 
         ademas cada miembro contratado asesorara a distintos departamentos en funcion de su especialidad legal y las necesidades 
         del departamento.
         
         Los empleados trabajaran en alguno de los escenarios o en algunos de los puestos de venta del festival, ademas guardaremos 
         el nombre, el puesto y un telefono. Algunos empleados son voluntarios, que no cobran, pero si se les de una retribucion por
         desplazamiento y otros conceptos.

         Los productos se venderan en los puestos de venta y guardaremos el precio de venta por unidad, la cantidad vendida y 
         el nombre del producto. 

         De las entradas guardaremos el precio de venta por entrada, el tipo de entrada que podra ser vip o normal, la cantidad 
         de entradas vendidas y si es una entrada para 1 solo dia o para 2.

         De los sponsor y la publicidad la marca que se publicita y el tipo de publicidad contratada.

         Los artistas actuaran en los escenarios y se quiere guardar la hora en la que actua cada artista en cada escenario.

         Todas las entidades llevaran un id identificativo.


     - 2.2 Diagrama entidad relación:


![Diagrama entidad relación]([link img])

---
   
## 3.Modelo logico
     - 3.1. Modelo relacional:
     - 3.2. Normalización/Desnormalización:

 QUEVEDOFEST (***id_quevedofest***(pk), nombre, ubiación, web)
 
 DEPARTAMENTOS (***id_departamentos***(pk), nombre, competencias, _id_quevedofest_(fk))

INVITACIONES (***id_invitacion***(pk), email, nombre, medio, _id_departamentos_(fk))

ESCENARIOS (***id_escenario***(pk), nombre_escenario, capacidad, _id_departamento_monta_(fk), _id_departamento_organiza_(fk))

ALQUILERES (***id_balance***(pk), nombre, concepto)

PUESTOS_DE_VENTA (***id_puesto***(pk), marca, numero_de_puestos, _id_departamento_(fk))

BALANCE (***id_balance***(pk), beneficio, coste, _id_departamentos_(pk))

PRODUCTOS (***id_balance***(pk), nombre, cantidad, precio_venta_unidad)

BALANCE_ARTISTAS (***id_balance***(pk), nombre, num_componente, teléfono_agente, contacto, _id_departamento_contrata_(fk))

BALANCE_ENTRADAS (***id_balance***(FK), precio_por_entrada, tipo,  días, cantidad_vendida)

PRODUCTO_VENTA_PUESTOS (***id_puesto_venta***(pk)(fk), ***id_balance_producto***(pk)(fk)) [^1]

BALANCE_PUBLICIDAD_SPONSO (***id_balance***(pk), marca, tipo_patrocinador)

BALANCE_ALQUILERES (***id_balance***(pk), concepto)

BALANCE_EMPLEADOS(***id_balance***(pk), nombre, teléfono, puesto, _id_escenario_(fk), _id_puesto_(fk)) [^2]

ASUNTOS_LEGALES (***id_balance***(pk), nombre, bufete, teléfono, especialidad_legal, _id_departamento_(fk))

ACTUACIONES (***id_escenario***(pk)(fk), ***id_artista***(pk)(fk), dia, hora)

[^1]: Hemos hecho una tabla de la relación entre productos y puestos de venta donde daremos cuenta de que tipo de productos venden en cada puesto.

[^2]: De la relacion terciaria entre empleados y puesto de ventas y escenarios hemos decidido no hacer una tabla transportar las claves de escenario y de puestos a la tabla empleado, aunque provoca valores nulos creemos que es mas comodo. 

---

## 4.Modelo fisico:
    - 4.1. Diagrama de base de datos (notación "Crow's feet" o IDEF1X)
   ![Diagrama entidad relación]([link img2])
   
    - 4.2. Creación de tablas y otros objetos:
   [Archivo sql de la base de datos](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/Base%20de%20datos%2C%20archivo%20sql/QuevedoFest2.sql)

     - 4.3. Carga de datos de prueba:
   [Archivo sql de la base de datos](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/Base%20de%20datos%2C%20archivo%20sql/QuevedoFest2.sql)

---

## 5.Consultas de la base de datos

    - 5.1. Consultas más frecuentes:
Los empleados, su puesto y en que escenario trabaja:
```sql
SELECT e.id, e.nombre, e.puesto, es.nombre_escenario
FROM empleados e 
JOIN escenarios es ON e.id_escenario_trabaja = es.id
ORDER BY es.nombre_escenario;
```
Los empleados, su puesto y para que marca trabajan en los puestos
```sql
SELECT e.id, e.nombre, e.puesto, p.marca
FROM empleados e 
JOIN puestos_de_venta p ON e.id_puesto_trabaja = p.id
ORDER BY p.marca;
```    
El balance total de ingresos y gastos del festival:
```sql
Select SUM(beneficio) AS Ingresos, SUM(coste) AS Gastos, (SUM(beneficio) - SUM(coste)) AS "Beneficio total" FROM balance;
```
Los nombre de los artistas donde y a que hora tocan:
```sql
SELECT e.nombre_escenario, a.nombre, ac.dia, ac.hora
FROM escenarios e
JOIN actuaciones ac ON ac.id_escenario = e.id
JOIN artista a ON a.id = ac.id_artista;
```
Cuanto cobra cada empleado por puesto:
```sql
SELECT DISTINCT e.puesto, b.coste AS salario
FROM empleados e 
JOIN balance b ON b.id = e.id; 
```
Cuantos empleados trabajan en cada puesto por marca: 
```sql
SELECT p.marca, COUNT(e.*) 
FROM empleados e 
JOIN puestos_de_venta p ON e.id_puesto_trabaja = p.id
ORDER BY p.marca;
```
Cuantos empleados trabajan por escenario y en que puesto:
```sql
SELECT es.nombre_escenario, COUNT(e.*)
FROM empleados e
JOIN escenarios es ON es.id = e.id_escenario_trabaja
GROUP BY es.nombre_escenario;
```

    - 5.2 Consultas sencillas:
Nombre, id y numero de los empleados:
```sql
SELECT e.id, e.nombre, e.telefono FROM empleados e;
```
Toda la informacion de asuntos legales:
```sql
SELECT * FROM asuntos_legales;
```
Medios invitados al festival:
```sql
SELECT id, medio, email  FROM invitaciones WHERE medio IS NOT NULL;
```
Famosos invitados al festival:
```sql
SELECT id, nombre_invitado, email FROM invitaciones WHERE nombre_invitado IS NOT NULL;
```
Productos que se venden en el festival:
```sql
SELECT id, nombre, precio_venta_unidad, cantidad AS "cantidad vendida" FROM productos;
```
Id, nombre y numero de componentes de los artistas que trabajan en el festival:
```sql
SELECT id, nombre, num_componente FROM artista;
```
Entradas vendidas:
```sql
SELECT * FROM entradas; 
```
Sponsors del festival:
```sql
SELECT * FROM publicidad;
``` 
Los escenarios el festival:
```sql
SELECT id, nombre_escenario, capacidad FROM escenarios;
```
Los puestos de venta del festival:
```sql
SELECT id,marca, numero_de_puestos FROM puestos_de_venta;
```
Voluntarios del festival:
```sql
Select e.nombre FROM empleados e WHERE puesto ilike 'voluntario' OR puesto ilike 'Organizador voluntariado';
``` 
Lo que cobran y el total de la contratacion de artistas
```sql
SELECT a.nombre, b.coste FROM artista a
JOIN balance b ON a.id = b.id;
```

       - 5.3. Consultas de agregacion y resumen:
Cuantos empleados hay en cada puesto
```sql
SELECT puesto, COUNT(*) FROM empleados GROUP BY puesto;
```
Cuantos empleados trabajan en cada escenario:
```sql
Select es.nombre_escenario, Count(e.*) 
FROM empleados e 
JOIN  escenarios es ON es.id = e.id_escenario_trabaja 
GROUP BY es.nombre_escenario 
Order BY nombre_escenario DESC;
```
Cuantos empleados trabajan para cada marca:
```sql
Select  p.marca, COUNT(e.nombre) 
FROM empleados e 
JOIN  puestos_de_venta p ON p.id = e.id_puesto_trabaja 
GROUP BY p.marca 
Order BY p.marca DESC;
```
La suma de los sueldos por puestos y el total de los puestos
```sql
Select e.puesto, SUM(b.coste) AS salarios 
from empleados e 
JOIN balance b ON b.id = e.id 
GROUP by ROLLUP (e.puesto) 
ORDER BY e.puesto;
```
Total de productos vendidos en los puestros de venta:
```sql
SELECT SUM(p.cantidad), SUM(b.beneficio) FROM productos p
JOIN balance b ON b.id = p.id;
```
El coste en salarios por puestos en todos los escenarios y en los escenarios por separado:
```sql
Select es.nombre_escenario, e.puesto, COUNT(e.nombre), SUM(b.coste) AS "coste en salarios"
FROM empleados e
JOIN  escenarios es ON es.id = e.id_escenario_trabaja
JOIN balance b ON b.id = e.id
GROUP BY GROUPING SETS ((es.nombre_escenario, e.puesto), (e.puesto))
ORDER BY es.nombre_escenario, e.puesto;
```
El coste en salarios por puestos en todos los puestos de venta y en los puestos de venta por separado:
```sql
Select p.marca, e.puesto, COUNT(e.nombre),SUM(b.coste) AS "coste en salarios"
FROM empleados e
JOIN  puestos_de_venta p ON p.id = e.id_puesto_trabaja
JOIN balance b ON b.id = e.id
GROUP BY GROUPING SETS ((p.marca, e.puesto), (e.puesto))
ORDER BY p.marca, e.puesto;
```

## 6.Vistas, secuencias e índices

Vista para ver los sueldos de los empleados:
```sql
CREATE OR REPLACE VIEW nominas AS
SELECT e.nombre, b.coste FROM empleados e JOIN balance b ON b.id = e.id CREATE VIEW;
```
Secuencia que lleva el valor de id balance:
```sql
CREATE SEQUENCE nuevoBalance
AS INT
INCREMENT 5
START 540;
```
Introducimos 3 empleados de seguridad mas al escenario QuevedoFest usando para la id en la tabla empleados y su registro correspondiente en balance la secuencia nuevoBalance:
```sql
INSERT INTO empleados VALUES (nextval('nuevoBalance'), 'Pedro Rodrigues Fuentes', 'seguridad', '600329312',5, null);
INSERT INTO balance VALUES (currval('nuevoBalance'), 500, null, 5);
INSERT INTO empleados VALUES (nextval('nuevoBalance'), 'Ana Vera Roma', 'seguridad', '692326712',5, null);
INSERT INTO balance VALUES (currval('nuevoBalance'), 500, null, 5);
INSERT INTO empleados VALUES (nextval('nuevoBalance'), 'Jose Antonio Casto Porro', 'seguridad', '678453545',5, null);
INSERT INTO balance VALUES (currval('nuevoBalance'), 500, null, 5);
```
