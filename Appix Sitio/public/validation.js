document.getElementById('entrar').addEventListener('submit', (event) => {
    event.preventDefault()
    let usuario = document.getElementById('nombre').value
    let pass = document.getElementById('password').value
    console.log(usuario)
    console.log(pass)

    // const forbiddenChars = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;


    if (usuario == null || pass == null) {
        const warning = document.getElementById('warning-empty')
        warning.classList.remove('hidden')
        
    } else if (forbiddenChars.test(usuario)) {
        const warning = document.getElementById('warning-chars')
        warning.classList.remove('hidden')
    } else {
        let warning = document.querySelector(".warning")
        warning.classList.remove('hidden')
    }
}) 

document.getElementById('search-input').addEventListener('input', e => {
    e.preventDefault()
    const input = e.target.value
    
})