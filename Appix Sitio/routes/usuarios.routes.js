const express = require('express')
const controller = require('../controllers/usuarios.controller')
const isAuth = require('../utils/is-auth')
const sessionChecker = require('../utils/sessionTimer')

const router = express.Router()

router.use(sessionChecker)

router.get('/login', controller.get_registro)
router.post('/login', controller.do_login)
router.get('/homePage', isAuth, controller.get_homePage)
router.get('/control', isAuth, controller.get_control)
router.post('/cambiarRol', isAuth, controller.cambiarRol)
router.post('/registro', isAuth, controller.registrar_usuario)
router.post('/eliminarUsuario', isAuth, controller.eliminarUsuario)
router.post('/salir', controller.cerrar_sesion)
module.exports = router 