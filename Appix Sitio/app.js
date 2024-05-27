// import express from 'express'
// import { autenticar } from './database.js'
const http = require('http')
const path = require('path')
const cookieParser = require('cookie-parser')
const express = require('express')
const session = require('express-session')
const rutasUsuarios = require('./routes/usuarios.routes')
const rutasProyectos = require('./routes/proyectos.routes')
const rutasEmpresas = require('./routes/empresas.routes')

const app = express()

app.use(express.urlencoded({ extended: true }))
app.use(express.json())
app.use(express.static(path.join(__dirname, 'public')))

app.set("view engine", "ejs")
app.set("views", "views")

app.use(cookieParser())
app.use(session({
    secret: "lleguenatiempocabrones",
    resave: false,
    saveUninitialized: false
}))
app.use('/usuarios', rutasUsuarios)
app.use('/proyecto', rutasProyectos)
app.use('/empresa', rutasEmpresas)

app.get('/', (req, res) => {
    res.setHeader('Content-Type', 'text/plain')
    res.render("Default Text")
    res.end()
})

app.get("*", (req, res) => {
    res.send("Error 404: Page Not Found")
})

app.use((err, req, res, next) => {
    console.error(err.stack)
    res.status(500).send('Something broke')
})

const server = http.createServer((req, res) => {
    console.log(req.url)
})

app.listen(4747, () => {
    console.log("Server started on port 4747")
})