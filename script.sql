CREATE DATABASE appix;
use appix;

select * from usuarios;
CREATE TABLE Usuarios (
	IDUsuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	Nombre VARCHAR(30),
    Contrasena VARCHAR(20)
    );
    
ALTER TABLE Usuarios
ADD COLUMN Rol ENUM("desarrollador", "manager");
    
DELETE FROM Usuarios WHERE IDUsuario > 20;
    
UPDATE Usuarios
SET Rol = "desarrollador" WHERE IDUsuario > 3;

INSERT INTO Usuarios (Nombre, Contrasena)
VALUES
("Carlos López", "Carlos123"),
("Sofia Martinez", "Sofia456"),
("Alejandro Ramirez", "Alejandrito789"),
("Valeria Hernandez", "Valeria1234"),
("Diego Gonzalez", "Diego4567"),
("Ana Rodriguez", "Ana7890"),
("Luisa Sanchez", "Luisa12345"),
("Jorge Cruz", "Jorge6789"),
("Natalia Garcia", "Natalia123"),
("Rodrigo Torres", "Rodrigo456"),
("Maria Flores", "Maria789"),
("Eduardo Diaz", "Eduardo1234"),
("Andrea Vazquez", "Andrea5678"),
("Francisco Reyes", "Francisco12345"),
("Pamela Torres", "Pamela6789"),
("Javier Gomez", "Javier123"),
("Daniela Martinez", "Daniela456"),
("Sergio Hernandez", "Sergio789"),
("Adriana Aguilar", "Adriana1234"),
("Ricardo Mendoza", "Ricardo5678");    

    
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
MODIFY COLUMN Descripcion VARCHAR(240);

INSERT INTO Proyectos (IDEmpresa, Nombre, Descripcion, Estado, FechaInicio, FechaFinal, Costo)
VALUES
(4, "TiendaOnline.com", "Una tienda en linea para venta de zapatos", "activo", "2024-02-28","2024-08-28", 200000);
    

    
INSERT INTO Proyectos (IDEmpresa, Nombre, Descripcion, Estado, FechaInicio, FechaFinal, Costo)
VALUES
(1, "Proyecto Beta", "Desarrollo de plataforma e-commerce", "activo", "2024-02-15", "2024-09-30", 200000),
(2, "Proyecto Gamma", "Optimización de procesos logísticos", "activo", "2024-03-10", "2024-08-15", 120000),
(3, "Proyecto Delta", "Diseño de nuevo producto tecnológico", "activo", "2024-04-20", "2024-11-10", 180000),
(5, "Proyecto Epsilon", "Implementación de estrategia de marketing digital", "activo", "2024-05-05", "2024-12-20", 160000),
(6, "Proyecto Zeta", "Desarrollo de aplicación móvil", "activo", "2024-06-30", "2025-01-31", 220000),
(7, "Proyecto Eta", "Reestructuración de sistemas informáticos", "activo", "2024-07-15", "2025-02-28", 190000),
(8, "Proyecto Theta", "Investigación de mercado internacional", "activo", "2024-08-10", "2025-03-15", 250000),
(9, "Proyecto Iota", "Implementación de sistema de gestión ambiental", "activo", "2024-09-25", "2025-04-30", 210000);
    
select * from empresas;
CREATE TABLE Empresas (
	IDEmpresa INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(30),
    Telefono VARCHAR(12),
    Correo VARCHAR(30)
    );
    
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
    
select * from UsuarioProyectos;
CREATE TABLE UsuarioProyectos (
	IDUsuario INT,
    IDProyecto INT,
    
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios (IDUsuario),
    FOREIGN KEY (IDProyecto) REFERENCES Proyectos (IDProyecto)
    );
    
INSERT INTO UsuarioProyectos (IDUsuario, IDProyecto)
VALUES
(1, 3);
        
select * from ProyectoRiesgos;
CREATE TABLE ProyectoRiesgos (
	IDProyectoRiesgo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	IDProyecto INT,
    IDRiesgo INT,

    FOREIGN KEY (IDProyecto) REFERENCES Proyectos (IDProyecto),
    FOREIGN KEY (IDRiesgo) REFERENCES Riesgos (IDRiesgo)
    );

INSERT INTO ProyectoRiesgos (IDProyecto, IDRiesgo)
VALUES 
(7, 1),
(7, 5),
(7, 6),
(7, 8),
(7, 10),
(7, 11),
(7, 13),
(7, 16),
(7, 19),
(7, 22),
(7, 27),
(7, 28),
(7, 31);

    
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
    