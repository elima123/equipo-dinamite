const express = require('express')
const controller = require('../controllers/proyectos.controller')
const isAuth = require('../utils/is-auth')

const router = express.Router()

router.get('/test_json', (req, res) => {
    res.status(200).json({status: 200, message: "it works"})
})
router.get("/:IDProyecto", isAuth, controller.get_proyecto)
router.post('/registro', controller.registrar_proyecto)
// router.get('/login', controller.get_registro)
// router.post('/login', controller.do_login)
// router.get('/homePage', controller.get_homePage)

module.exports = router