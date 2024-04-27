import express from 'express'
import { autenticar } from './database.js'

const app = express()

app.use(express.urlencoded({ extended: true }))
app.use(express.json())

app.set("view engine", "ejs")


app.get('/', (req, res) => {
    res.render('signIn.ejs')
})

app.get("/homePage", (req, res) => {
    res.render("homePage.ejs")
})

app.get("/visual", (req, res) => {
    res.render("visual.ejs")
})

app.post("/autenticar", (req, res) => {
    const { usuario, contrasena } = req.body
    const response = autenticar(usuario, contrasena)
    if (response == "yes") {
        res.render("homePage.ejs")
    } else {
        res.render("signIn.ejs")
    }
})

app.use((err, req, res, next) => {
    console.error(err.stack)
    res.status(500).send('Something broke')
})

app.use(express.static("public"))


app.listen(8000, () => {
    console.log("Server started on port 8000")
})