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