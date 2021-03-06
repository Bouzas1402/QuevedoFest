
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
 Procedimiento para cambiar de escenario a un trabajador:
 ```sql
 create or replace procedure cambiar_escenario (
     p_id_empleado empleados.id%type   
 )
 language plpgsql
 as
 $$
 declare
 v_id_escenario empleados.id_escenario_trabaja%type;
 v_empleado empleados.id%type;
--
begin
Select id 
into v_empleado
FROM empleados
WHERE id = p_id_empleado;
 if not found then
 raise notice 'No existe el empleado';
 end if;
 --
Select id_escenario_trabaja
into v_id_escenario
FROM empleados
WHERE id = p_id_empleado; 
if found then
case v_id_escenario
when 5 then
 update empleados 
 set id_escenario_trabaja = 10
 Where id = p_id_empleado;
 commit;
when 10 then
 update empleados 
 set id_escenario_trabaja = 5
 Where id = p_id_empleado;
 commit;
end case;
end if;
 end;
 $$;
 ```
Procedimiento para cambiar de puesto a un empleado:
```sql
 create or replace procedure cambiar_puesto (
     p_id_empleado empleados.id%type,
     p_marca puestos_de_venta.marca%type
 )
 language plpgsql
 as
 $$
 declare
 v_marca puestos_de_venta.marca%type;
 v_id empleados.id%type;
 v_id_puesto puestos_de_venta.id%type;
 begin
SELECT id FROM empleados
into v_id
WHERE id = p_id_empleado;
if not found then
raise notice 'El empleado % no existe', p_id_empleado;
end if;
--
SELECT id FROM puestos_de_venta
into v_id_puesto
WHERE marca ilike p_marca;
--
update empleados
SET id_puesto_trabaja = v_id_puesto
WHERE id = p_id_empleado;
commit;
  exception       
      when others then
         raise exception 'Se ha producido en un error inesperado';
 end;
 $$;
 ```
 Procedimiento para cambiar de horario de una actuaci??n entroduciendo un id de artista, un hora, un dia, y un id de escenario, se cambiara al antiguo horario la actuacion que habia en el horario que hemos cambiado:
```sql
create or replace procedure cambiar_actuacion (
    p_id_artista actuaciones.id_artista%type,
    p_hora actuaciones.hora%type,
p_dia actuaciones.dia%type,
p_id_escenario actuaciones.id_escenario%type
)  
language plpgsql
as
$$
declare
v_hora_dia_antiguo record;
v_dia_hora_antiguo2 record;
begin
perform id 
from artista
where id = p_id_artista; 
--
perform hora,dia
from actuaciones
where dia = p_dia and hora = p_hora;
--
Select *
into v_hora_dia_antiguo
from actuaciones 
WHERE id_artista = p_id_artista;
--
select * 
into v_dia_hora_antiguo2 
from actuaciones
where hora = p_hora and dia = p_dia;
--
delete from actuaciones where id_artista = v_hora_dia_antiguo.id_artista;
delete from actuaciones where id_artista = v_dia_hora_antiguo2.id_artista;
insert into actuaciones values (v_dia_hora_antiguo2.id_escenario,v_hora_dia_antiguo.id_artista,v_dia_hora_antiguo2.dia,v_dia_hora_antiguo2.hora);
insert into actuaciones values (v_hora_dia_antiguo.id_escenario,v_dia_hora_antiguo2.id_artista,v_hora_dia_antiguo.dia,v_hora_dia_antiguo.hora);

 exception
      when no_data_found then 
        raise notice 'El artista % no existe', p_id_artista;
     when others then
        raise exception 'Se ha producido en un error inesperado'; 
end;
$$;
```
Procedimiento para meter un id y ver el coste o el beneficio (si es coste saldra con - delante):
```sql
create or replace procedure gasto (p_id balance.id%type)
language plpgsql
as
$$
declare
v_fila_balance balance%rowtype;
begin
select *
into v_fila_balance
from balance
where id = p_id;
if not found then
raise notice 'No existe la entrada % en el balance', p_id;
end if;
--
if (v_fila_balance.coste is null) then
raise notice 'El beneficio de la entrada % es: %', p_id, v_fila_balance.beneficio;
else  
raise notice 'El coste de la entrada % es: -%', p_id, v_fila_balance.coste;
end if;
 exception
      when no_data_found then 
raise notice 'La entrada % no esta en el balance', p_id;     when others then
        raise exception 'Se ha producido en un error inesperado'; 
end;
$$;
```
Prodedimiento para sacar un informe detallado de gastos y beneficios:
```sql
create or replace procedure balance_detallado ()
language plpgsql
as
$$
declare
v_beneficio_publicidad balance.beneficio%type;
v_beneficio_entradas balance.beneficio%type;
v_beneficio_productos balance.beneficio%type;
--
v_coste_artistas balance.coste%type;
v_coste_abogados balance.coste%type;
v_coste_empleados balance.coste%type;
v_coste_alquileres balance.coste%type;
--
v_coste_total balance.coste%type;
v_beneficio_total balance.beneficio%type;
v_total balance.coste%type;
begin
select sum(b.beneficio) 
into v_beneficio_publicidad
from balance b JOIN publicidad p ON p.id = b.id;
--
select sum(b.beneficio)
into v_beneficio_entradas
from balance b JOIN entradas e ON e.id = b.id;
--
select sum(b.beneficio)
into v_beneficio_productos
from balance b JOIN productos p ON b.id = p.id;
--
select sum(b.coste)
into v_coste_artistas
from balance b 
JOIN artista a ON a.id = b.id;
--
select sum(b.coste) 
into v_coste_abogados a
from balance b JOIN asuntos_legales a ON a.id = b.id;
--
select sum(b.coste)
into v_coste_empleados 
from balance b JOIN empleados e ON e.id = b.id;
--
select sum(b.coste)
into v_coste_alquileres 
from balance b JOIN alquileres a ON a.id = b.id;
--
raise notice 'El beneficio de los contratos de publicidad es: %', v_beneficio_publicidad;
raise notice 'El beneficio por la venta de entradas es:       %', v_beneficio_entradas;
raise notice 'El beneficio por la venta de productos es:      %', v_beneficio_productos;
v_beneficio_total := v_beneficio_publicidad + v_beneficio_entradas + v_beneficio_productos;
raise notice 'El beneficio total del festival es:             %', v_beneficio_total;
raise notice '**********************************************************************';
--
raise notice 'El gasto en artistas es:                       -%', v_coste_artistas;
raise notice 'El gasto en abogados es:                       -%', v_coste_abogados;
raise notice 'El gasto en empleados es:                      -%', v_coste_empleados;
raise notice 'El gasto de alquileres es:                     -%', v_coste_alquileres;
v_coste_total := v_coste_artistas + v_coste_abogados + v_coste_empleados + v_coste_alquileres;
raise notice 'El coste     total del festival es:            -%', v_coste_total;
raise notice '**********************************************************************';
v_total := v_beneficio_total - v_coste_total;
raise notice 'El beneficio del festival despues de gastos es: %', v_total;
end;
$$;
```

