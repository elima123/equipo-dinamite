const model = require('../models/usuarios.model')
const bcyrpt = require('bcryptjs')
const algoritmo = require('../utils/algoritmo')

module.exports.render_login = async (req, res) => {
    res.render("usuarios/signIn.ejs")
}

module.exports.do_login = async (req, res) => {
    try {
        const userNombre = req.body.nombre
        const userContrasena = req.body.contrasena

        // const usuarios = await model.User.findUser(userNombre)
        const usuario = await model.User.verifyUser(userNombre, userContrasena)
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
        req.session.rol = userObject.Rol
        
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
        const userNombre = req.session.nombre
        const userContrasena = req.session.pass

        const usuario = await model.User.verifyUser(userNombre, userContrasena)

        if (usuario.length < 1) {
            res.render("usuarios/signIn.ejs")
            return
        }
        const userObject = usuario[0]

        let proyectos
        if (userObject.Rol == "manager") {
            proyectos = await model.User.getProyectosManager()
        }
        if (userObject.Rol == "desarrollador") {
            proyectos = await model.User.getProyectosDes(userObject.IDUsuario)
        }

        let combinedData = proyectos.map((project) => {
            return {...project, active: false}
        })

        const numPages = Math.ceil(combinedData.length/9)

        res.render("usuarios/homePage.ejs", {
            user: userObject,
            projects: combinedData,
            projectsJSON: JSON.stringify(combinedData),
            numPages
        })
    } catch(e) {
        throw e
    }
}