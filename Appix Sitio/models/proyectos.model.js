const db = require('../utils/database')
const bcrypt = require('bcryptjs')

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