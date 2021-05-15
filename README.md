# QuevedoFest

- [x] 1. [**Introducción**](#final)
- [x] 2. **Modelo Conceptual**
   - [x] 2.1. [Especificaciones](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Modelo%20conceptual.md)
   - [x] 2.2. [Diagrama Entidad-Relación](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Modelo%20conceptual.md) --> [[link a img Diagrama]](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/img%20Diagrama%20entidad%20relacion/QuevedoFest.png)
- [x] 3. **Modelo Lógico**
   - [x] 3.1. [Modelo Relacional](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Modelo%20logico.md)
   - [x] 3.2. [Normalización/Desnormalización](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Modelo%20logico.md)
- [x] 4. **Modelo Físico**
   - [x] 4.1. [Diagrama de base de datos (notación "Crow's feet" o IDEF1X)](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Modelo%20f%C3%ADsico.md) -->  [[Link a imagen]](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/img%20Diagrama%20Crow%C2%B4s%20feet/crow%C2%B4s%20feet.png)
   - [x] 4.2. [Creación de tablas y otros objetos](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Modelo%20f%C3%ADsico.md) -->  [[Archivo sql de la base de datos]](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/Base%20de%20datos%2C%20archivo%20sql/QuevedoFest2.sql)
   - [x] 4.3. [Carga de datos de prueba](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Modelo%20f%C3%ADsico.md) -->  [[Archivo sql de la base de datos]](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/Base%20de%20datos%2C%20archivo%20sql/QuevedoFest2.sql)
- [x] 5. **Consultas de la base de datos**
   - [x] 5.1. [Consultas más frecuentes](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Consultas%20de%20la%20base%20de%20datos.md)
   - [x] 5.2. [Consultas sencillas](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Consultas%20de%20la%20base%20de%20datos.md)
   - [x] 5.3. [Consultas de agregación y resumen](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Consultas%20de%20la%20base%20de%20datos.md)
   - [x] 5.4. [Consultas con subconsultas](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Consultas%20de%20la%20base%20de%20datos.md)
- [x] 6. [**Vistas, secuencias e índices**](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Vistas%2C%20secuencias%20e%20%C3%ADndices.md)
- [x] 7. [**Scripts en PL/pgSQL**](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Scripts%20en%20pgSQL.md)
- [ ] 8. [**Extras**](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Extras.md)
   - [x] 8.1. [Cursores](https://github.com/Bouzas1402/QuevedoFest/blob/main/QuevedoFest/DesarrolloIndice/Extras.md)
   - [ ] 8.2. Prototipo de interfaz de usuario
   - [ ] 8.3. Plan de pruebas
   - [ ] 8.4. Especificaciones de pruebas en [formato features Gherkin (ver ejemplo)](features/admin-carteles.feature) 
   - [ ] 8.5. Diagrama de clases
   - [ ] 8.6. Ejemplo de acceso a la base de datos con Java y JDBC

--

# 1. Introducción:

A continuación se desarrola el proyecto de una base de datos para el festival de música QuevedoFest, festival que se desarrollara en la comunidad de Madrid en el verano de 2021 con una gran variedad de grupos y estilos musicales. 

Durante dos dias en dos escenarios diferentes con una capacidad total para 11.000 personas con puestos de venta de comida, bebida y merchandising del festival, con pases vip para uno o dos dias.

Cartel del festival:
```
 nombre_escenario  |       nombre        | dia |   hora
-------------------+---------------------+-----+----------
 QuevedoFestSounds | Lendakaris muertos  |   1 | 18:00:00
 QuevedoFestSounds | Ella baila sola     |   1 | 21:00:00
 QuevedoFestSounds | Estopa              |   1 | 00:00:00
 QuevedoFestSounds | Ayax y Prok         |   1 | 01:30:00
 QuevedoFestSounds | L.A.M.O.D.A         |   2 | 18:00:00
 QuevedoFestSounds | La Raiz             |   2 | 19:30:00
 QuevedoFestSounds | Kase O              |   2 | 21:00:00
 QuevedoFestSounds | Nator y Wor         |   2 | 01:30:00
 DAW Sonar         | Cupido              |   1 | 18:00:00
 DAW Sonar         | Extremoduro         |   1 | 19:30:00
 DAW Sonar         | Veintiuno           |   1 | 21:00:00
 DAW Sonar         | Amaral              |   1 | 22:30:00
 DAW Sonar         | Celtas cortos       |   1 | 00:00:00
 DAW Sonar         | La casa azul        |   1 | 01:30:00
 DAW Sonar         | SFDK                |   2 | 18:00:00
 DAW Sonar         | Los delincuentes    |   2 | 21:00:00
 DAW Sonar         | Heroes del silencio |   2 | 00:00:00
 DAW Sonar         | Vetusta Morla       |   2 | 01:30:00
 DAW Sonar         | Dellafuente         |   2 | 19:30:00
 QuevedoFestSounds | Don Patricio        |   1 | 19:30:00
 QuevedoFestSounds | La polla records    |   2 | 00:00:00
 QuevedoFestSounds | Rozalen             |   1 | 22:30:00
 DAW Sonar         | Blink 182           |   2 | 22:30:00
 QuevedoFestSounds | Pereza              |   2 | 22:30:00
```
# Nombre : Carlos Bouzas Álvaro
# Curso : Daw1_a
# Asignatura :Base de datos
<a name="final"></a>
