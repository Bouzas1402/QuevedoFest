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