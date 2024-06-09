const model = require('../models/proyectos.model')
const bcyrpt = require('bcryptjs')

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

    const riesgos = await model.Project.getRiesgos(proyectoID)

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

    // allRiesgos.map(riesgo => {
    //     for (i = 0; i < riesgos.length; i++) {
    //         if (riesgo.IDRiesgo == resgios[i].IDRiesgo) {
    //             return {...riesgo, active: true }
    //         } else {
    //             return {...riesgo, active: false}
    //         }
    //     }
    // })

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
        allRiesgos
    })
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
        const { razon, idProyecto } = req.body

        const result = await model.Project.cerrarProyecto(idProyecto, razon)

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

        const { riesgo, categoria, probabilidad, impacto, estrategia } = req.body

        let impactoNumerico = 0
        if (impacto == "Alto") {
            impactoNumerico = 0.05
        } else if (impacto == "Medio") {
            impactoNumerico = 0.03
        } else if (impacto == "Bajo") {
            impactoNumerico = 0.02
        }

        const result = await model.Project.crearRiesgo(riesgo, categoria, probabilidad, impacto, estrategia, impactoNumerico)

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