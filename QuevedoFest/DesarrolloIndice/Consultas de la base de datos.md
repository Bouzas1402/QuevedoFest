
## 5.Consultas de la base de datos
---

#### 5.1. Consultas más frecuentes:
   
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
Mostrar los alquileres:
```sql
SELECT * FROM alquileres;
```
---

#### 5.2 Consultas sencillas:


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

---
#### 5.3. Consultas de agregacion y resumen:

Invitaciones enviadas mostrando el nombre si es alguien famoso o indicando que es un medio de comunicacion:
```sql
SELECT id, email, coalesce(nombre_invitado, 'medio de comunicacion') AS "nombre invitado" FROM invitaciones;
```
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
Trabajadores que no son voluntarios, que por tanto cobran mas de 50 euros:
```sql
SELECT e.puesto, COUNT(e.*) AS "numero de empleado", b.coste AS salario
FROM empleados e 
JOIN balance b ON b.id = e.id 
GROUP BY e.puesto, b.coste 
HAVING coste > 50;
```
---
#### 5.4. Consultas con subconsultas:
Cual es el grupo que mas cobra:
```sql
SELECT a.id, a.nombre, b.coste 
FROM artista a
JOIN balance b ON b.id = a.id
WHERE b.coste = (SELECT MAX(coste) FROM balance WHERE b.id = a.id);
```
Capacidad total del festival, sumando los dos escenarios:
```sql
SELECT q.nombre AS Festival, SUM(e.capacidad) FROM QuevedoFest q
JOIN departamentos d ON d.id_quevedofest = q.id
JOIN escenarios e ON e.id_departamento_organiza = d.id
GROUP BY q.nombre;
```
