const db = require('../utils/database')
const bcrypt = require('bcryptjs')

exports.Empresa = class {
    static async registrarEmpresa(name, telefono, correo) {
        try {
            const connection = await db() 
            await connection.beginTransaction()

            const result = await connection.execute(`
            INSERT INTO Empresas (Nombre, Telefono, Correo)
            VALUES (?, ?, ?)
            `, [name, telefono, correo])

            await connection.commit()

            return "yes"
        } catch (error) {
            await connection.rollback()
            throw error
        } finally {
            await connection.release()
        }
    }

    static async getEmpresaNames() {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT e.Nombre 
            FROM Empresas as e
            `)
            await connection.release()
            return result[0]
        } catch (e) {
            throw e
        }
    }
}

exports.Project = class {
    static async getProject(idProyecto) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT p.*, e.Nombre AS nombreEmpresa
            FROM Proyectos as p
            INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa 
            WHERE IDProyecto = ?
            `,[idProyecto])
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
} 