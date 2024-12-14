import src.noHaySuficientesMiebrosException.NoHaySuficientesMiembrosException


class Participante {
    method poderTotal() 

    method esVencidoPor(unParticipante)

    method desafiar(unParticipante) {
        if (unParticipante.esVencidoPor(self))
            unParticipante.perderAnte(self)
    }

    method ganarEnergiaMagica(unaCantidad)

    method perderAnte(unParticipante)
}

class Mago inherits Participante {
    const property nombre
    const poderInnato
    const property resistenciaMagica
    var energiaMagica
    const objetosMagicos = #{}
    var categoria

    override method poderTotal() =
        objetosMagicos.sum({objeto => objeto.poderAportado(self)}) * poderInnato

    override method esVencidoPor(unParticipante) =
        categoria.esVencidoPor(self, unParticipante)

    method perderEnergiaMagica(unPorcentaje) {
        const energiaPerdida = energiaMagica * unPorcentaje / 100
        energiaMagica -= energiaPerdida
        return energiaPerdida
    }

    override method ganarEnergiaMagica(unaCantidad) {
        energiaMagica += unaCantidad
    }

    override method perderAnte(unParticipante) {
        categoria.transferirEnergiaMagica(self, unParticipante)
    }    
}

class Gremio inherits Participante {
    const miembros = #{}

    // Si se intenta crear un gremio con menos de dos miembros se interrumpe la instanciación con un error
    override method initialize() {
        if (miembros.size() < 2) 
            throw new NoHaySuficientesMiembrosException()
        super()
    }

    override method poderTotal() = miembros.sum({miembro => miembro.poderTotal()})

    method energiaMagica() = miembros.sum({miembro => miembro.energiaMagica()})

    method resistenciaMagica() = miembros.sum({miembro => miembro.resistenciaMagica()})

    override method esVencidoPor(unParticipante) =
        unParticipante.poderTotal() > self.resistenciaMagica() + self.miembroLider().resistenciaMagica()

    method miembroLider() = miembros.max({miembro => miembro.poderTotal()})

    override method ganarEnergiaMagica(unaCantidad) {
        self.miembroLider().ganarEnergiaMagica(unaCantidad)
    }

    override method perderAnte(unParticipante) {
        miembros.forEach({miembro => miembro.perderAnte(unParticipante)})
    }
} 