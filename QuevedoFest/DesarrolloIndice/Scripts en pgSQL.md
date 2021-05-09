
##  7. Scripts en PL/pgSQL
---

Procedimeinto que muestra toda la informacion de todos los empleados:
```sql
create or replace procedure empleados ()
language plpgsql
as
$$
declare
v_id integer := 195;
v_empleado empleados%rowtype;
v_contador INTEGER := 0;
v_num_empleados Integer;
v_salario numeric;
begin
	select coste
	into v_salario
	from balance
	where id = v_id;
	select COUNT(*) 
into v_num_empleados 
	from empleados;
select *
into v_empleado
from empleados
where id = v_id;
while v_contador <= v_num_empleados 
loop
if v_empleado.puesto is null then
else
v_contador = v_contador + 1;
raise notice 'Empleado con id % : \n %, puesto: %,\n telefono: %, salario: %',
v_id,
v_empleado.nombre,
v_empleado.puesto,
v_empleado.telefono,
v_salario ;
end if;
select *
into v_empleado
from empleados
where id = v_id;
select coste
	into v_salario
	from balance
	where id = v_id;
v_id := v_id + 5;
end loop;
end;
$$
;
```
Funcion en la que introduces el id de un escenario y devuelve el numero de empleados que hay en el.
 ```sql
 create or replace function get_num_empleados_escenarios (p_id int)
 returns int
 language plpgsql
 as
 $$
 declare
 v_num_empleados integer;
 begin
 if p_id = 5 or p_id = 10 then
 SELECT COUNT(e.*)
 into v_num_empleados
 from empleados e 
 JOIN escenarios es 
 ON es.id = e.id_escenario_trabaja
 WHERE e.id_escenario_trabaja = p_id;
 return v_num_empleados;
 else 
 raise notice 'El id del escenario es incorrecto';
 return 0;
 end if;
 end;
 $$
 ```
 Funcion en la que introduces la marca de un puesto y te dice cuantos empleados tiene:
```sql
  create or replace function get_num_empleados_puesto (p_marca puestos_de_venta.marca%type)
 returns puestos_de_venta.marca%type
 language plpgsql
 as
 $$
 declare
 v_num_empleados int;
 v_marca puestos_de_venta.marca%type;
 begin
 SELECT COUNT(e.*)
 into v_num_empleados
 from empleados e 
 JOIN puestos_de_venta p 
 ON p.id = e.id_puesto_trabaja
 WHERE p.marca ilike p_marca;
 return v_num_empleados;
 end;
 $$
 ```
Procedimiento en el que introduces el nombre de un grupo y te dice en que escenario que dia y a que hora actua:
 ```sql
 create or replace procedure actuacion (p_grupo artista.nombre%type)
language plpgsql
 as
 $$
 declare
 v_diahora record;
 v_artista artista.nombre%type;
 v_nombre_escenario escenarios.nombre_escenario%type;
 begin
 --
 SELECT nombre 
 into v_artista
 FROM artista
 WHERE nombre ilike p_grupo;
 --
 SELECT ac.dia, ac.hora 
 into v_diahora
 FROM actuaciones ac 
 JOIN artista a ON ac.id_artista = a.id
 WHERE a.nombre ilike p_grupo;
 --
 SELECT es.nombre_escenario
 into v_nombre_escenario
 FROM escenarios es
 JOIN  actuaciones ac ON es.id = ac.id_escenario
 JOIN artista a ON a.id = ac.id_artista
 WHERE a.nombre ilike p_grupo;
 --
 raise notice '% actua en el escenario % el dia % a las % horas',
 v_artista,
 v_nombre_escenario,
 v_diahora.dia,
 v_diahora.hora;
 end;
 $$;
 ```


