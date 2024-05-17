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

    const riesgosObjectsArray = await model.Project.getRiesgos(proyectoID)

    res.render("proyectos/proyecto.ejs", {
        user,
        proyectoObject,
        riesgos: riesgosObjectsArray,
        riesgosJSON: JSON.stringify(riesgosObjectsArray)
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