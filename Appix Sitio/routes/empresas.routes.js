const express = require('express')
const controller = require('../controllers/empresas.controller')
const isAuth = require('../utils/is-auth')

const router = express.Router()

router.get('/test_json', (req, res) => {
    res.status(200).json({status: 200, message: "it works"})
})
router.post('/registro', controller.registrar_empresa)

module.exports = router