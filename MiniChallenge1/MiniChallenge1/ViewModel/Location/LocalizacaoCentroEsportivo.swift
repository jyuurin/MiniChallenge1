//
//  LocalizacaoCentroEsportivo.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 15/09/22.
//

import Foundation
import SwiftUI
import MapKit

class LocalizacaoCentroEsportivo: ObservableObject {
    
    
    @Published var coordenadasCentrosEsportivos: [CoordenadaCentroEsportivo] = []
    private var mapAPI = MapAPI()
    private var centrosEsportivos = DataLoader().centrosEsportivos
    
    
    init() {
        buscarTodasCoordenadas()
    }
    
    func buscarTodasCoordenadas() {
        var contador = 0
        for centroEsportivo in centrosEsportivos {
            mapAPI.getAddress(address: centroEsportivo.ceEndereco, delta: 0.1)
            
            coordenadasCentrosEsportivos.insert(CoordenadaCentroEsportivo(idCentroEsportivo: centroEsportivo.ceId, coordenada: mapAPI.locations[0].coordinate), at: contador)
            
            print("\n\n\n\n\n\n\n\(mapAPI.coordinate)\n\n\n\n\n\n\n")
        }
    }
}
