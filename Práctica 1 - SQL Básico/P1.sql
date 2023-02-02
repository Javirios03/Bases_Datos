-- 1. Obtenemos los atributos de los viajes con una distancia mayor a 350 kilómetros
SELECT orig, dest, km
FROM trayectos
WHERE km > 350
ORDER BY km ASC;

-- 2. Generamos los precios únicos de más caro a más barato
SELECT DISTINCT precio
FROM trayectos
ORDER BY precio DESC;

-- 3. Listado de estos 3 atributos con orden específico
SELECT matric, cbill, fecha
FROM billetes
ORDER BY matric DESC, cbill DESC, fecha ASC;

-- 4. Obtenemos los atributos para el autobús de matricula "1234GKH" ascendentemente (en cbill)
SELECT cbill, fecha, hora
FROM autobuses a, billetes b
WHERE a.matric = "1234GKH"
ORDER BY fecha ASC; -- Cambiar fecha por cbill

-- 5. Info de todos los pasajeros, ordenado alfabéticamente por nombre
SELECT dni, nombre, tlfn
FROM pasajeros
ORDER BY nombre;

-- 6. Código de los trayectos para los cuales no se ha vendido ningún billete
SELECT codtray
FROM trayectos
WHERE codtray not in (SELECT DISTINCT codtray
					  FROM billetes);

-- 7. Matrícula y billetes vendidos (cbill) de autobuses específicos
SELECT a.matric, cbill
FROM autobuses a, billetes b
WHERE b.fecha = "2007/02/05" AND a.matric in (SELECT matric
											  FROM autobuses
											  WHERE itv = "2007/02/05");

-- 8. Nombre de los pasajeros con trayecto entre dos fechas
SELECT nombre
FROM pasajeros
WHERE dni in (SELECT dni
			  FROM billetes
              WHERE ((fecha BETWEEN "2007/03/13" AND "2007/03/18") AND hora = "08:00:00"));
              
-- 9. Código de trayecto de mayor longitud
SELECT codtray
FROM trayectos
WHERE km = (SELECT MAX(km)
			FROM trayectos);

-- 10. DNI y código de los billetes comprados por pasajeros apellidados "PEREZ"
SELECT dni, cbill
FROM billetes
WHERE DNI in (SELECT DISTINCT dni
			  FROM pasajeros
			  WHERE nombre LIKE "PEREZ%");
     
-- 11. Datos del trayecto con código "CT-403" que tengan algún billete
SELECT *
FROM trayectos
WHERE codtray = "CT-403" AND codtray in (SELECT DISTINCT codtray
										 FROM billetes);
                                         
-- 12. Datos del mismo código, siempre que exista algún billete para el "CT-405"
SELECT *
FROM trayectos
WHERE codtray = "CT-405" AND EXISTS (SELECT codtray
									 FROM billetes
                                     WHERE codtray = "CT-405");
                                     
-- 13. Nombre y DNI de todos los pasajeros con billete para autobús "5482-FDH"
SELECT nombre, dni
FROM pasajeros
WHERE dni in (SELECT dni
			  FROM billetes
              WHERE matric = "5482FDH");

-- 14. Obtener el número total de billetes vendidos
SELECT COUNT(cbill)
FROM billetes;

-- 15. Obtener el precio más caro de los trayectos
SELECT MAX(precio)
FROM trayectos;

-- CONSULTAS ADICIONALES
-- 1. cbill y año de compra de billetes por "PEREZ" y matriculas específicas. Orden descendente por año de compra
SELECT cbill, YEAR(fecha)
FROM billetes
WHERE dni in (SELECT dni
			  FROM pasajeros
			  WHERE nombre LIKE "PEREZ%") AND SUBSTR(matric, 1, 2) in ("1G", "1D")
ORDER BY YEAR(fecha) DESC;

-- 2. Datos de pasajeros con teléfono "91..." y billetes entre 2 y 15 de Agosto de 2017
SELECT *
FROM pasajeros
WHERE tlfn LIKE "91%" AND dni in (SELECT dni
								  FROM billetes
								  WHERE fecha between "2017/08/02" AND "2017/08/15");

-- 3. Datos de trayectos con origen que empieza por "MAD" y precio menor
SELECT *
FROM trayectos
WHERE orig LIKE "MAD%"
ORDER BY precio ASC
LIMIT 1;

-- 4. DNI y nombre de pasajeros con billetes destino "ZARAGOZA"
SELECT dni, nombre
FROM pasajeros
WHERE dni in (SELECT dni
			  FROM billetes
			  WHERE codtray in (SELECT codtray
			  					FROM trayectos
								WHERE dest = "ZARAGOZA"));

-- 5. Origen y destino de billetes vendidos de autobuses matrícula "1..." y fecha en 2017
SELECT orig, dest
FROM trayectos
WHERE codtray in (SELECT codtray 
				  FROM billetes
				  WHERE matric LIKE "1%" AND YEAR(fecha) = "2017");