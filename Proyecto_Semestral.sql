CREATE DATABASE Parqueadero;
USE Parqueadero;

-- Crear la tabla para los carros
CREATE TABLE Carros (
    Placa VARCHAR(20) PRIMARY KEY,
    HoraEntrada TIME
);

-- Crear la tabla para los puestos del parqueadero
CREATE TABLE Puestos (
    NumeroPuesto INT PRIMARY KEY,
    CarroParqueado VARCHAR(20),
    FOREIGN KEY (CarroParqueado) REFERENCES Carros(Placa)
);

-- Insertar los datos de los puestos
INSERT INTO Puestos (NumeroPuesto) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(36),(37),(38),(39),(40);

-- Asegurarse de que la hora de entrada de los carros esté dentro del rango especificado (6:00 - 21:00)
ALTER TABLE Carros ADD CONSTRAINT HoraEntradaCheck CHECK (HoraEntrada BETWEEN '06:00:00' AND '21:00:00');

DELIMITER //

CREATE PROCEDURE MenuParqueadero()
BEGIN
    DECLARE choice INT;
    SET choice = 1;
    MenuLoop: LOOP
        -- Mostrar las opciones del menú
        SELECT '1. Ingresar un carro al parqueadero' AS MenuOption;
        SELECT '2. Dar salida a un carro del parqueadero' AS MenuOption;
        SELECT '3. Informar los ingresos totales del parqueadero' AS MenuOption;
        SELECT '4. Consultar la cantidad de puestos disponibles' AS MenuOption;
        SELECT '5. Consultar el porcentaje de disponibilidad' AS MenuOption;
        SELECT '6. Avanzar el reloj del parqueadero' AS MenuOption;
        SELECT '7. Cambiar la tarifa del parqueadero' AS MenuOption;
        SELECT '0. Salir de la aplicación' AS MenuOption;
       
        -- Pedir al usuario que elija otra opción
        SELECT 'Ingrese el número de la opción deseada: ' INTO choice;
        SET choice = IFNULL(choice, -1);
       
        -- Ejecutar la opción seleccionada
        CASE choice
            WHEN 1 THEN
                CALL IngresarCarro();
            WHEN 2 THEN
                CALL DarSalidaCarro();
            WHEN 3 THEN
                CALL InformarIngresosTotales();
            WHEN 4 THEN
                CALL ConsultarPuestosDisponibles();
            WHEN 5 THEN
                CALL ConsultarPorcentajeDisponibilidad();
            WHEN 6 THEN
                CALL AvanzarRelojParqueadero();
            WHEN 7 THEN
                CALL CambiarTarifaParqueadero();
            WHEN 0 THEN
                LEAVE MenuLoop;
            ELSE  
                SELECT 'Opción no válida';
        END CASE;
    END LOOP MenuLoop;    
END //

DELIMITER ;

-- Llamar al procedimiento para iniciar el menú
use Parqueadero;
CALL MenuParqueadero;
