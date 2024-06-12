module.exports = function (req, res, next) {
    const currentTime = Date.now()
    const sessionTimeout = 600000
    const lastActiveTime = req.session.lastActiveTime

    if (!lastActiveTime) {
        req.session.lastActiveTime = currentTime
    } else {
        const difference = currentTime - lastActiveTime

        if (difference > sessionTimeout) {
            console.log("destroying session")
            req.session.destroy((err) => {
                if (err) {
                    console.error('Error destroying session:', err)
                }
                return res.redirect('/usuarios/login')
            });
            return
        }
    }

    // Update last active time
    req.session.lastActiveTime = currentTime
    next()
}