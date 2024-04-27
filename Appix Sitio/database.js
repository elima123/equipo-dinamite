import mysql from 'mysql2'

const pool = mysql.createPool({
    host: "127.0.0.1",
    user: "root",
    password: "appix",
    database: "appix"
}).promise()

export async function autenticar(usuario, contra) {
    const [rows] = await pool.query(`
    SELECT * FROM wrappers
    WHERE wrapperStatus = 'active'
    `)
    return rows
}