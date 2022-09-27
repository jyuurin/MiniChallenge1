//
//  SwiftUIView.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 15/09/22.
//

import SwiftUI
import Combine
import MapKit
import CoreLocation

struct MapaPaginaPrincipal: View {
    
    @State var locationManager = LocationManager()
    
    @State var tokens: Set<AnyCancellable> = []
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -23.561370844718464, longitude: -46.618687290635606), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    
    @Binding var localizacaoPermitida: Bool
    @State var mostraAlertaDLocalizacao = false
    
    //Quando for false, a atualização do mapa não vai mais acontecer automaticamente, e sim quando o usuário clicar no botão de atualizar
    @State var primeiraAtualizacaoMapa = true
    
    //Variável que será utilizada quando clicar em um icone do centro esportivo no mapa
    @State var centroEsportivoMostrando = false
    
    @State var latitude = -23.561370844718464
    @State var longitude = -46.6186872906356062
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                annotationItems: DataLoader().centrosEsportivos,
                annotationContent: { centroEsportivo in
                
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0, longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0), content: {
                        Button(action: {
                            self.centroEsportivoMostrando = true
                        }, label: {
                            Image("mapMarker")
                            .resizable()
                            .frame(width: 40.0, height: 50.0)
                        })
                        .sheet(isPresented: $centroEsportivoMostrando, content: {
                            DetalhesSheet(centroEsportivo: centroEsportivo)
                        })
                        
                    })
                })
            
            //MARK: - Botão para centralizar a localização do usuário no mapa
            Button(action: {
                locationManager = LocationManager()
                observarAtualizacoesCoordenadas()
                observarLocalizacaoRecusada()
                locationManager.requisitarAtualizacaoDLocalizacao()
                
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                
                
                //Atribuindo valor booleano ao alerta, caso for verdadeiro, será mostrado um alerta com instruções para permitir a localizacao
                self.mostraAlertaDLocalizacao = locationManager.mostraAlerta
                
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
            .alert(isPresented: $mostraAlertaDLocalizacao) {
                Alert(title: Text("Ative sua configuração de localização no SPorts"), message: Text("Vá até suas configurações e altere a permissão de localização do SPorts."), dismissButton: .default(Text("OK")))
            }
        }
        .edgesIgnoringSafeArea(.trailing)
        .edgesIgnoringSafeArea(.leading)
        .edgesIgnoringSafeArea(.bottom)
        .onChange(of: primeiraAtualizacaoMapa) { _ in
            //Esse onChange só vai rodar quando primeiraAtualizacaoMapa for modificado, e isso só acontece uma vez
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
        .onAppear {
            observarAtualizacoesCoordenadas()
            observarLocalizacaoRecusada()
            locationManager.requisitarAtualizacaoDLocalizacao()
            
            //Verificação de acesso a localização para mandar para tela principal
            if locationManager.mostraAlerta {
                self.localizacaoPermitida = false
            }
            
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
                self.latitude = coordenada.latitude
                self.longitude = coordenada.longitude
                
                //Modificando variável que permite que atualize automaticamente
                if primeiraAtualizacaoMapa != false {
                    self.primeiraAtualizacaoMapa = false
                }
                
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
        MapaPaginaPrincipal(localizacaoPermitida: .constant(false))
    }
}
