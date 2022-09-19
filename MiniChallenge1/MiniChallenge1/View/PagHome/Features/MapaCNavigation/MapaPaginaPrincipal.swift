//
//  SwiftUIView.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 15/09/22.
//

import SwiftUI
import Combine
import MapKit

struct MapaPaginaPrincipal: View {
    
    @StateObject var locationManager = LocationManager.shared
    
    @State var tokens: Set<AnyCancellable> = []
    @State var coordenadas: (lat: Double, lon: Double) = (0, 0)
    
    var body: some View {
        
        Map(coordinateRegion:
                .constant(
                    MKCoordinateRegion(
                        center:
                            CLLocationCoordinate2D(
                                latitude: coordenadas.lat,
                                longitude: coordenadas.lon
                            ),
                        span:
                            MKCoordinateSpan(
                                latitudeDelta: 0.1,
                                longitudeDelta: 0.1
                            )
                    )
                ),
            showsUserLocation: true
        )
            .ignoresSafeArea()
            .onAppear {
                observarAtualizacoesCoordenadas()
                observarLocalizacaoRecusada()
                locationManager.requisitarAtualizacaoDLocalizacao()
            }
    }
    
    //Função responsável por setar e atualizar a localização do usuário requisitando do arquivo LocationManager
    func observarAtualizacoesCoordenadas() {
        locationManager.coordenadasPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { coordenada in
                self.coordenadas = (coordenada.latitude, coordenada.longitude)
            }
            .store(in: &tokens)
    }
    
    //Função que verifica o acesso do usuário e retorna uma mensagem dependendo do acesso
    func observarLocalizacaoRecusada() {
        locationManager.localizacaoRecusadaPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Será necessário pedir para o usuário permitir a localização")
            }
            .store(in: &tokens)
    }
    
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapaPaginaPrincipal()
    }
}
