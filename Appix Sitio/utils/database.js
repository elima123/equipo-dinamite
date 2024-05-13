// import mysql from 'mysql2'
const mysql = require('mysql2')

const pool = mysql.createPool({
    host: "127.0.0.1",
    user: "root",
    password: "",
    database: "appix"
}).promise()

module.exports = async () => {
    try {
        const connection = await pool.getConnection()
        return connection
    } catch(e) {
        throw e
    }
}

// export async function autenticar(usuario, contra) {
//     const [rows] = await pool.query(`
//     SELECT * FROM wrappers
//     WHERE wrapperStatus = 'active'
//     `)
//     return rows
// }