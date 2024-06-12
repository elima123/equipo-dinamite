const express = require('express')
const controller = require('../controllers/empresas.controller')
const isAuth = require('../utils/is-auth')
const sessionChecker = require('../utils/sessionTimer')

const router = express.Router()

router.use(sessionChecker)

router.post('/registro', isAuth, controller.registrar_empresa)

module.exports = router