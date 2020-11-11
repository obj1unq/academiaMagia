object academia {
	
	var property muebles = #{}
	
	method estaGuardado(unaCosa) {
		return self.muebles().any({mueble => mueble.estaGuardado(unaCosa)})
	}
	
	method dondeEsta(unaCosa){
		return self.muebles().find({mueble => mueble.estaGuardado(unaCosa)})		
	}
	
	method sePuedeGuardar(unaCosa) {
		return not self.estaGuardado(unaCosa) and self.muebles().any({mueble => mueble.sePuedeGuardar(unaCosa)})
	}
	
	method dondeSePuedeGuardar(unaCosa) {
		return self.muebles().filter({mueble => mueble.sePuedeGuardar(unaCosa)})
	}
 	
 	method validarGuardar(unaCosa) {
 		if(not self.sePuedeGuardar(unaCosa)) {
 			self.error("no se puede guardar " + unaCosa)
 		}
 	}
 	
 	method guardar(unaCosa) {
 		self.validarGuardar(unaCosa)
 		self.muebles().find({mueble => mueble.sePuedeGuardar(unaCosa)}).guardar(unaCosa)
 	}
 	
 	method menosUtiles() {
 		return self.muebles().map({mueble => mueble.menosUtil()}).asSet()
 	}
 	
 	method menosUtilesNoMagicas() {
 		return self.menosUtiles().filter({cosa => not cosa.magia()})
 	}
 	
 	method validarRemoverCosasMenosUtilesNoMagicas() {
 	    if( self.muebles().size() < 3) {
 	    	self.error("no se puede realizar la accion de remover cosas menos utiles no mágicas")
 	    }	
 	}
 	
 	method removerMenosUtilesNoMagicas() {
 		self.validarRemoverCosasMenosUtilesNoMagicas()
 		return self.menosUtilesNoMagicas().forEach({cosa => self.remover(cosa)})
 	}
 	
 	method remover(cosa) {
 		self.dondeEsta(cosa).remover(cosa)
 	}
 	
 	method marcaMenosUtil() {
 		return self.menosUtiles().min({cosa => cosa.utilidad()}).marca()
 	}
 	
}

object cuchuflito {
	method utilidad(cosa) {
		return 0
	}
}

object fenix {
	method utilidad(cosa) {
		return if (cosa.reliquia()) 3 else 0
	}
}

object acme {
	method utilidad(cosa) {
		return cosa.volumen() / 2
	}	
}



class Baul inherits Mueble {
	const property volumenMaximo
	
	override method sePuedeGuardar(unaCosa) {
		return self.capacidad() + unaCosa.volumen() <= volumenMaximo
	}
	
	method capacidad() {
		return self.cosas().sum({unaCosa => unaCosa.volumen()})
	}
	
	override method precio() {
		return volumenMaximo + 2
	}
	
	override method utilidad() {
		return super() + self.extra()
	}
	
	method extra() {
		return if (self.cosas().all({cosa => cosa.reliquia()})) 2 else 0 
	}
}

class BaulMagico inherits Baul {
	
	override method precio() {
		return super() * 2
	}
	
	override method extra() {
		return super() + self.cosas().count({cosa => cosa.magia()})
	}
	
}


class GabineteMagico inherits Mueble {

	const property precio
	
	override method sePuedeGuardar(unaCosa) {
		return unaCosa.magia()
	}
}

class Armario inherits Mueble {
	var property capacidad
	
	override method sePuedeGuardar(unaCosa) {
		return self.cosas().size() < capacidad
	}
	
	override method precio() {
		return capacidad * 5	
	}
}


class Mueble {
	
	const property cosas=#{}
		
	method sePuedeGuardar(unaCosa)
	
	method estaGuardado(unaCosa) {
		return self.cosas().contains(unaCosa)
	}
	
	method guardar(unaCosa) {
		//se podría validar de nuevo acá, pero como está validado en la academia decidí ni hacerlo
		self.cosas().add(unaCosa)
	}
	
	method utilidad() {
		return self.cosas().sum({cosa => cosa.utilidad()}) / self.precio()
	}
	
	method menosUtil() {
		return cosas.min({cosa => cosa.utilidad()})
	}
	
	method remover(cosa) {
		cosas.remove(cosa)
	}
	
	method precio()
}


class Cosa {
	const property volumen
	const property magia
	const property reliquia
	const property marca
	
	method utilidad() {
		return volumen + (if(magia) 3 else 0) + (if(reliquia) 5 else 0) + marca.utilidad(self)
	} 
}
