use appix;

select * from proyectos;
select * from usuarioproyectos;
select * from riesgos;
select * from proyectoriesgos;

INSERT INTO ProyectoRiesgos (IDProyecto, IDRiesgo, FechaAgregado)
            VALUES
            (5, 1, NOW());
-- 56 to 113
UPDATE ProyectoRiesgos
SET FechaAgrego = '' WHERE IDProyectoRiesgo = 56;

select * from ProyectoRiesgos
where IDProyecto = 3;

SELECT ROUND(r.ImpactoNumerico, 2) AS Impacto,
            pr.FechaAgregado
            FROM Riesgos as r
            INNER JOIN ProyectoRiesgos as pr ON r.IDRiesgo = pr.IDRiesgo
            WHERE pr.IDProyecto = 3;
            
DELETE FROM Riesgos
WHERE IDRiesgo >= 33 AND IDRiesgo <= 44;

DELETE FROM ProyectoRiesgos
WHERE iDRiesgo >= 33 AND IDRiesgo <= 44;