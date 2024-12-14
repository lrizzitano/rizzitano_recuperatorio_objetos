import src.noHaySuficientesMiebrosException.NoHaySuficientesMiembrosException
import src.categorias.*
import src.objetosMagicos.*


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
    var property categoria // Como aclara que puede cambiar con el tiempo agrego el getter y setter

    override method poderTotal() =
        objetosMagicos.sum({objeto => objeto.poderAportado(self)}) * poderInnato

    override method esVencidoPor(unParticipante) =
        categoria.esVencidoPor(self, unParticipante)

    override method perderAnte(unParticipante) {
        // Aun si un mago inmortal pertenece a un gremio que pierde una batalla, el mago en particular no pierde ante el atacante
        if (categoria != inmortal)
            categoria.transferirEnergiaMagica(self, unParticipante)
    }   

    override method ganarEnergiaMagica(unaCantidad) {
        energiaMagica += unaCantidad
    } 

    method perderEnergiaMagica(unPorcentaje) {
        const energiaPerdida = energiaMagica * unPorcentaje / 100
        energiaMagica -= energiaPerdida
        return energiaPerdida
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

    // Asumo que cuando un gremio pierde una batalla, todos sus integrantes pierden contra el atacante
    override method perderAnte(unParticipante) {
        miembros.forEach({miembro => miembro.perderAnte(unParticipante)})
    }
} 

// Tanto lo magos como los gremios entienden los mensajes de la clase Participante
// y pueden ser usados de manera polimorfica, por lo que pueden ser tratados indistintamente
// a la hora de simular batallas o de crear gremios compuestos por otros gremios