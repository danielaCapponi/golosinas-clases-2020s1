import mariano.*

/*
 * Los sabores
 */
object frutilla {

}

object chocolate {

}

object vainilla {

}

object naranja {

}

object limon {

}

/*
 * Golosinas
 */
class Bombon {

	var peso = 15

	method precio() {
		return 5
	}

	method peso() {
		return peso
	}

	method mordisco() {
		peso = peso * 0.8 - 1
	}

	method sabor() {
		return frutilla
	}

	method libreGluten() {
		return true
	}

}

class BombonDuro inherits Bombon {

	override method mordisco() {
		peso -= 1
	}

	method gradoDeDureza() = if (self.peso() > 12) {
		3
	} else if (self.peso().between(8, 12)) {
		2
	} else {
		1
	}

// var bombon = new Bombon() 
// bombon.mordisco() ---> se encuentra en Bombon
// bombon.peso()  ---> se encuentra en Bombon
// bombon = new BombonDuro()  
// bombon.mordisco()  ---> se encuentra en BombonDuro
// bombon.peso()  ---> se encuentra en Bombon
}

class Alfajor {

	var peso = 15

	method precio() {
		return 12
	}

	method peso() {
		return peso
	}

	method mordisco() {
		peso = peso * 0.8
	}

	method sabor() {
		return chocolate
	}

	method libreGluten() {
		return false
	}

}

class Caramelo {

	var peso = 5
	var property sabor

	method precio() {
		return 12
	}

	method peso() {
		return peso
	}

	method mordisco() {
		peso = peso - 1
	}

	method libreGluten() {
		return true
	}

}

class CarameloRelleno inherits Caramelo {

	override method precio() = super() + 1

	override method mordisco() {
		super()
		self.sabor(chocolate)
	}

// var caramelo = new Caramelo() 
// caramelo.mordisco()  ---> se encuentra en Caramelo
// caramelo.peso()  ---> se encuentra en Caramelo
// caramelo.sabor()  ---> se encuentra en Caramelo
// caramelo = new CarameloRelleno() 
// caramelo.mordisco()  ---> se encuentra en Caramelo la primer parte y en CarameloRelleno la segunda
// caramelo.peso()  ---> se encuentra en Caramelo
// caramelo.sabor() ---> se encuentra en Caramelo
}

class Chupetin {

	var peso = 7

	method precio() {
		return 2
	}

	method peso() {
		return peso
	}

	method mordisco() {
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}

	method sabor() {
		return naranja
	}

	method libreGluten() {
		return true
	}

}

class Oblea {

	var peso = 250

	method precio() {
		return 5
	}

	method peso() {
		return peso
	}

	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else {
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}

	method sabor() {
		return vainilla
	}

	method libreGluten() {
		return false
	}

}

class ObleaCrujiente inherits Oblea {

	var property mordiscos = 0

	override method mordisco() {
		super()
		if (self.mordiscos() < 3) {
			mordiscos++
			peso = (peso - 3).max(0)
		}
	}

// var oblea = new Oblea() 
// oblea.mordisco()  ---> se encuentra en Oblea
// oblea.peso()  ---> se encuentra en Oblea
// oblea = new ObleaCrujiente() 
// oblea.mordisco()  ---> se encuentra en Oblea la primera parte, luego en ObleaCrujiente encuentra el valor de mordiscos, y de acuerdo a eso setea el peso (método en Oblea).
// oblea.peso()  ---> se encuentra en Oblea
}

class Chocolatin {

	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0

	method pesoInicial(unPeso) {
		pesoInicial = unPeso
	}

	method precio() {
		return pesoInicial * 0.50
	}

	method peso() {
		return (pesoInicial - comido).max(0)
	}

	method mordisco() {
		comido = comido + 2
	}

	method sabor() {
		return chocolate
	}

	method libreGluten() {
		return false
	}

}

class ChocolatinVIP inherits Chocolatin {

	override method peso() = super() * (1 + self.humedad())

	method humedad() = heladeraDeMariano.humedad()

}

class ChocolatinPremium inherits ChocolatinVIP {

	override method humedad() = super() / 2

// var chocolatin = new Chocolatin() 
// chocolatin.peso() ---> se encuentra en Chocolatin
// chocolatin = new ChocolatinVIP() 
// chocolatin.peso()  ---> se encuentra en Chocolatin la primer parte pero dentro utiliza el valor devuelto por un método propio humedad() que a su vez obtiene su valor del objeto heladeraDeMariano
// chocolatin = new ChocolatinPremium() 
// chocolatin.peso()  ---> se encuentra en ChocolatinVIP, pero al reescribir el método humedad() utilizado dentro del método peso(), ese valor lo busca en ChocolatinPremium
}

class GolosinaBaniada {

	var golosinaInterior
	var pesoBanio = 4

	method golosinaInterior(unaGolosina) {
		golosinaInterior = unaGolosina
	}

	method precio() {
		return golosinaInterior.precio() + 2
	}

	method peso() {
		return golosinaInterior.peso() + pesoBanio
	}

	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0)
	}

	method sabor() {
		return golosinaInterior.sabor()
	}

	method libreGluten() {
		return golosinaInterior.libreGluten()
	}

}

class Tuttifrutti {

	var libreDeGluten
	var sabores = [ frutilla, chocolate, naranja ]
	var saborActual = 0

	method mordisco() {
		saborActual += 1
	}

	method sabor() {
		return sabores.get(saborActual % 3)
	}

	method precio() {
		return (if (self.libreGluten()) 7 else 10 )
	}

	method peso() {
		return 5
	}

	method libreGluten() {
		return libreDeGluten
	}

	method libreGluten(valor) {
		libreDeGluten = valor
	}

}

