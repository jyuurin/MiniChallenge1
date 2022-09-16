//
//  MapModel.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 15/09/22.
//

import Foundation
import MapKit

//Criando structs necessárias para coletar os dados da API position stack
struct Address: Codable {
    let data: [Datum]
}

struct Datum: Codable {
    let latitude, longitude: Double
    let name: String?
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

//Criando classe que irá se comunicar com a api e buscar os dados de endereço com base no endereço do tipo string de cada solicitação
class MapAPI: ObservableObject {
    //Criação de variáveis auxiliáres para conexão com API
    private let BASE_URL = "http://api.positionstack.com/v1/"
    private let API_KEY = "eed16ef301bf738daa416a2d1cffa36b"
    
    @Published var region: MKCoordinateRegion
    @Published var coordinate = []
    @Published var locations: [Location] = []
    
    //Inicializando as variáveis
    init() {
        //Setando valores exemplares para as variáveis que precisam ser inicializadas
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.50, longitude: 0.1275), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.locations.insert(Location(name: "Pin", coordinate: CLLocationCoordinate2D(latitude: 51.50, longitude: 0.1275)), at: 0)
    }
    
    func getAddress(address: String, delta: Double) {
        let pAddress = address.replacingOccurrences(of: " ", with: "%20")
        
        let url_string = "\(BASE_URL)forward?access_key=\(API_KEY)&query=\(pAddress)"
        
        print(url_string)
        
        guard let url = URL(string: url_string) else {
            print("URL inválida, verifique a url da API com mais atenção.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(error!.localizedDescription)
                return
            }
            
            guard let newCoordinates = try? JSONDecoder().decode(Address.self, from: data) else { return }
            
            print(newCoordinates)
            
            if newCoordinates.data.isEmpty {
                print("Não foi possível achar coordenadas nesse endereço.")
                return
            }
            
            DispatchQueue.main.async {
                let details = newCoordinates.data[0]
                let latitude = details.latitude
                let longitude = details.longitude
                let name = details.name
                
                self.coordinate = [latitude, longitude]
                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
                
                let new_location = Location(name: name ?? "Pin", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                
                self.locations.removeAll()
                self.locations.insert(new_location, at: 0)
                
                print("Os dados foram coletados com sucesso")
            }

        }
        .resume()
        
    }
    
    
}

