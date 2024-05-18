const model = require('../models/usuarios.model')
const modelEmp = require('../models/empresas.model')
const bcyrpt = require('bcryptjs')

module.exports.render_login = async (req, res) => {
    res.render("usuarios/signIn.ejs")
}

module.exports.do_login = async (req, res) => {
    try {
        const userNombre = req.body.nombre
        const userContrasena = req.body.contrasena

        const usuario = await model.User.verifyUser(userNombre, userContrasena)
        
        if (!usuario) {
            res.render("usuarios/signIn.ejs")
            return
        }

        req.session.nombre = usuario.Nombre
        req.session.pass = usuario.Contrasena
        req.session.correo = usuario.Correo
        req.session.rol = usuario.Rol
        
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
<<<<<<< Updated upstream
        const userCorreo = req.session.correo
=======
        if (!req.session.isLoggedIn) {
            res.status(400).redirect("/usuarios/login")
            return
        }     

        const userNombre = req.session.nombre
>>>>>>> Stashed changes
        const userContrasena = req.session.pass

        const usuario = await model.User.verifyUser(userCorreo, userContrasena)

        if (!usuario) {
            res.render("usuarios/signIn.ejs")
            return
        }

        let proyectos
        if (usuario.Rol == "manager") {
            proyectos = await model.User.getProyectosManager()
        }
        if (usuario.Rol == "desarrollador") {
            proyectos = await model.User.getProyectosDes(usuario.IDUsuario)
        }

        let combinedData = proyectos.map((project) => {
            return {...project, active: false}
        })


        const numPages = Math.ceil(combinedData.length/9)

        const empresas = await modelEmp.Empresa.getEmpresaNames()

        res.render("usuarios/homePage.ejs", {
            user: usuario,
            projects: combinedData,
            projectsJSON: JSON.stringify(combinedData),
            empresas,
            numPages
        })
    } catch(e) {
        throw e
    }
}

module.exports.cerrar_sesion = (req, res) => {
    try {
        req.session.destroy((err) => {
            if (err) {
                throw err;
            }
            res.render('usuarios/signIn.ejs');
        });
    } catch (e) {
        throw e;
    }
}