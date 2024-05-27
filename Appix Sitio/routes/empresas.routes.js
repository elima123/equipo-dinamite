const express = require('express')
const controller = require('../controllers/empresas.controller')
const isAuth = require('../utils/is-auth')

const router = express.Router()

router.post('/registro', controller.registrar_empresa)

module.exports = router