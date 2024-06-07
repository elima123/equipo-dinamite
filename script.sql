CREATE DATABASE appix;
use appix;

select * from usuarios;
CREATE TABLE Usuarios (
	IDUsuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	Nombre VARCHAR(30),
    Contrasena VARCHAR(20)
    );
    
ALTER TABLE Usuarios
ADD COLUMN Correo VARCHAR(80);

ALTER TABLE Usuarios
ADD COLUMN FechaCreado DATE;
    
ALTER TABLE Usuarios
ADD COLUMN Rol ENUM("desarrollador", "manager");
    
DELETE FROM Usuarios WHERE IDUsuario > 20;
    
UPDATE Usuarios SET FechaCreado = '2024-04-02' WHERE IDUsuario = 1;
UPDATE Usuarios SET FechaCreado = '2024-04-10' WHERE IDUsuario = 2;
UPDATE Usuarios SET FechaCreado = '2024-04-18' WHERE IDUsuario = 3;
UPDATE Usuarios SET FechaCreado = '2024-04-22' WHERE IDUsuario = 4;
UPDATE Usuarios SET FechaCreado = '2024-04-25' WHERE IDUsuario = 5;
UPDATE Usuarios SET FechaCreado = '2024-05-01' WHERE IDUsuario = 6;
UPDATE Usuarios SET FechaCreado = '2024-05-07' WHERE IDUsuario = 7;
UPDATE Usuarios SET FechaCreado = '2024-05-10' WHERE IDUsuario = 8;
UPDATE Usuarios SET FechaCreado = '2024-05-13' WHERE IDUsuario = 9;
UPDATE Usuarios SET FechaCreado = '2024-05-15' WHERE IDUsuario = 10;
UPDATE Usuarios SET FechaCreado = '2024-05-18' WHERE IDUsuario = 11;
UPDATE Usuarios SET FechaCreado = '2024-05-21' WHERE IDUsuario = 12;
UPDATE Usuarios SET FechaCreado = '2024-05-23' WHERE IDUsuario = 13;
UPDATE Usuarios SET FechaCreado = '2024-05-26' WHERE IDUsuario = 14;
UPDATE Usuarios SET FechaCreado = '2024-05-28' WHERE IDUsuario = 15;
UPDATE Usuarios SET FechaCreado = '2024-05-30' WHERE IDUsuario = 16;
UPDATE Usuarios SET FechaCreado = '2024-06-01' WHERE IDUsuario = 61;
UPDATE Usuarios SET FechaCreado = '2024-06-03' WHERE IDUsuario = 62;
UPDATE Usuarios SET FechaCreado = '2024-06-05' WHERE IDUsuario = 63;
UPDATE Usuarios SET FechaCreado = '2024-06-07' WHERE IDUsuario = 64;

    
select * from Proyectos;
CREATE TABLE Proyectos (
	IDProyecto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    IDEmpresa INT,
    Nombre VARCHAR(30),
    Descripcion VARCHAR(120),
    Estado ENUM("activo", "finalizado"),
    FechaInicio DATE,
    FechaFinal DATE,
    Costo INT,
    
    FOREIGN KEY (IDEmpresa) REFERENCES Empresas (IDEmpresa)
    );
UPDATE Proyectos
SET FechaCerrado = '2024-06-01' WHERE IDProyecto = 7;

ALTER TABLE Proyectos
ADD COLUMN FechaCerrado DATE;

UPDATE Proyectos 
SET RazonCerrado = 'Falta de desarrolladores disponibles' WHERE IDProyecto = 7;

ALTER TABLE Proyectos
MODIFY COLUMN Nombre VARCHAR(50);

UPDATE Proyectos 
SET estado = 'finalizado', RazonCerrado = 'demasiados riesgso', FechaCerrado = NOW()
WHERE IDProyecto = 22;

SELECT up.*, p.Nombre
        FROM UsuarioProyectos as up
        INNER JOIN Proyectos as p ON up.IDProyecto = p.IDProyecto;
        
SELECT p.*, e.Nombre AS nombreEmpresa
FROM Proyectos as p
INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa 
WHERE IDProyecto = 1;

CREATE USER u_dinamite@localhost IDENTIFIED BY 'pdinamite';
GRANT Alter ON appix.* TO u_dinamite@localhost;
GRANT Create ON appix.* TO u_dinamite@localhost;
GRANT Create view ON appix.* TO u_dinamite@localhost;
GRANT Delete ON appix.* TO u_dinamite@localhost;
-- GRANT Delete history ON appix.* TO 'u_dinamite'@'%';
GRANT Drop ON appix.* TO u_dinamite@localhost;
GRANT Grant option ON appix.* TO u_dinamite@localhost;
GRANT Index ON appix.* TO u_dinamite@localhost;
GRANT Insert ON appix.* TO u_dinamite@localhost;
GRANT References ON appix.* TO u_dinamite@localhost;
GRANT Select ON appix.* TO u_dinamite@localhost;
GRANT Show view ON appix.* TO u_dinamite@localhost;
GRANT Trigger ON appix.* TO u_dinamite@localhost;
GRANT Update ON appix.* TO u_dinamite@localhost;

CREATE USER 'u_dinamite'@'%' IDENTIFIED BY 'pdinamite';
GRANT Alter ON appix.* TO 'u_dinamite'@'%';
GRANT Create ON appix.* TO 'u_dinamite'@'%';
GRANT Create view ON appix.* TO 'u_dinamite'@'%';
GRANT Delete ON appix.* TO 'u_dinamite'@'%';
-- GRANT Delete history ON appix.* TO 'u_dinamite'@'%';
GRANT Drop ON appix.* TO 'u_dinamite'@'%';
GRANT Grant option ON appix.* TO 'u_dinamite'@'%';
GRANT Index ON appix.* TO 'u_dinamite'@'%';
GRANT Insert ON appix.* TO 'u_dinamite'@'%';
GRANT References ON appix.* TO 'u_dinamite'@'%';
GRANT Select ON appix.* TO 'u_dinamite'@'%';
GRANT Show view ON appix.* TO 'u_dinamite'@'%';
GRANT Trigger ON appix.* TO 'u_dinamite'@'%';
GRANT Update ON appix.* TO 'u_dinamite'@'%';
    
    
select * from empresas;
CREATE TABLE Empresas (
	IDEmpresa INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(30),
    Telefono VARCHAR(12),
    Correo VARCHAR(30)
    );
    
SELECT e.Nombre 
FROM Empresas as e;
    
ALTER TABLE Empresas
MODIFY COLUMN Nombre VARCHAR(60);
    
select * from Riesgos;
CREATE TABLE Riesgos (
	IDRiesgo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	Categoria ENUM("Alcance", "Tiempo", "Calidad", "Recursos", "Costo"),
    Probablidad ENUM("Baja", "Media", "Alta"),
    Impacto ENUM("Bajo", "Medio", "Alto"),
    Estrategia VARCHAR(120)
    );
ALTER TABLE Riesgos
CHANGE Probablidad Probabilidad ENUM("Baja", "Media", "Alta");
    
ALTER TABLE Riesgos
ADD COLUMN ImpactoNumerico FLOAT;

UPDATE Riesgos
SET ImpactoNumerico = 0.03 WHERE Impacto = "Medio";
    
select * from UsuarioProyectos;
CREATE TABLE UsuarioProyectos (
	IDUsuario INT,
    IDProyecto INT,
    
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios (IDUsuario),
    FOREIGN KEY (IDProyecto) REFERENCES Proyectos (IDProyecto)
);

ALTER TABLE UsuarioProyectos
ADD COLUMN FechaAgregado DATE;

UPDATE UsuarioProyectos SET FechaAgregado = '2024-04-15' WHERE IDProyecto = 1;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-04-17' WHERE IDProyecto = 2;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-04-19' WHERE IDProyecto = 3;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-04-21' WHERE IDProyecto = 4;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-04-23' WHERE IDProyecto = 5;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-04-25' WHERE IDProyecto = 6;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-04-27' WHERE IDProyecto = 7;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-04-29' WHERE IDProyecto = 8;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-01' WHERE IDProyecto = 9;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-03' WHERE IDProyecto = 10;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-05' WHERE IDProyecto = 11;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-07' WHERE IDProyecto = 12;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-09' WHERE IDProyecto = 13;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-11' WHERE IDProyecto = 14;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-13' WHERE IDProyecto = 15;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-15' WHERE IDProyecto = 16;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-17' WHERE IDProyecto = 17;
-- UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-19' WHERE IDProyecto = 18;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-21' WHERE IDProyecto = 19;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-23' WHERE IDProyecto = 20;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-25' WHERE IDProyecto = 21;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-27' WHERE IDProyecto = 22;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-29' WHERE IDProyecto = 23;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-05-31' WHERE IDProyecto = 24;
UPDATE UsuarioProyectos SET FechaAgregado = '2024-06-02' WHERE IDProyecto = 25;


INSERT INTO UsuarioProyectos (IDUsuario, IDProyecto) VALUES
(11, 3),
(62, 3);

UPDATE UsuarioProyectos
SET FechaAgregado = '2024-06-05' WHERE IDUsuario = 62 AND IDProyecto = 3;

(4, 5),
(4, 20),
(4, 19),
(4, 6),
(5, 16),
(5, 24),
(5, 12),
(5, 13),
(5, 1),
(6, 20),
(6, 1),
(6, 17),
(7, 10),
(7, 5),
(7, 17),
(8, 19),
(8, 3),
(8, 7),
(8, 17),
(8, 8),
(9, 3),
(9, 16),
(9, 1),
(9, 4),
(10, 3),
(10, 6),
(10, 20),
(10, 25),
(10, 7),
(11, 2),
(11, 24),
(11, 1),
(11, 12),
(11, 23),
(12, 9),
(12, 4),
(12, 21),
(13, 10),
(13, 15),
(13, 5),
(13, 11),
(13, 9),
(14, 11),
(14, 22),
(15, 3),
(15, 10),
(15, 24),
(15, 13),
(15, 19),
(16, 15),
(16, 13),
(17, 22),
(17, 13),
(17, 2),
(17, 14),
(17, 11),
(18, 3),
(18, 15),
(18, 6),
(18, 20),
(19, 25),
(19, 6),
(19, 20),
(19, 19),
(19, 1),
(20, 10),
(20, 23),
(20, 17),
(20, 8);
    
INSERT INTO UsuarioProyectos (IDUsuario, IDProyecto)
VALUES
(6, 4);

SELECT p.*, DATE_FORMAT(FechaInicio, '%d/%m/%Y') AS start,
			DATE_FORMAT(FechaFinal, '%d/%m/%Y') AS end,
e.Nombre AS nombreEmpresa
FROM Proyectos as p
INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa
INNER JOIN UsuarioProyectos as up ON up.IDProyecto = p.IDProyecto
WHERE up.IDUsuario = 6;

SELECT p.IDProyecto, p.IDEmpresa, p.Nombre, pr.IDProyecto, pr.IDRiesgo, 
COUNT(pr.IDRiesgo) AS numRiesgos,
r.IDRiesgo, r.Impacto, r.ImpactoNumerico,
(((1-(SUM(r.ImpactoNumerico)))/1)*100) AS viabilidad
FROM Proyectos as p
JOIN ProyectoRiesgos as pr ON p.IDProyecto = pr.IDProyecto
JOIN Riesgos as r ON pr.IDRiesgo = r.IDRiesgo
WHERE p.IDProyecto = 1;

SELECT p.IDProyecto, p.Nombre, DATE_FORMAT(FechaInicio, '%d/%m/%Y') AS start,
			DATE_FORMAT(FechaFinal, '%d/%m/%Y') AS end,
e.nombre AS nombreEmpresa,
ROUND((((1-(SUM(r.ImpactoNumerico)))/1)*100), 0) AS viabilidad
FROM Proyectos as p
INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa
JOIN ProyectoRiesgos as pr ON p.IDProyecto = pr.IDProyecto
JOIN Riesgos as r ON pr.IDRiesgo = r.IDRiesgo
JOIN UsuarioProyectos as up ON p.IDProyecto = up.IDProyecto
WHERE up.IDUsuario = 6
GROUP BY p.IDProyecto;
-- WHERE p.IDProyecto = 1;

SELECT p.*, DATE_FORMAT(FechaInicio, '%d/%m/%Y') AS start,
			DATE_FORMAT(FechaFinal, '%d/%m/%Y') AS end,
            e.nombre AS nombreEmpresa,
            ROUND((((1-(SUM(r.ImpactoNumerico)))/1)*100), 0) AS Viabilidad
            FROM Proyectos as p
            INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa
            LEFT JOIN ProyectoRiesgos as pr ON p.IDProyecto = pr.IDProyecto
            LEFT JOIN Riesgos as r ON pr.IDRiesgo = r.IDRiesgo
            GROUP BY p.IDProyecto
            ORDER BY start DESC;

select * from ProyectoRiesgos;
CREATE TABLE ProyectoRiesgos (
	IDProyectoRiesgo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	IDProyecto INT,
    IDRiesgo INT,

    FOREIGN KEY (IDProyecto) REFERENCES Proyectos (IDProyecto),
    FOREIGN KEY (IDRiesgo) REFERENCES Riesgos (IDRiesgo)
    );
    
ALTER TABLE ProyectoRiesgos
ADD COLUMN FechaAgregado DATE;

UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-26' WHERE IDProyectoRiesgo = 1;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-19' WHERE IDProyectoRiesgo = 2;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-06' WHERE IDProyectoRiesgo = 3;
-- UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-01' WHERE IDProyectoRiesgo = 4;
-- UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-07' WHERE IDProyectoRiesgo = 5;
-- UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-16' WHERE IDProyectoRiesgo = 6;
-- UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-16' WHERE IDProyectoRiesgo = 7;
-- UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-26' WHERE IDProyectoRiesgo = 8;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-22' WHERE IDProyectoRiesgo = 9;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-06' WHERE IDProyectoRiesgo = 10;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-08' WHERE IDProyectoRiesgo = 11;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-23' WHERE IDProyectoRiesgo = 12;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-31' WHERE IDProyectoRiesgo = 13;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-15' WHERE IDProyectoRiesgo = 14;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-20' WHERE IDProyectoRiesgo = 15;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-06-02' WHERE IDProyectoRiesgo = 16;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-25' WHERE IDProyectoRiesgo = 17;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-13' WHERE IDProyectoRiesgo = 18;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-18' WHERE IDProyectoRiesgo = 19;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-13' WHERE IDProyectoRiesgo = 20;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-09' WHERE IDProyectoRiesgo = 21;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-22' WHERE IDProyectoRiesgo = 22;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-19' WHERE IDProyectoRiesgo = 23;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-30' WHERE IDProyectoRiesgo = 24;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-25' WHERE IDProyectoRiesgo = 25;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-28' WHERE IDProyectoRiesgo = 26;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-27' WHERE IDProyectoRiesgo = 27;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-08' WHERE IDProyectoRiesgo = 28;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-05' WHERE IDProyectoRiesgo = 29;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-11' WHERE IDProyectoRiesgo = 30;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-26' WHERE IDProyectoRiesgo = 31;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-21' WHERE IDProyectoRiesgo = 32;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-08' WHERE IDProyectoRiesgo = 33;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-15' WHERE IDProyectoRiesgo = 34;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-13' WHERE IDProyectoRiesgo = 35;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-28' WHERE IDProyectoRiesgo = 36;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-30' WHERE IDProyectoRiesgo = 37;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-09' WHERE IDProyectoRiesgo = 38;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-04' WHERE IDProyectoRiesgo = 39;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-14' WHERE IDProyectoRiesgo = 40;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-06' WHERE IDProyectoRiesgo = 41;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-08' WHERE IDProyectoRiesgo = 42;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-29' WHERE IDProyectoRiesgo = 43;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-18' WHERE IDProyectoRiesgo = 44;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-13' WHERE IDProyectoRiesgo = 45;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-22' WHERE IDProyectoRiesgo = 46;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-20' WHERE IDProyectoRiesgo = 47;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-29' WHERE IDProyectoRiesgo = 48;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-12' WHERE IDProyectoRiesgo = 49;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-15' WHERE IDProyectoRiesgo = 50;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-26' WHERE IDProyectoRiesgo = 51;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-09' WHERE IDProyectoRiesgo = 52;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-04-06' WHERE IDProyectoRiesgo = 53;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-01' WHERE IDProyectoRiesgo = 54;
UPDATE ProyectoRiesgos SET FechaAgregado = '2024-05-31' WHERE IDProyectoRiesgo = 55;
 
SELECT r.*
FROM ProyectoRiesgos as pr
INNER JOIN Riesgos as r ON pr.IDRiesgo = r.IDRiesgo
WHERE pr.IDProyecto = 1;
