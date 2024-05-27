const db = require('../utils/database')
const bcrypt = require('bcryptjs')

exports.login = function (usuario, password) {
    return {
        nombre: "Samuel",
        id:1,
        activo: true
    }
}

exports.User = class {
    constructor(my_username, my_name, my_password) {
        this.username = my_username,
        this.name = my_name,
        this.password = my_password
    }

    async save() {
        try {
            const connection = await db()
            const hashedPass = await bcrypt.hash(this.password, 12)
            const result = await connection.execute(
            `INSERT INTO users (username, name, password)
            VALUES (?, ?, ?)`, 
            [this.username, this.name, this.password]
            )
        } catch(e) {
            console.error(e)
            throw e
        }
    }

    static async findUser(nombre) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT * FROM Usuarios WHERE Correo = ?`,
            [nombre])
            await connection.release()
            console.log("next line is result of findUser model function")
            console.log(result)
            return result
        } catch(e) {
            throw e
        }
    }
    static async verifyUser(correo, contrasena) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT * FROM Usuarios WHERE Correo = ? AND Contrasena = ?`,
            [correo, contrasena])
            await connection.release()
            const realResult = result[0][0]
            return realResult
        } catch(e) {
            throw e
        } 
    }

    static async getProyectosManager() {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT p.*, DATE_FORMAT(FechaInicio, '%d/%m/%Y') AS start,
			DATE_FORMAT(FechaFinal, '%d/%m/%Y') AS end,
            e.nombre AS nombreEmpresa,
            ROUND((((1-(SUM(r.ImpactoNumerico)))/1)*100), 0) AS Viabilidad
            FROM Proyectos as p
            INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa
            LEFT JOIN ProyectoRiesgos as pr ON p.IDProyecto = pr.IDProyecto
            LEFT JOIN Riesgos as r ON pr.IDRiesgo = r.IDRiesgo
            GROUP BY p.IDProyecto
            `)
            await connection.release()
            const realResult = result[0]
            return realResult
        } catch (e) {
            throw e
        }
    }  

    static async getProyectosDes(idUsuario) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT p.*, DATE_FORMAT(FechaInicio, '%d/%m/%Y') AS start,
			            DATE_FORMAT(FechaFinal, '%d/%m/%Y') AS end,
            e.nombre AS nombreEmpresa,
            ROUND((((1-(SUM(r.ImpactoNumerico)))/1)*100), 0) AS Viabilidad
            FROM Proyectos as p
            INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa
            JOIN ProyectoRiesgos as pr ON p.IDProyecto = pr.IDProyecto
            JOIN Riesgos as r ON pr.IDRiesgo = r.IDRiesgo
            JOIN UsuarioProyectos as up ON p.IDProyecto = up.IDProyecto
            WHERE up.IDUsuario = ?
            GROUP BY p.IDProyecto
            `,[idUsuario])
            await connection.release()
            const realResult = result[0]
            return realResult
        } catch(e) {
            throw e
        }
    }
} 

exports.getUsuarios = async function () {
    try {
        const connection = await db()
        const result = await connection.execute(`
        SELECT * FROM Usuarios
        `)
        await connection.release()
        const realResult = result[0]
        return realResult
    } catch (e) {
        throw e
    }
} 