---------------------------------------------------------------------
--1.   Crear base de datos llamada películas.
CREATE DATABASE peliculas;
--1.2  Listando las base de datos
\l
--1.1  Acceder a la base de datos
\c peliculas;

---------------------------------------------------------------------
--2.   Cargar ambos archivos a su tabla correspondiente.
--2.1  Crear la tabla (peliculas)
CREATE TABLE peliculas(id int, pelicula varchar(60), ano_estreno varchar(4), director varchar(60), PRIMARY KEY(id));
--2.2  Importar los datos desde archivo (peliculas.csv)
COPY peliculas FROM 'C:\Users\darkm\Desktop\Modulo 5\Desafio_Top_100\Apoyo DesafIo - Top 100\peliculas.csv' csv header;
--2.3  Crear la table (reparto)
CREATE TABLE reparto(id int, reparto varchar(60), FOREIGN KEY (id) REFERENCES peliculas(id));
--2.4  Importar los datos desde el archivo (reparto.csv)
COPY reparto FROM 'C:\Users\darkm\Desktop\Modulo 5\Desafio_Top_100\Apoyo DesafIo - Top 100\reparto.csv' csv header;
--2.5  Verificar que la tabla y los datos se encuentran correctos
SELECT * FROM peliculas;
SELECT * FROM reparto;

---------------------------------------------------------------------
--3.   Obtener el ID de la película “Titanic”.
SELECT id FROM peliculas WHERE pelicula='Titanic';

---------------------------------------------------------------------
--4.   Listar a todos los actores que aparecen en la película "Titanic".
--     En este caso se utiliza un consilta anidada en una consicion.
SELECT reparto FROM reparto WHERE id=(SELECT id FROM peliculas WHERE pelicula='Titanic');

---------------------------------------------------------------------
--5.   Consultar en cuántas películas del top 100 participa Harrison Ford.
SELECT COUNT (id) AS total_participacion_t100_Harrison_Ford FROM reparto WHERE reparto='Harrison Ford';

---------------------------------------------------------------------
--6.   Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.
SELECT id,pelicula,ano_estreno FROM peliculas WHERE ano_estreno BETWEEN '1990' AND '1999' ORDER BY ano_estreno ASC;

--------------------------------------------------------------------
--7.   Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.
SELECT id,pelicula, LENGTH(pelicula) AS longitud_titulo FROM peliculas;

---------------------------------------------------------------------
--8.   Consultar cual es la longitud más grande entre todos los títulos de las películas.
--     inicialmemnte de busca dentro de los titulos de peliculas el maximo largo
SELECT MAX(LENGTH(pelicula)) AS longitud_max_titulo FROM peliculas;
--     debido a que el solo se mustra el largo y no los datos se utiliza una consulta anidada para mostrar la id-titulo y el largo cuando se cumpla la condicion de que el largo sea igual al maximo largo encontrado.
SELECT id,pelicula, LENGTH(pelicula) AS max_longitud_titulo FROM peliculas WHERE LENGTH(pelicula)=(SELECT MAX(LENGTH(pelicula)) FROM peliculas);
