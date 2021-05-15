## 8.Extras
# 8.1 Cursores:
Procedimiento para saber quien toca y donde entre dos intervalos de horas 1 dia en concreto:
```sql
create or replace procedure actuaciones_intervalo_hora (
    p_hora1 actuaciones.hora%type,
    p_hora2 actuaciones.hora%type,
    p_dia actuaciones.dia%type
)
language plpgsql
as
$$
declare
v_actuacion actuaciones%rowtype;
v_nombre_artista artista.nombre%type;
v_nombre_escenario escenarios.nombre_escenario%type;
cur_actuaciones cursor ( p_hora_inicio actuaciones.hora%type, p_hora_fin actuaciones.hora%type, p_dia2 actuaciones.dia%type ) for
select * from actuaciones where (hora >= p_hora_inicio and hora <= p_hora_fin) or (hora >= p_hora_inicio or hora <= '02:00:00') and dia = p_dia2 order by id_escenario,hora asc;
begin
--
open cur_actuaciones(p_hora1, p_hora2, p_dia);
fetch cur_actuaciones into v_actuacion;
while (found) loop
--
select nombre
into v_nombre_artista
from artista 
where id = v_actuacion.id_artista;
--
select nombre_escenario
into v_nombre_escenario
from escenarios
where id = v_actuacion.id_escenario;
--
raise notice '% toca en % el dia % a las % horas.', v_nombre_artista, v_nombre_escenario, v_actuacion.dia, v_actuacion.hora;
fetch cur_actuaciones into v_actuacion;
end loop;
close cur_actuaciones;
exception
when no_data_found then 
        raise notice 'El empleado % no existe', p_id_artista;
   when others then
     raise exception 'Se ha producido un error inesperado';
end;
$$;
```
Procedimiento con cursores para ver los trabajadores
```sql
create or replace procedure trabajadores ()
language plpgsql
as
$$
declare
v_numero_empleados int;
v_empleado record;
cur_empleado_puestos cursor for 
select id,nombre,puesto,telefono from empleados
WHERE id_puesto_trabaja IS NOT NULL;
--
cur_empleado_escenarios cursor for 
select id,nombre,puesto,telefono from empleados
WHERE id_escenario_trabaja IS NOT NULL;
--
begin
raise notice '\n EMPLEADOS QUE TRABAJAN EN PUESTOS DE VENTA: ';
v_numero_empleados := 0;
for v_empleado in cur_empleado_puestos LOOP
raise notice 'El empleado con id: %, nombre: %, telefono: % y puesto: %', 
v_empleado.id,v_empleado.nombre,v_empleado.telefono,v_empleado.puesto;
v_numero_empleados := v_numero_empleados + 1;
end loop;
raise notice E'Hay % empleados trabajando en los puestos de venta', v_numero_empleados;
--
raise notice '************************************************';
raise notice '************************************************';
--
raise notice '\n EMPLEADOS QUE TRABAJAN EN ESCENARIOS: ';
v_numero_empleados := 0;
for v_empleado in cur_empleado_escenarios LOOP
raise notice 'El empleado con id: %, nombre: %, telefono: % y puesto: %', 
v_empleado.id,v_empleado.nombre,v_empleado.telefono,v_empleado.puesto;
v_numero_empleados := v_numero_empleados + 1;
end loop;
raise notice E'Hay % empleados trabajando en los escenarios', v_numero_empleados;
--
exception
when no_data_found then 
        raise notice 'El empleado % no existe', p_id_artista;
   when others then
     raise exception 'Se ha producido un error inesperado';
end;
$$; 
```
Procedimiento con cursores para ver Los numeros de todos los empleados que tienen alguna tarea organizativa o de control (jefe seguridad, organizador voluntario o jefe puesto de venta): 
```sql
create or replace procedure empleados_con_responsabilidades()
language plpgsql
as
$$
declare
v_tabla_empleado_escenario record;
v_nombre_escenario escenarios.nombre_escenario%type;
--
v_tabla_empleado_puesto record;
v_nombre_puesto puestos_de_venta.marca%type;
--
cur_escenarios cursor for
select * from empleados 
where puesto ilike 'organizador voluntariado' or puesto ilike 'jefe seguridad';
--
cur_puestos cursor for
select * from empleados
where puesto ilike 'jefe puesto de venta';
--
begin
--
open cur_escenarios;
loop
fetch cur_escenarios into v_tabla_empleado_escenario;
exit when not found;
select nombre_escenario
into v_nombre_escenario
from escenarios
where id = v_tabla_empleado_escenario.id_escenario_trabaja;
raise notice 'El empleado % con el puesto % trabaja en el escenario % su número es %',v_tabla_empleado_escenario.nombre, v_tabla_empleado_escenario.puesto, v_nombre_escenario, v_tabla_empleado_escenario.telefono;
end loop;
close cur_escenarios;
--
open cur_puestos;
fetch cur_puestos into v_tabla_empleado_puesto;
while (found) loop
select marca
into v_nombre_puesto
from puestos_de_venta
where id = v_tabla_empleado_puesto.id_puesto_trabaja;
raise notice 'El empleado % con el puesto % trabaja en el puesto de venta % su número es %',v_tabla_empleado_puesto.nombre,v_tabla_empleado_puesto.puesto,v_nombre_puesto,v_tabla_empleado_puesto.telefono;
fetch cur_puestos into v_tabla_empleado_puesto;
end loop;
close cur_puestos;
end;
$$;
```

----

**TRIGGER para guardar los empleados borrados:**


Secuencia para la tabla empleados_borrados
```sql
CREATE SEQUENCE sec_empleados_borrados
increment 5
start 5;
```
Tabla donde insertaremos los datos de los empleados que borremos
```sql
create table empleados_borrados (
    id int CONSTRAINT empleados_borrados_pk PRIMARY KEY,
    empleado_id int not null,
    nombre_empleado varchar(50),
    puesto_empleado varchar(50),
    id_escenario_trabaja int,
    id_puesto_trabaja int,
    sueldo numeric,
    fecha_cambio date,
    usuario_cambia varchar(50)
);
```
Funcion que llamara al trigger cuando se borre un empleado, copiara  los datos antiguos y la fecha de la operacion en la tabla empleados borrados y borrara tambien el registro de la tabla balance:
```sql
create or replace function guardar_antiguos_empleados()
returns trigger
language plpgsql
as
$$
declare
v_sueldo balance.coste%type;
begin
-- Guardamos el sueldo del empleado:
select coste
into v_sueldo
from balance
where id = old.id;
-- insertamos los antiguos datos en la tabla empleados_borrados y borramos la entrada balance con su id:
insert into empleados_borrados 
(id, empleado_id, nombre_empleado, puesto_empleado, id_escenario_trabaja, id_puesto_trabaja,
sueldo, fecha_cambio, usuario_cambia)
values (nextval('sec_empleados_borrados'), old.id, old.nombre, old.puesto, old.id_escenario_trabaja, old.id_puesto_trabaja, v_sueldo, now(), user);
delete from balance where id = old.id;
return new;
end;
$$;
```
Trigger que se dispara antes de hacer delete en un empleado:
````sql
CREATE TRIGGER empleados_borrados 
before delete
on empleados 
for each row 
execute function guardar_antiguos_empleados();
```

