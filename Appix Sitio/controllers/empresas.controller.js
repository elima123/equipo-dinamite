const model = require('../models/empresas.model')
const bcyrpt = require('bcryptjs')

module.exports.registrar_empresa = async (req, res) => {
    try {
        const nombre = req.body.Nombre
        const telefono = req.body.Telefono
        const correo = req.body.Correo

        const result = await model.Empresa.registrarEmpresa(nombre, telefono, correo)
        if (result == "yes") {
            res.redirect('/usuarios/homePage')
        } else {
            
        }
    } catch (e) {
        throw e
    }
}