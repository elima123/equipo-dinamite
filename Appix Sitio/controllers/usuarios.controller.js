// import model from '../models/usuarios.model.js'
// import bcyrpt from 'bcryptjs'
const model = require('../models/usuarios.model')
const bcyrpt = require('bcryptjs')

module.exports.render_login = async (req, res) => {
    res.render("usuarios/signIn.ejs")
}

module.exports.do_login = async (req, res) => {
    try {
        const userNombre = req.body.nombre
        const userContrasena = req.body.contrasena

        // const usuarios = await model.User.findUser(userNombre)
        const usuarios = await model.User.verifyUser(userNombre, userContrasena)
        const usuario = usuarios[0]
        // if (!usuario) {
        //     res.render("usuarios/registro")
        // }
        if (usuario.length < 1) {
            res.render("usuarios/signIn.ejs")
            return
        }
        userObject = usuario[0]

        // const isValid = await model.User.verifyUser();

        // const doMatch = await bcyrpt.compare(req.body.contrasena)

        // if(!doMatch) {
        //     res.render("usuarios/registro.ejs")
        //     return
        // }

        req.session.nombre = userObject.Nombre
        req.session.pass = userObject.Contrasena
        
        req.session.isLoggedIn = true
        res.status(201).redirect("/usuarios/homePage")
    } catch (e) {
        console.error(e)
        res.render("usuarios/signIn.ejs")
    }
}

module.exports.get_registro = async (req, res) => {
    if (req.session.isLoggedIn) {
        res.status(201).redirect("/usuarios/homePage")
        return
    }
    res.render("usuarios/signIn.ejs")
}

// module.exports.post_registro = async (req, res) => {
//     try {
//         const { username, name, password } = req.body
//         const user = new model.User(username, name, password)
//         const savedUser = await user.save()

//         res.status(201).redirect("usuarios/login.ejs")
//     } catch(e) {
//         console.error(e)
//         res.status(500).json({ message: "Error registering user "})
//     }
// }

module.exports.get_homePage = async (req, res) => {
    try {
        if (!req.session.isLoggedIn) {
            res.status(400).redirect("/usuarios/login")
            return
        }

        const userNombre = req.session.nombre
        const userContrasena = req.session.pass

        const usuarios = await model.User.verifyUser(userNombre, userContrasena)
        const usuario = usuarios[0]

        if (usuario.length < 1) {
            res.render("usuarios/signIn.ejs")
            return
        }
        const userObject = usuario[0]

        let proyectos
        if (userObject.Rol == "manager") {
            const proyectosAccesibles = await model.User.getProyectosManager()
            proyectos = proyectosAccesibles[0]
        }
        if (userObject.Rol == "desarrollador") {
            const proyectosAccesibles = await model.User.getProyectosDes(userObject.IDUsuario)
            console.log(proyectosAccesibles)
            proyectos = proyectosAccesibles[0]
        }

        let array_riesgos = []
        for (let i = 0; i < proyectos.length; i++) {
            const curr_id = proyectos[i].IDProyecto
            const riesgos = await model.User.getRiesgos(curr_id)
            array_riesgos.push(riesgos)
        }
        const combinedData = proyectos.map((project, i) => {
            const projectRiesgos = array_riesgos[i].filter(riesgo => riesgo.IDProyecto === project.IDProyecto)
            return { ...project, riesgos: projectRiesgos }
        })
        // console.log(combinedData)

        res.render("usuarios/homePage.ejs", {
            user: userObject,
            projects: combinedData
            // projects: proyectos,
            // riesgos: array_riesgos
        })
    } catch(e) {
        throw e
    }
}

// <% riesgos.forEach(project => { %>
//     <% project.map((relationship, i) => { %>
//         <p>Riesgo #<%= i+1 %>: <%= relationship.IDRiesgo %></p>
//     <% }) %>
// <% }) %>