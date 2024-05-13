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
            SELECT * FROM Usuarios WHERE Nombre = ?`,
            [nombre])
            await connection.release()
            console.log("next line is result of findUser model function")
            console.log(result)
            return result
        } catch(e) {
            throw e
        }
    }
    static async verifyUser(nombre, contrasena) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT * FROM Usuarios WHERE Nombre = ? AND Contrasena = ?`,
            [nombre, contrasena])
            await connection.release()
            const realResult = result[0]
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
            e.Nombre AS nombreEmpresa
            FROM Proyectos as p
            INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa
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
            e.Nombre AS nombreEmpresa
            FROM Proyectos as p
            INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa
            INNER JOIN UsuarioProyectos as up ON up.IDProyecto = p.IDProyecto
            WHERE up.IDUsuario = ?;
            `,[idUsuario])
            await connection.release()
            const realResult = result[0]
            return realResult
        } catch(e) {
            throw e
        }
    }
} 

exports.Project = class {
    // constructor(my_username, my_name, my_password) {
    //     this.username = my_username,
    //     this.name = my_name,
    //     this.password = my_password
    // }

    static async getRiesgos(id) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT IDProyecto, IDRiesgo FROM ProyectoRiesgos WHERE IDProyecto = ?
            `, [id])
            await connection.release()
            const riesgoObject = result[0]
            return riesgoObject
        } catch(e) {
            throw e
        }
    }

    static async riesgoInfo(id) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT Categoria, Impacto FROM Riesgos WHERE IDRiesgo = ?
            `,[id])
            await connection.release()
            const neededInfo = result[0]
            return neededInfo
        } catch(e) {
            throw e
        }
    }
}