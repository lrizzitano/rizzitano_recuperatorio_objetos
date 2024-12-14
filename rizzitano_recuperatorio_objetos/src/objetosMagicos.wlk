class ObjetoMagicoConPoderBase {
    const poderBase

    method poderAportado(unMago) = poderBase + self.poderExtra(unMago)

    method poderExtra(unMago)
}

class Varita inherits ObjetoMagicoConPoderBase {
    override method poderExtra(unMago) = 
        if (unMago.nombre().length().even()) 0.5 * poderBase else 0
}

class Tunica inherits ObjetoMagicoConPoderBase {
    override method poderExtra(unMago) = 
        unMago.resistenciaMagica() * 2
}

class TunicaEpica inherits Tunica {
    override method poderExtra(unMago) = super(unMago) + 10
}

class Amuleto {
    method poderAportado(unMago) = 200
}

object ojota {
    method poderAportado(unMago) = unMago.nombre().length() * 10
}