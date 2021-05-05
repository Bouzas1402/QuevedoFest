## 3.Modelo logico
#### 3.1. Modelo relacional:
#### 3.2. Normalización/Desnormalización:

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
