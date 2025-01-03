class CategoriaMortal {
    const multiplicadorDeResistencia
    const porcentajeDePerdida // Valor entero entre 0 y 100

    // atacado es quien posee la categoria, atacante es quien lo desafia
    method esVencidoPor(atacado, atacante) =
        atacado.resistenciaMagica() * multiplicadorDeResistencia < atacante.poderTotal()
    
    method transferirEnergiaMagica(atacado, atacante) {
        atacante.ganarEnergiaMagica(atacado.perderEnergiaMagica(porcentajeDePerdida))
    }
}

object inmortal {
    method esVencidoPor(atacado, atacante) = false
}

const aprendiz = new CategoriaMortal(multiplicadorDeResistencia = 1, porcentajeDePerdida = 50)
const veterano = new CategoriaMortal(multiplicadorDeResistencia = 1.5, porcentajeDePerdida = 25)