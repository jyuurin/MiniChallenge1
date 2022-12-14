//
//  LocationManager.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 15/09/22.
//

import Combine
import CoreLocation
import SwiftUI

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var coordenadasPublisher = PassthroughSubject<CLLocationCoordinate2D, Error>()
    
    var localizacaoRecusadaPublisher = PassthroughSubject<Void, Never>()
    
    var mostraAlerta = false
    
    override init() {
        super.init()
    }
    
    //Variável que armazenará a localização do usuário
    private lazy var locManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    //FUNÇÕES AQUI//
    
    //Função que verifica o status de permissão do usuário com base na sua localização
    func requisitarAtualizacaoDLocalizacao() {
        switch locManager.authorizationStatus {
        case .denied, .restricted:
            self.mostraAlerta = true
        case .notDetermined:
            locManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locManager.startUpdatingLocation()
        default:
            localizacaoRecusadaPublisher.send()
        }
    }
    
    //Função que observa se a permissão foi mudada, e caso tenha sido mudada, altera a localização
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
            localizacaoRecusadaPublisher.send()
        }
    }
    //Se a localização do usuário mudar, será aplicado na de localização da classe
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        coordenadasPublisher.send(location.coordinate)
    }
    
    //Se houverem erros na localização, o erro também será inserido na variável de localização da classe
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        coordenadasPublisher.send(completion: .failure(error))
    }
}
