//
//  EncontraLocalizacao.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 06/10/22.
//

import Foundation
import MapKit

func encontraCoordenadasPeloEndereco(endereco: String) {
    let geoCoder = CLGeocoder()
    
    var localizacaoEndereco = CLLocation(latitude: 0.0, longitude: 0.0)
    
    geoCoder.geocodeAddressString(endereco) { placemarks, error in
        
        guard let placemark = placemarks, let location = placemark.first?.location?.coordinate else {
            return print("Endereço não encontrado")
        }
        
        localizacaoEndereco = CLLocation(latitude: location.latitude, longitude: location.longitude)
    }
    
    print(localizacaoEndereco)
}


encontraCoordenadasPeloEndereco(endereco: "Rua Edmundo Amaral Valente, 44, Campo Limpo, São")
