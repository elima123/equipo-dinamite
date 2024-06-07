const express = require('express')
const controller = require('../controllers/proyectos.controller')
const isAuth = require('../utils/is-auth')
const sessionChecker = require('../utils/sessionTimer')

const router = express.Router()

router.use(sessionChecker)

router.get("/:IDProyecto", isAuth, controller.get_proyecto)
router.post('/registro', isAuth, controller.registrar_proyecto)
router.post('/cerrar', isAuth, controller.cerrarProyecto)

//<!-- IMPLEMENTACIÓN : FUNCIONALIDAD DEL BOTÓN "Editar Riesgos" -->  
router.post("/editarRiesgo", isAuth, controller.editarRiesgo)
//<!-- IMPLEMENTACIÓN : FUNCIONALIDAD DEL BOTÓN "Editar Riesgos" -->  

module.exports = router