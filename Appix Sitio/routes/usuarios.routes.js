// import express from 'express'
// import controller from '../controllers/usuarios.controller.js'
// import isAuth from '../utils/is-auth.js'
const express = require('express')
const controller = require('../controllers/usuarios.controller')
const isAuth = require('../utils/is-auth')

const router = express.Router()

router.get('/test_json', (req, res) => {
    res.status(200).json({status: 200, message: "it works"})
})
// router.get('/login', controller.render_login)
router.get('/login', controller.get_registro)
router.post('/login', controller.do_login)
router.get('/homePage', controller.get_homePage)

module.exports = router