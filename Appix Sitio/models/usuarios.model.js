// import db from '../utils/database.js'
// import bcrypt from 'bcryptjs'
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
            return result
        } catch(e) {
            throw e
        }
    }

    static async getProyectosManager() {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT p.*, e.Nombre AS nombreEmpresa
            FROM Proyectos as p
            INNER JOIN Empresas as e ON p.IDEmpresa = e.IDEmpresa
            `)
            await connection.release()
            return result
        } catch (e) {
            throw e
        }
    }

    static async getRiesgos(id) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            SELECT IDProyecto, IDRiesgo FROM ProyectoRiesgos WHERE IDProyecto = ?
            `, [id])
            const riesgoObject = result[0]
            return riesgoObject
        } catch(e) {
            throw e
        }
    }
} 