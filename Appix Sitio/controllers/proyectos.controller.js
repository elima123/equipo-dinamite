const model = require('../models/proyectos.model')
const modelEmp = require('../models/empresas.model')
const modelUser = require('../models/usuarios.model')

module.exports.render_login = async (req, res) => {
    res.render("usuarios/signIn.ejs")
}

module.exports.get_proyecto = async (req, res) => {
    const user = {
        name: req.session.nombre,
        rol: req.session.rol
    }

    const proyectoID = req.params.IDProyecto

    const proyectoObject = await model.Project.getProject(proyectoID)
    if (proyectoObject.Viabilidad < 0) {
        proyectoObject.Viabilidad = 0
    } else if (proyectoObject.Viabilidad == null) {
        proyectoObject.Viabilidad = 100
    }

    const riesgos = await model.Project.getRiesgos(proyectoID)

    const proyectoRiesgos = await model.Project.getProyectoRiesgos(proyectoID)

    const projectDevs = await model.Project.getProjDevs(proyectoID)

    const allDevs = await model.Project.getAllDevs()

    const nonDevs = allDevs.filter(dev => {
        ya = false
        for (i = 0; i < projectDevs.length; i++) {
            if (dev.IDUsuario == projectDevs[i].IDUsuario) {
                ya = true
                break
            }
        }
        if (ya == false) {
            return dev
        }
    })

    let allRiesgos = await model.Project.getAllRiesgos()

    allRiesgos = allRiesgos.map(riesgo => {
        const isActive = riesgos.some(r => r.IDRiesgo === riesgo.IDRiesgo)
        return {...riesgo, active: isActive}
    })

    res.render("proyectos/proyecto.ejs", {
        user,
        proyectoObject,
        proyectosJSON: JSON.stringify(proyectoObject),
        riesgos,
        riesgosJSON: JSON.stringify(riesgos),
        projectDevs,
        nonDevs,
        allRiesgos,
        proyectoRiesgosJSON: JSON.stringify(proyectoRiesgos)
    })
}

module.exports.getHistoria = async (req, res) => {
    try {
        const userCorreo = req.session.correo
        const userContrasena = req.session.pass

        const usuario = await modelUser.User.verifyUser(userCorreo, userContrasena)

        if (!usuario) {
            res.render("usuarios/signIn.ejs")
            return
        }

        let proyectos
        if (usuario.Rol == "manager") {
            proyectos = await model.Project.getHistoriaManager()
        } else if (usuario.Rol == "desarrollador") {
            proyectos = await model.Project.getHistoriaDes(usuario.IDUsuario)
        }

        if (!proyectos) {
            const projects = []
            res.render("proyectos/historia.ejs", {
                user: usuario,
                projects
            })
        } else {
            let combinedData = proyectos.map((project) => {
                if (project.Viabilidad < 0) {
                    project.Viabilidad = 0
                } else if (project.Viabilidad == null) {
                    project.Viabilidad = 100
                }
                return {...project, active: false}
            })
    
            const numPages = Math.ceil(combinedData.length/9)
    
            const empresas = await modelEmp.Empresa.getEmpresaNames()
    
            res.render("proyectos/historia.ejs", {
                user: usuario,
                projects: combinedData,
                projectsJSON: JSON.stringify(combinedData),
                empresas,
                numPages
            })
        }

    } catch(e) {
        throw e
    }
}

module.exports.registrar_proyecto = async (req, res) => {
    try {
        if (req.session.isLoggedIn == false) {
            console.log("paso por aqui")
            res.redirect('/usuarios/login')
        }

        const { nombre, nombreEmpresa, desc, costo, fechaI, fechaF } = req.body

        const result = await model.Project.registrarProyecto(nombre, nombreEmpresa, desc, costo, fechaI, fechaF)

        // if (result == "yes") {
        //     res.redirect('/usuarios/homePage')
        // } else {

        // }
        res.redirect('/usuarios/homePage')
    } catch (e) {
        throw e
    }
}

module.exports.editar_proyecto = async (req, res) => {
    try {
        const { idProyecto, nombre, descripcion, fechaInicio, fechaFinal, costo} = req.body

        const result = await model.Project.editProyectoInfo(nombre, descripcion, fechaInicio, fechaFinal, costo, idProyecto)

        res.redirect('back')

    } catch (e) {
        throw e
    }
}

module.exports.quitarDev = async (req, res) => {
    try {
        const { idUsuario, idProyecto} = req.body

        const result = await model.Project.quitarDev(idUsuario, idProyecto)

        res.redirect('back')

    } catch (e) {
        throw e
    }
}

module.exports.agregarDev = async (req, res) => {
    try {
        const { idUsuario, idProyecto} = req.body

        const result = await model.Project.agregarDev(idUsuario, idProyecto)

        res.redirect('back')
    } catch (e) {
        throw e
    }
}

module.exports.cerrarProyecto = async (req, res) => {
    try {
        const { idProyecto, razon } = req.body

        const result = await model.Project.cerrarProyecto(razon, idProyecto)

        res.redirect('/usuarios/homePage')
    } catch (e) {
        throw e
    }
}

module.exports.crearRiesgo = async (req, res) => {
    try {
        if (req.session.isLoggedIn == false) {
            console.log("paso por aqui")
            res.redirect('/usuarios/login')
        }

        const { idProyecto, riesgo, categoria, probabilidad, impacto, estrategia } = req.body

        let impactoNumerico = 0
        if (impacto == "Alto") {
            impactoNumerico = 0.05
        } else if (impacto == "Medio") {
            impactoNumerico = 0.03
        } else if (impacto == "Bajo") {
            impactoNumerico = 0.02
        }

        const result = await model.Project.crearRiesgo(riesgo, categoria, probabilidad, impacto, estrategia, impactoNumerico, idProyecto)

        res.redirect('back')
    } catch (e) {
        throw e
    }
}

// <!-- IMPLEMENTACIÓN : FUNCIONALIDAD DEL BOTÓN "Editar Riesgos" -->  
module.exports.editarRiesgo = async (req, res) => {
    try {
        const idProyecto = req.body.idProyecto
        // Iterar sobre cada checkbox
        for (let i = 1; i <= 32; i++) {
            const checkboxName = 'Checkbox' + i; // Nombre de la checkbox
            const checkboxValue = req.body[checkboxName] === 'on'; // Valor de la checkbox

            if (checkboxValue) {
                const result = await model.Project.agregarRiesgo(idProyecto, i)
            } else {
                const result = await model.Project.removerRiesgo(idProyecto, i)
            }

        }
        const urlBack = "/proyecto/" + idProyecto
        res.redirect(urlBack)
    } catch (e) {
        throw e
    }
}
// <!-- IMPLEMENTACIÓN : FUNCIONALIDAD DEL BOTÓN "Editar Riesgos" -->  