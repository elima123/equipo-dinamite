const db = require('../utils/database')
const bcrypt = require('bcryptjs')

exports.Project = class {
    static async getProject(id) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT * FROM Proyectos WHERE IDProyecto = ?`,
            [id])
            await connection.release()
            const realResult = result[0][0]
            return realResult
        } catch(e) {
            throw e
        }
    }
} 