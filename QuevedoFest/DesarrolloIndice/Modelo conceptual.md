[link img]: https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/img%20Diagrama%20entidad%20relacion/QuevedoFest.png
## 2. Modelo Conceptual:
#### 2.1 Especificaciones:

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



####2.2 Diagrama entidad relación:


![Diagrama entidad relación]([link img])
