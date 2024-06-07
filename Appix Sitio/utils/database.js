const mysql = require('mysql2')

const pool = mysql.createPool({
    host: "127.0.0.1",
    user: "root",
    password: "",
    database: "appix",
    connectionLimit: 10
}).promise()

module.exports = async () => {
    try {
        const connection = await pool.getConnection()
        return connection
    } catch(e) {
        throw e
    }
}