const express = require('express')
const controller = require('../controllers/proyectos.controller')
const isAuth = require('../utils/is-auth')

const router = express.Router()

router.get("/:IDProyecto", isAuth, controller.get_proyecto)
router.post('/registro', controller.registrar_proyecto)

//<!-- IMPLEMENTACIÓN : FUNCIONALIDAD DEL BOTÓN "Editar Riesgos" -->  
router.post("/editarRiesgo", controller.editarRiesgo)
//<!-- IMPLEMENTACIÓN : FUNCIONALIDAD DEL BOTÓN "Editar Riesgos" -->  

module.exports = router