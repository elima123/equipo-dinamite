const generalView = document.querySelector(".general-view")
const riesgosView = document.querySelector(".riesgos-view")
const analisisView = document.querySelector(".analisis-view")
const navtab1 = document.querySelector("#navtab-1")
const navtab2 = document.querySelector("#navtab-2")
const navtab3 = document.querySelector("#navtab-3")

function viewInfo() {
    riesgosView.classList.add('hidden')
    analisisView.classList.add('hidden')
    navtab2.classList.remove('active')
    navtab3.classList.remove('active')

    generalView.classList.remove('hidden')
    navtab1.classList.add('active')

}

function viewRiesgos() {
    generalView.classList.add('hidden')
    analisisView.classList.add('hidden')
    navtab1.classList.remove('active')
    navtab3.classList.remove('active')

    riesgosView.classList.remove('hidden')
    navtab2.classList.add('active')
}

function viewAnalisis() {
    generalView.classList.add('hidden')
    riesgosView.classList.add('hidden')
    navtab1.classList.remove('active')
    navtab2.classList.remove('active')

    analisisView.classList.remove('hidden')
    navtab3.classList.add('active')
}