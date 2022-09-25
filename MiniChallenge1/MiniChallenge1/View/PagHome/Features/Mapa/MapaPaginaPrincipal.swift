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
    
    @State var locationManager = LocationManager()
    
    @State var tokens: Set<AnyCancellable> = []
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -23.561370844718464, longitude: -46.618687290635606), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    
    var body: some View {
        
        ZStack {
            
            
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                annotationItems: DataLoader().centrosEsportivos,
                annotationContent: { centroEsportivo in
                
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0, longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0))
                
                })
            
            Button(action: {
                locationManager = LocationManager()
                observarAtualizacoesCoordenadas()
                observarLocalizacaoRecusada()
                locationManager.requisitarAtualizacaoDLocalizacao()
            }, label: {
                Text("Atualiza aqui")
            })
            .position(x: 40, y: 100)
        }
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
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordenada.latitude, longitude: coordenada.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
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
