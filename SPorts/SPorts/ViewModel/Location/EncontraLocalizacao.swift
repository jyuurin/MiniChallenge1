//
//  EncontraLocalizacao.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 06/10/22.
//

import Foundation
import MapKit

//Structs necessárias para decodar os dados da API
struct Address: Codable {
    var data: [Datum]
}
struct Datum: Codable, Hashable {
    let latitude, longitude: Double
    let name: String?
    
}

//Criando a classe do tipo observable para que possa ser utilizado funções que tem função de decodar os dados
class MapAPI: ObservableObject {
    private let BASE_URL = "http://api.positionstack.com/v1/forward"
    private let API_KEY = "c2bd4757b48bef4b77fe70926071b067"
    
    @Published var locations: Address
    
    init() {
        self.locations = Address(data: [Datum]())
    }
    
    func getLocation(address: String) {
        let pAddress = address.replacingOccurrences(of: " ", with: "%20")
        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAddress)"
        
        guard let url = URL(string: url_string) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
             guard let data = data else {
                print(error!.localizedDescription)
                return }
             
             guard let newCoordinates = try? JSONDecoder().decode(Address.self, from: data) else { return }
             
             if newCoordinates.data.isEmpty {
                print("Could not find address...")
                return
             }

            DispatchQueue.main.async {
                self.locations.data.removeAll()

                for data in newCoordinates.data {
                    self.locations.data.append(Datum(latitude: data.latitude, longitude: data.longitude, name: data.name))
                }

                print("Succesfully on load address")
            }
        }
        .resume()
            
    }
}

//public func encontraCoordenadasPeloEndereco(endereco: String, completion: @escaping (((CLLocation, [String], Bool) -> Void))) {
//    let geoCoder = CLGeocoder()
//
//    var localizacaoEndereco = CLLocation(latitude: 0.0, longitude: 0.0)
//
//    geoCoder.geocodeAddressString("\(endereco), Brasil") { placemarks, error in
//
//        var mostraEndereco = true
//
//
//
//        guard let placemark = placemarks, let location = placemark.first?.location?.coordinate else {
//            mostraEndereco = false
//            completion(localizacaoEndereco, [], mostraEndereco)
//            return
//        }
//
//        localizacaoEndereco = CLLocation(latitude: location.latitude, longitude: location.longitude)
//
//        let nomeLocalizacao = placemark.compactMap({ place in
//            return "\(place.name ?? ""), \(place.locality ?? "")"
//        })
//
//        completion(localizacaoEndereco, nomeLocalizacao, mostraEndereco)
//    }
//
//}



