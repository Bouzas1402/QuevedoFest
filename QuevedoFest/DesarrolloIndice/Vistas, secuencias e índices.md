## 6.Vistas, secuencias e índices
Vista para ver el total de los ingresos y gastos:
```sql
create or replace view ingresosygastos AS
select SUM(beneficio) AS Ingresos, SUM(coste) AS Gastos, (SUM(beneficio) - SUM(coste)) AS "Beneficio total" FROM balance;
```
Vista para ver lo que cobra cada empleado por puesto
 ```sql
create or replace view salario_por_puesto AS 
SELECT distinct e.puesto, b.coste AS salario
FROM empleados e
JOIN balance b ON b.id = e.id;
 ```
Vista para ver los sueldos de los empleados:
```sql
CREATE OR REPLACE VIEW nominas AS
SELECT e.nombre, e.puesto, b.coste FROM empleados e JOIN balance b ON b.id = e.id CREATE VIEW;
```
Vista para ver el horario y actuaciones del festival
```sql
create or replace view cartel_festival as
select e.nombre_escenario, a.nombre, ac.dia, ac.hora
from escenarios e
join actuaciones ac on ac.id_escenario = e.id 
join artista a on a.id = ac.id_artista;
```
Secuencia que lleva la cuenta del id que comparten las tablas empleados, productos, artistas, asuntos legales, alquileres, publicidad y entradas
con balance:
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
Indices para acceder a los costes y beneficios de la tabla balance:
```sql
CREATE INDEX balance_coste_ix ON balance(coste);
CREATE INDEX balance_beneficio_ix ON balance(beneficio);
```
Indice para acceder a los nombres de los empleados:
```sql
CREATE INDEX nombre_empleados_ix ON empleados(nombre);
```

