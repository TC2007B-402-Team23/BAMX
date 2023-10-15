import Foundation

struct Alimento: Identifiable {
    let id = UUID()
    let nombre: String
    var cantidadDisponible: Int
}

struct BancoDeAlimentos: Identifiable {
    let id = UUID()
    let nombre: String
    let direccion: String
    var alimentos: [Alimento]
}

let bancosDeAlimentos: [BancoDeAlimentos] = [
    BancoDeAlimentos(nombre: "Basilica de Zapopan", direccion: "Calle Eva Briseño 152, Zapopan, 44250 Zapopan, Jal.", alimentos: [
        Alimento(nombre: "Arroz", cantidadDisponible: 100),
        Alimento(nombre: "Frijoles", cantidadDisponible: 50),
        Alimento(nombre: "Lentejas", cantidadDisponible: 30),
    ]),
    BancoDeAlimentos(nombre: "Parque Colomos", direccion: "C. El Chaco 3200, Providencia, 44630 Guadalajara, Jal.", alimentos: [
        Alimento(nombre: "Enlatados", cantidadDisponible: 80),
        Alimento(nombre: "Aceite", cantidadDisponible: 40),
    ]),
    BancoDeAlimentos(nombre: "Tlaquepaque", direccion: "San Pedro Tlaquepaque, Jalisco", alimentos: [
        Alimento(nombre: "Maíz", cantidadDisponible: 60),
        Alimento(nombre: "Harina", cantidadDisponible: 20),
    ]),
]
