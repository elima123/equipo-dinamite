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