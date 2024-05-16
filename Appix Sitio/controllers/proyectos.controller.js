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
    console.log("result of fetching project info")
    console.log(proyectoObject)

    const riesgosObjectsArray = await model.Project.getRiesgos(proyectoID)
    console.log("result of fetching riesgos of project")
    console.log(riesgosObjectsArray)

    res.render("proyectos/proyecto.ejs", {
        user,
        proyectoObject,
        riesgosObjectsArray
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