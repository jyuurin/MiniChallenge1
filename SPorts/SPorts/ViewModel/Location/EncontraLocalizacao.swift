//
//  EncontraLocalizacao.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 06/10/22.
//

import Foundation
import MapKit

public func encontraCoordenadasPeloEndereco(endereco: String, completion: @escaping (((CLLocation, [String], Bool) -> Void))) {
    let geoCoder = CLGeocoder()
    
    var localizacaoEndereco = CLLocation(latitude: 0.0, longitude: 0.0)
    
    geoCoder.geocodeAddressString("\(endereco), Brasil") { placemarks, error in
        
        var mostraEndereco = true
        
        guard let placemark = placemarks, let location = placemark.first?.location?.coordinate else {
            mostraEndereco = false
            completion(localizacaoEndereco, [], mostraEndereco)
            return
        }
        
        localizacaoEndereco = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        let nomeLocalizacao = placemark.compactMap({ place in
            return "\(place.name ?? ""), \(place.locality ?? "")"
        })
        
        completion(localizacaoEndereco, nomeLocalizacao, mostraEndereco)
    }
    
}



