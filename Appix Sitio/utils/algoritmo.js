module.exports.calcViabilidad = function (exampleArr) {
    let perfectProyecto = [0.2, 0.2, 0.2, 0.2, 0.2]

    for (let i = 1; i < exampleArr.length-1; i+=2) {
        const categoria = exampleArr[i]
        const impacto = exampleArr[i+1]
        if (categoria == "Calidad") {
            if (impacto == "Alto") {
                perfectProyecto[0] -= 0.05
            } else if (impacto == "Medio") {
                perfectProyecto[0] -= 0.03
            } else if (impacto == "Bajo") {
                perfectProyecto[0] -= 0.01
            }
        } else if (categoria == "Alcance"){
            if (impacto == "Alto") {
                perfectProyecto[1] -= 0.05
            } else if (impacto == "Medio") {
                perfectProyecto[1] -= 0.03
            } else if (impacto == "Bajo") {
                perfectProyecto[1] -= 0.01
            }
        } else if (categoria == "Costo"){
            if (impacto == "Alto") {
                perfectProyecto[2] -= 0.05
            } else if (impacto == "Medio") {
                perfectProyecto[2] -= 0.03
            } else if (impacto == "Bajo") {
                perfectProyecto[2] -= 0.01
            }
        } else if (categoria == "Tiempo"){
            if (impacto == "Alto") {
                perfectProyecto[3] -= 0.05
            } else if (impacto == "Medio") {
                perfectProyecto[3] -= 0.03
            } else if (impacto == "Bajo") {
                perfectProyecto[3] -= 0.01
            }
        } else if (categoria == "Recursos"){
            if (impacto == "Alto") {
                perfectProyecto[4] -= 0.05
            } else if (impacto == "Medio") {
                perfectProyecto[4] -= 0.03
            } else if (impacto == "Bajo") {
                perfectProyecto[4] -= 0.01
            }
        }
    }
    const projScore = perfectProyecto.reduce((prev, curr) => {
        return prev + curr
    }, 0)
    const percentage = projScore.toFixed(3)
    const viabilidad = percentage/1 * 100
    return viabilidad
}