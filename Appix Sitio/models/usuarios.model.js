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

    // static async verifyUser(correo, contrasena) {
    //     try {
    //         const connection = await db()
    //         const result = await connection.execute(`
    //         SELECT * FROM Usuarios WHERE Correo = ? AND Contrasena = ?`,
    //         [correo, contrasena])
    //         await connection.release()
    //         const realResult = result[0][0]
    //         return realResult
    //     } catch(e) {
    //         throw e
    //     } 
    // }

    static async verifyUser(correo, contrasena) {
        const connection = await db()
        try {
            await connection.beginTransaction()
    
            const [rows] = await connection.execute(`
                SELECT * FROM Usuarios WHERE Correo = ? AND Contrasena = ?`,
                [correo, contrasena]
            )
    
            const realResult = rows[0]
            
            await connection.commit()
            return realResult
        } catch (e) {
            await connection.rollback()
            throw e
        } finally {
            await connection.release()
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
            WHERE p.Estado = 'activo'
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

    static async cambiarRol(idUsuario) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            UPDATE Usuarios
            SET Rol = 'manager' WHERE IDUsuario = ?
            `, [idUsuario])
            await connection.release()
            return "yes"
        } catch (e) {
            throw e
        }
    }

    static async eliminarUsuario(idUsuario) {
        try {
            const connection = await db()
            const result = await connection.execute(`
            DELETE FROM Usuarios WHERE IDUsuario = ?
            `, [idUsuario])
            await connection.release()
            return "yes"
        } catch (e) {
            throw e
        }
    }
} 

exports.getUsuarios = async function () {
    try {
        const connection = await db()
        const result = await connection.execute(`
        SELECT *, DATE_FORMAT(FechaCreado, '%Y-%m-%d') AS dateAdded
        FROM Usuarios
        `)
        await connection.release()
        const realResult = result[0]
        return realResult
    } catch (e) {
        throw e
    }
} 

exports.createUser = async function (nombre, correo, contrasena, rol) {
    try {
        const connection = await db()
        const result = await connection.execute(`
        INSERT INTO Usuarios (Nombre, Correo, Contrasena, Rol, FechaCreado)
        VALUES (?,?,?,?, NOW())
        `, [nombre, correo, contrasena, rol])
        await connection.release()
        const realResult = result[0]
        return "yes"
    } catch (e) {
        throw e
    }
}

exports.usuarioProyectos = async function () {
    try {
        const connection = await db()
        const result = await connection.execute(`
        SELECT up.*, p.Nombre
        FROM UsuarioProyectos as up
        INNER JOIN Proyectos as p ON up.IDProyecto = p.IDProyecto
        `)
        await connection.release()
        const realResult = result[0]
        return realResult
    } catch (e) {
        throw e
    }
}