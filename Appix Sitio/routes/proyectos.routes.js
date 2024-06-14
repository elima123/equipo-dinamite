const express = require('express')
const controller = require('../controllers/proyectos.controller')
const isAuth = require('../utils/is-auth')
const sessionChecker = require('../utils/sessionTimer')

const router = express.Router()

router.use(sessionChecker)

router.get('/historia', isAuth, controller.getHistoria)
router.get("/:IDProyecto", isAuth, controller.get_proyecto)
router.post('/registro', isAuth, controller.registrar_proyecto)
router.post('/cerrar', isAuth, controller.cerrarProyecto)
router.post('/crearRiesgo', isAuth, controller.crearRiesgo)
router.post('/quitarDev', isAuth, controller.quitarDev)
router.post('/agregarDev', isAuth, controller.agregarDev)
router.post("/editarRiesgo", isAuth, controller.editarRiesgo)
router.post("/editarProyecto", isAuth, controller.editar_proyecto)

module.exports = router