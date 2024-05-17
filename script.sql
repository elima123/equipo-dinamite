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
ADD COLUMN Rol ENUM("desarrollador", "manager");
    
DELETE FROM Usuarios WHERE IDUsuario > 20;
    
UPDATE Usuarios
SET Rol = "desarrollador" WHERE IDUsuario > 3;

UPDATE Usuarios
SET Correo = 
    CASE 
        WHEN Nombre = 'Carlos López' THEN 'carlos.lopez@ejemplo.com'
        WHEN Nombre = 'Sofia Martinez' THEN 'sofia.martinez@ejemplo.com'
        WHEN Nombre = 'Alejandro Ramirez' THEN 'alejandro.ramirez@ejemplo.com'
        WHEN Nombre = 'Valeria Hernandez' THEN 'valeria.hernandez@ejemplo.com'
        WHEN Nombre = 'Diego Gonzalez' THEN 'diego.gonzalez@ejemplo.com'
        WHEN Nombre = 'Ana Rodriguez' THEN 'ana.rodriguez@ejemplo.com'
        WHEN Nombre = 'Luisa Sanchez' THEN 'luisa.sanchez@ejemplo.com'
        WHEN Nombre = 'Jorge Cruz' THEN 'jorge.cruz@ejemplo.com'
        WHEN Nombre = 'Natalia Garcia' THEN 'natalia.garcia@ejemplo.com'
        WHEN Nombre = 'Rodrigo Torres' THEN 'rodrigo.torres@ejemplo.com'
        WHEN Nombre = 'Maria Flores' THEN 'maria.flores@ejemplo.com'
        WHEN Nombre = 'Eduardo Diaz' THEN 'eduardo.diaz@ejemplo.com'
        WHEN Nombre = 'Andrea Vazquez' THEN 'andrea.vazquez@ejemplo.com'
        WHEN Nombre = 'Francisco Reyes' THEN 'francisco.reyes@ejemplo.com'
        WHEN Nombre = 'Pamela Torres' THEN 'pamela.torres@ejemplo.com'
        WHEN Nombre = 'Javier Gomez' THEN 'javier.gomez@ejemplo.com'
        WHEN Nombre = 'Daniela Martinez' THEN 'daniela.martinez@ejemplo.com'
        WHEN Nombre = 'Sergio Hernandez' THEN 'sergio.hernandez@ejemplo.com'
        WHEN Nombre = 'Adriana Aguilar' THEN 'adriana.aguilar@ejemplo.com'
        WHEN Nombre = 'Ricardo Mendoza' THEN 'ricardo.mendoza@ejemplo.com'
        ELSE Correo  -- Keep the existing email if no match
    END;

    
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
SET Estado = "finalizado" WHERE IDProyecto = 2 OR IDProyecto = 7;

ALTER TABLE Proyectos
MODIFY COLUMN Nombre VARCHAR(50);

INSERT INTO Proyectos (IDEmpresa, Nombre, Descripcion, Estado, FechaInicio, FechaFinal, Costo)
VALUES
(4, "TiendaOnline.com", "Una tienda en linea para venta de zapatos", "activo", "2024-02-28","2024-08-28", 200000);
    
SELECT p.*, e.Nombre AS nombreEmpresa
FROM Proyectos as p
INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa 
WHERE IDProyecto = 1;
    
INSERT INTO Proyectos (IDEmpresa, Nombre, Descripcion, Estado, FechaInicio, FechaFinal, Costo)
VALUES
(10, "Sitio E-Commerce Tenis Jurica", "Venta en linea de tenis en Jurica", "activo", "2024-02-15", "2024-09-30", 80000),
(11, "Stickers el Guero", "Venta de stickers digitales", "activo", "2024-03-10", "2024-08-15", 50000),
(12, "Pagina de Ferreteria", "Plataforma e-commerce de ferretaria local", "activo", "2024-04-20", "2024-11-10", 240000),
(13, "Sitio Pet Shelter", "Difusion de venta de mascotas", "activo", "2024-05-05", "2024-12-20", 110000),
(14, "Sistema Seguridad", "sistema de entrada y salida de empleados", "activo", "2024-06-30", "2025-01-31", 440000),
(15, "Task Manager", "aplicacion movil para manejar juntas, tareas, entregas", "activo", "2024-07-15", "2025-02-28", 190000),
(16, "Streaming Services", "pagina web de peliculas y series", "activo", "2024-08-10", "2025-03-15", 230000),
(17, "Crypto App", "app movil para comprar/vender cryptomonedas", "activo", "2024-09-25", "2025-04-30", 300000);
    
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
    
INSERT INTO Empresas (Nombre, Telefono, Correo)
VALUES
("Grupo Industrial Azteca", "55-1234-5678", "contacto@grupoazteca.com.mx"),
("Constructora Hidalgo SA de CV", "33-9876-5432", "info@constructorahidalgo.com.mx"),
("Comercializadora Maya SAPI de CV", "81-2468-1357", "ventas@mayacomercial.com.mx"),
("Ingeniería del Norte SA", "686-555-1234", "contacto@ingenierianorte.com.mx"),
("Consultores y Asesores Morales", "55-7890-4321", "info@moralesconsulting.com.mx"),
("Desarrollos Urbanos del Sureste", "999-369-2580", "ventas@dusureste.com.mx"),
("Energía Renovable SA", "33-1478-9632", "contacto@energiarenovable.com.mx"),
("Grupo Financiero Azul", "55-2580-1478", "info@grupofinancieroazul.com.mx"),
("Manufacturas del Bajío SA de CV", "477-369-2580", "ventas@manufacturasbajio.com.mx"),
("Servicios Logísticos del Pacífico", "322-654-7890", "info@logisticapacifico.com.mx"),
("Tecnología Avanzada del Golfo", "833-135-2468", "contacto@tecnologiagolfo.com.mx"),
("Grupo Gastronómico Luna", "55-3698-1478", "info@grupoluna.com.mx"),
("Despachos Legales Ramírez", "662-789-1234", "contacto@ramirezlegal.com.mx"),
("Comercializadora del Norte", "81-6543-9876", "ventas@comernorte.com.mx"),
("Consultoría Estratégica Maya", "998-369-2580", "info@consultmayas.com.mx"),
("Industria Automotriz del Bajío", "462-369-2580", "ventas@automotrizbajio.com.mx"),
("Constructora del Sureste SA", "999-1478-9632", "contacto@consursureste.com.mx"),
("Soluciones Tecnológicas del Centro", "55-9876-5432", "info@solucionescentro.com.mx"),
("Inmobiliaria del Caribe", "998-369-1478", "contacto@inmocaribe.com.mx"),
("Grupo Turístico del Pacífico", "322-2580-1478", "info@grupoturisticopacifico.com.mx");
    
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

select * from ProyectoRiesgos;
CREATE TABLE ProyectoRiesgos (
	IDProyectoRiesgo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	IDProyecto INT,
    IDRiesgo INT,

    FOREIGN KEY (IDProyecto) REFERENCES Proyectos (IDProyecto),
    FOREIGN KEY (IDRiesgo) REFERENCES Riesgos (IDRiesgo)
    );
    
SELECT r.*
FROM ProyectoRiesgos as pr
INNER JOIN Riesgos as r ON pr.IDRiesgo = r.IDRiesgo
WHERE pr.IDProyecto = 1;

INSERT INTO ProyectoRiesgos (IDProyecto, IDRiesgo)
VALUES 
(5, 1),
(6, 5),
(8, 6),
(9, 8),
(10, 10),
(11, 11),
(11, 14),
(12, 13),
(13, 16),
(14, 19),
(15, 22),
(17, 27),
(17, 28),
(17, 31);

    
INSERT INTO Riesgos (Riesgo, Categoria, Probabilidad, Impacto, Estrategia)
VALUES 
("Incomprensión de los requisitos del cliente", "Alcance", "Media", "Alto", "Realizar reuniones detalladas con el cliente."),
("Retrasos en la entrega del contenido", "Tiempo", "Alta", "Medio", "Establecer plazos claros y roles para entrega de contenido."),
("Cambios frecuentes en el diseño", "Alcance", "Media ", "Medio", "Definir un alcance claro y limitar las revisiones del diseño."),
("Problemas de compatibilidad de plugins ", "Calidad", "Baja ", "Alto", "Realizar pruebas de compatibilidad al inicio."),
("Problemas de seguridad en el sitio web", "Calidad", "Baja", "Alto", "Aplicar estándares de seguridad y realizar actualizaciones."),
("Fallos en la integración de pasarelas de pago", "Calidad", "Media", "Alto", "Validar integraciones y tener proveedores de respaldo."),
("Aumento inesperado en los costos del proyecto", "Costo", "Baja", "Medio", "Monitorear y ajustar el presupuesto continuamente."),
("Pérdida de datos o fallo de hosting", "Calidad", "Baja", "Alto", "Implementar estrategias de respaldo y recuperación ante desastres."),
("Retrasos en la aprobación del cliente", "Tiempo", "Media", "Medio", "Establecer expectativas y procesos claros de aprobación."),
("Dificultades técnicas con WordPress o WooCommerce", "Calidad", "Media", "Medio", "Mantenerse actualizado con las últimas versiones y soporte."),
("Sobrecarga de trabajo del equipo de diseño", "Recursos", "Media", "Alto", "Gestionar la carga de trabajo y los recursos adecuadamente."),
("Falta de experiencia en tecnologías específicas", "Calidad", "Media", "Alto", "Capacitar al equipo o contratar talento especializado."),
("Inadecuada gestión del cambio", "Alcance", "Alta", "Alto", "Implementar un sistema estructurado de gestión de cambios."),
("Interrupciones en la cadena de suministro digital", "Costo", "Baja", "Medio", "Tener alternativas y planes de contingencia."),
("Problemas de SEO y visibilidad en buscadores", "Calidad", "Media", "Medio", "Aplicar técnicas SEO desde el inicio del proyecto."),
("Cambio de persona responsable durante y después del proyecto", "Recursos", "Media", "Alto", "Crear planes de transición por si pasa esto."),
("Subestimación de tiempos y costos", "Tiempo/Costo", "Media", "Alto", "Utilizar datos históricos para estimaciones precisas."),
("Cambios en los requisitos del software", "Alcance", "Alta", "Alto", "Mantener un proceso de gestión de cambios robusto."),
("Falta de recursos técnicos", "Costo", "Media", "Alto", "Asegurar disponibilidad de recursos y personal cualificado."),
("Problemas técnicos y bugs en el desarrollo", "Calidad", "Alta", "Medio", "Implementar pruebas exhaustivas y QA constante."),
("Tecnología obsoleta o inadecuada", "Calidad", "Baja", "Alto", "Realizar auditorías tecnológicas y actualizaciones regulares."),
("Dificultades de integración con otros sistemas", "Alcance", "Media", "Alto", "Ejecutar pruebas de integración frecuentes y tempranas."),
("Dependencia de terceros para componentes críticos", "Costo", "Media", "Medio", "Establecer contratos sólidos y buscar proveedores alternativos."),
("Incumplimiento de estándares de regulación y calidad", "Calidad", "Media", "Alto", "Cumplir con todas las regulaciones y estándares de la industria."),
("Retrasos en la entrega de software", "Tiempo", "Alta", "Alto", "Planificar adecuadamente y establecer márgenes de tiempo realistas."),
("Conflictos dentro del equipo de desarrollo", "Recursos", "Media", "Medio", "Fomentar la comunicación y resolver conflictos prontamente."),
("Insuficiencia de pruebas del usuario final", "Calidad", "Media", "Alto", "Involucrar al usuario final en las pruebas desde etapas tempranas."),
("Falta de documentación adecuada", "Calidad", "Media", "Medio", "Establecer estándares de documentación y seguimiento continuo."),
("Variaciones en la disponibilidad de recursos", "Costo", "Alta", "Medio", "Gestionar eficazmente los recursos y planificar la rotación."),
("Riesgos asociados a la seguridad de datos", "Calidad", "Alta", "Alto", "Implementar medidas de seguridad de datos robustas."),
("Problemas de compatibilidad entre sistemas", "Calidad", "Media", "Alto", "Garantizar compatibilidad a través de pruebas y validaciones."),
("Cambio de persona responsable durante y después del proyecto", "Recursos", "Media", "Alto", "Crear planes de transición por si pasa esto.");
    