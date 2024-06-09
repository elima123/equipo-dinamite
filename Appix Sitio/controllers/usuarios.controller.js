const model = require('../models/usuarios.model')
const modelEmp = require('../models/empresas.model')
const modelProj = require('../models/proyectos.model')

module.exports.render_login = async (req, res) => {
    res.render("usuarios/signIn.ejs")
}

module.exports.do_login = async (req, res) => {
    try {
        const userCorreo = req.body.correo
        const userContrasena = req.body.contrasena

        const usuario = await model.User.verifyUser(userCorreo, userContrasena)
        
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

module.exports.get_homePage = async (req, res) => {
    try {
        const userCorreo = req.session.correo
        const userContrasena = req.session.pass

        const usuario = await model.User.verifyUser(userCorreo, userContrasena)

        if (!usuario) {
            res.render("usuarios/signIn.ejs")
            return
        }

        let proyectos
        if (usuario.Rol == "manager") {
            proyectos = await model.User.getProyectosManager()
        } else if (usuario.Rol == "desarrollador") {
            proyectos = await model.User.getProyectosDes(usuario.IDUsuario)
        }

        // let pastProyectos
        // if (usuario.Rol == "manager") {
        //     pastProyectos = await model.User.getPastProyectosM()
        // } else if (usuario.Rol == "desarrollador") {
        //     pastProyectos = await model.User.getPastProyectosD(usuario.IDUsuario)
        // }



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

module.exports.get_control = async (req, res) => {
    try {
        const userCorreo = req.session.correo
        const userContrasena = req.session.pass

        const usuario = await model.User.verifyUser(userCorreo, userContrasena)

        if (!usuario) {
            res.render("usuarios/signIn.ejs")
            return
        }

        const usuarios = await model.getUsuarios()

        const usuariosProyectos = await model.usuarioProyectos()

        res.render('usuarios/control.ejs', {
            usuario,
            usuarios,
            usuariosJSON: JSON.stringify(usuarios),
            usuarioProyectosJSON: JSON.stringify(usuariosProyectos),
        })

    } catch (e) {
        throw e
    }
}

module.exports.order_homePage = async (req, res) => {
    try {
        const filter = req.body.filter
        console.log(filter)

        const userCorreo = req.session.correo
        const userContrasena = req.session.pass

        const usuario = await model.User.verifyUser(userCorreo, userContrasena)

        let proyectos
        if (usuario.Rol == 'manager') {
            proyectos = await model.User.getProyectosManager(filter)
        } else if (usuario.Rol == 'desarrollador'){
            proyectos = await model.User.getProyectosDes(usuario.IDUsuario, filter)
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

module.exports.registrar_usuario = async (req, res) => {
    try {
        const userCorreo = req.session.correo
        const userContrasena = req.session.pass

        const usuario = await model.User.verifyUser(userCorreo, userContrasena)

        if (usuario.Rol != "manager") {
            res.render("usuarios/signIn.ejs")
            return
        }

        const { nombre, correo, contrasena, rol } = req.body

        const newUsuario = await model.createUser(nombre, correo, contrasena, rol)

        res.status(201).redirect("/usuarios/control")

    } catch (e) {
        throw e
    }
}

module.exports.cambiarRol = async (req, res) => {
    try {
        const IDUsuario = req.body.idUsuario

        const result = await model.User.cambiarRol(IDUsuario)

        res.redirect('back')

    } catch (e) {
        throw e
    }
}

module.exports.eliminarUsuario = async (req, res) => {
    try {
        const IDUsuario = req.body.idUsuario

        const result = await model.User.eliminarUsuario(IDUsuario)

        res.redirect('back')
    } catch (e) {
        throw e
    }
}

module.exports.cerrar_sesion = (req, res) => {
    try {
        req.session.destroy((err) => {
            if (err) {
                throw err
            }
            res.render('usuarios/signIn.ejs')
        })
    } catch (e) {
        throw e
    }
}