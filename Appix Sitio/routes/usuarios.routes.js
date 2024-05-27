const express = require('express')
const controller = require('../controllers/usuarios.controller')
const isAuth = require('../utils/is-auth')

const router = express.Router()

router.get('/login', controller.get_registro)
router.post('/login', controller.do_login)
router.get('/homePage', isAuth, controller.get_homePage)
// router.post('/homePage', isAuth, controller.order_homePage)
router.get('/control', isAuth, controller.get_control)
router.post('/salir', controller.cerrar_sesion)
module.exports = router 