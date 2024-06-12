const db = require('../utils/database')

exports.Project = class {
    static async getProject(idProyecto) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT p.*, DATE_FORMAT(FechaInicio, '%d/%m/%Y') AS start,
			DATE_FORMAT(FechaFinal, '%d/%m/%Y') AS end,
            e.Nombre AS nombreEmpresa, e.Telefono AS telEmpresa, e.Correo AS correoEmpresa,
            ROUND((((1-(SUM(r.ImpactoNumerico)))/1)*100), 0) AS Viabilidad
            FROM Proyectos as p
            INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa
            LEFT JOIN ProyectoRiesgos as pr ON p.IDProyecto = pr.IDProyecto
            LEFT JOIN Riesgos as r ON pr.IDRiesgo = r.IDRiesgo
            WHERE p.IDProyecto = ?
            GROUP BY p.IDProyecto
            `, [idProyecto])
            await connection.release()
            const realResult = result[0][0]
            return realResult
        } catch(e) {
            throw e
        }  
    }

    static async getRiesgos(idProyecto) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT r.*
            FROM ProyectoRiesgos as pr
            INNER JOIN Riesgos as r ON pr.IDRiesgo = r.IDRiesgo
            WHERE pr.IDProyecto = ?
            ORDER BY IDRiesgo ASC
            `, [idProyecto])
            await connection.release()
            const realResult = result[0]
            return realResult
        } catch(e) {
            throw e
        }
    }

    static async registrarProyecto(name, empresa, desc, costo, fechaInicio, fechaFinal) {
        try {
            const connection = await db() 
            const empresaID = await connection.execute(`
            SELECT IDEmpresa 
            FROM Empresas 
            WHERE Nombre = ?
            `, [empresa])
            const idEmpresa = empresaID[0][0].IDEmpresa
            const result = await connection.execute(`
            INSERT INTO Proyectos (IDEmpresa, Nombre, Descripcion, Estado, FechaInicio, FechaFinal, Costo)
            VALUES (?, ?, ?, "activo", ?, ?, ?)
            `, [idEmpresa, name, desc, fechaInicio, fechaFinal, costo])
            await connection.release()
            return "yes"
        } catch (error) {
            throw error
        }
    }

    static async proyectoNombres() {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT Nombre FROM Proyectos
            `)
            await connection.release()
            const realResult = result[0]
            return realResult
        } catch (e) {
            throw e
        }
    }

    static async getProjDevs(idProyecto) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT up.*, DATE_FORMAT(FechaAgregado, '%Y-%m-%d') AS dateAdded, u.Nombre, u.Rol
            FROM UsuarioProyectos AS up
            INNER JOIN Usuarios AS u ON up.IDUsuario = u.IDUsuario
            WHERE IDProyecto = ?
            `, [idProyecto])
            await connection.release()
            const realResult = result[0]
            return realResult
        } catch (e) {
            throw e
        }
    }

    static async getAllDevs() {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT IDUsuario, Nombre FROM Usuarios
            WHERE Rol = 'desarrollador'
            `)
            await connection.release()
            const realResult = result[0]
            return realResult
        } catch (e) {
            throw e
        }
    }

    static async getAllRiesgos() {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT * FROM Riesgos
            `)
            await connection.release()
            const realResult = result[0]
            return realResult
        } catch (e) {
            throw e
        }
    }

    static async editProyectoInfo(nombre, descripcion, fechaInicio, fechaFinal, costo, idProyecto) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            UPDATE Proyectos 
            SET Nombre = ?, Descripcion = ?, FechaInicio = ?, FechaFinal = ?, Costo = ?
            WHERE IDProyecto = ?
            `,[nombre, descripcion, fechaInicio, fechaFinal, costo, idProyecto])
            await connection.release()
            return "yes"
        } catch (e) {
            throw e
        }
    }

    // static async quitarDev(idUsuario, idProyecto) {
    //     try {
    //         const connection = await db()
    //         const result = await connection.execute(`
    //         DELETE FROM UsuarioProyectos
    //         WHERE IDUsuario = ? AND IDProyecto = ?
    //         `, [idUsuario, idProyecto])
    //         await connection.release()
    //         return "yes"
    //     } catch (e) {
    //         throw e
    //     }
    // }

    static async quitarDev(idUsuario, idProyecto) {
        const connection = await db()
        try {
            await connection.beginTransaction()
    
            const result = await connection.execute(`
                DELETE FROM UsuarioProyectos
                WHERE IDUsuario = ? AND IDProyecto = ?
            `, [idUsuario, idProyecto])
    
            await connection.commit()
            return "yes"
        } catch (e) {
            await connection.rollback()
            throw e;
        } finally {
            await connection.release()
        }
    }
    

    static async agregarDev(idUsuario, idProyecto) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            INSERT INTO UsuarioProyectos (IDUsuario, IDProyecto, FechaAgregado)
            VALUES
            (?, ?, NOW())
            `, [idUsuario, idProyecto])
            await connection.release()
            return "yes"
        } catch (e) {
            throw e
        }
    }

    static async crearRiesgo(riesgo, cat, prob, imp, estr, impNum) {
        try {
            const connection = await db() 
            const result = await connection.execute(`
            INSERT INTO Riesgos (Riesgo, Categoria, Probabilidad, Impacto, Estrategia, ImpactoNumerico)
            VALUES
            (?,?,?,?,?,?)
            `, [riesgo, cat, prob, imp, estr, impNum])       
            await connection.release()
            return "yes"
        } catch (e) {
            throw e
        }
    }

    // <!-- IMPLEMENTACIÓN : FUNCIONALIDAD DEL BOTÓN "Editar Riesgos" -->}
    static async agregarRiesgo(idProyecto, idRiesgo) {
        try {
            const connection = await db() 
            const result = await connection.execute(`
            INSERT INTO proyectoriesgos (IDProyecto, IDRiesgo)
            SELECT ?, ?
            WHERE NOT EXISTS (
                SELECT 1 FROM proyectoriesgos
                WHERE IDProyecto = ? AND IDRiesgo = ?
            );

            `, [idProyecto, idRiesgo, idProyecto, idRiesgo])       
            await connection.release()
            return "yes"
        } catch (error) {
            throw error
        }
    }
    static async removerRiesgo(idProyecto, idRiesgo) {
        try {
            const connection = await db() 
            const result = await connection.execute(`
            DELETE FROM proyectoriesgos WHERE IDProyecto = ? AND IDRiesgo = ?;
            `, [idProyecto, idRiesgo])       
            await connection.release()
            return "yes"
        } catch (error) {
            throw error
        }
    }
    // <!-- IMPLEMENTACIÓN : FUNCIONALIDAD DEL BOTÓN "Editar Riesgos" -->
    
    static async cerrarProyecto(razon, id) {
        try {
            console.log("inside cerrar proyecto")
            console.log(razon)
            console.log(id)
            const connection = await db()
            const result = await connection.execute(`
            UPDATE Proyectos 
            SET estado = 'finalizado', RazonCerrado = ?, FechaCerrado = DATE(NOW())
            WHERE IDProyecto = ?
            `,[razon, id])
            await connection.release()
            return "yes"
        } catch (e) {
            throw e
        }
    }
} 
