class Mago {
    const property nombre
    const poderInnato
    const property resistenciaMagica
    var energiaMagica
    const objetosMagicos = #{}
    var categoria

    method poderTotal() = objetosMagicos.sum({objeto => objeto.poderAportado(self)}) * poderInnato

    method perderEnergiaMagica(unPorcentaje) {
        const energiaPerdida = energiaMagica * unPorcentaje / 100
        energiaMagica -= energiaPerdida
        return energiaPerdida
    }

    method ganarEnergiaMagica(unaCantidad) {
        energiaMagica += unaCantidad
    }

    method desafiar(unParticipante) {
        if (unParticipante.esVencidoPor(self))
            unParticipante.perderAnte(self)
    }

    method perderAnte(unParticipante) {
        categoria.transferirEnergiaMagica(self, unParticipante)
    }

    method esVencidoPor(unParticipante) {
        categoria.esVencidoPor(self, unParticipante)
    }
}