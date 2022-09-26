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
        
        ZStack(alignment: .topTrailing) {
            
            
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                annotationItems: DataLoader().centrosEsportivos,
                annotationContent: { centroEsportivo in
                
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0, longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0), content: {
                        Image("mapMarker")
                            .resizable()
                            .frame(width: 40.0, height: 50.0)
                    })
                })
            
            //MARK: - Botão para centralizar a localização do usuário no mapa
            Button(action: {
                locationManager = LocationManager()
                observarAtualizacoesCoordenadas()
                observarLocalizacaoRecusada()
                locationManager.requisitarAtualizacaoDLocalizacao()
            }, label: {
                Image(systemName: "location.fill")
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundColor(CoresApp.corPrincipal.cor())
            })
            .padding(5)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 5)
            .padding(.trailing, 5)
        }
        .edgesIgnoringSafeArea(.trailing)
        .edgesIgnoringSafeArea(.leading)
        .edgesIgnoringSafeArea(.bottom)
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
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordenada.latitude, longitude: coordenada.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
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
