//
//  TabBarView.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 10/10/22.
//

import SwiftUI
import MapKit
import Combine

struct TabBarView: View {
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .white
          
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
       
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = UIColor(CoresApp.corPlatinum.cor())
    }
    
    @State var locationManager = LocationManager()
    @State var tokens: Set<AnyCancellable> = []
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -23.561370844718464, longitude: -46.618687290635606), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    
    //Quando for false, a atualização do mapa não vai mais acontecer automaticamente, e sim quando o usuário clicar no botão de atualizar
    @State var primeiraAtualizacaoMapa = true
    @State var nomeLocalizacao = "Minha Localização"
    
    @State var localizacaoPermitida = true
    @State var localizacaoEnderecoSetado = false
    @State var identificaMudancaEndereco = false
    @State var coordenadaLocalizacao = CLLocation(latitude: 0.0, longitude: 0.0)
    
    @State var inserirNovoEnderecoMostrando = false
    
    @State var latitude = 0.0
    @State var longitude = 0.0
    
    @State var centrosEsportivos = [CentroEsportivo]()
    
    @State var centroEsportivoCDistancia: [CentroEsportivoCDistancia] = []
    
    @State var identificaMudancaAbaixarBottomSheet = false
    
    var body: some View {
        NavigationView {
            TabView {
                
                ExibicaoListaCEs(
                    centrosEsportivos: $centrosEsportivos,
                    centroEsportivoCDistancia: $centroEsportivoCDistancia,
                    latitude: $latitude,
                    longitude: $longitude
                )
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Centros Esportivos")
                }
                
                MapaPaginaPrincipal(
                    locationManager: $locationManager,
                    tokens: $tokens,
                    region: $region,
                    localizacaoPermitida: $localizacaoPermitida,
                    primeiraAtualizacaoMapa: $primeiraAtualizacaoMapa,
                    nomeLocalizacao: $nomeLocalizacao,
                    centroEsportivoCDistancia: $centroEsportivoCDistancia,
                    latitude: $latitude,
                    longitude: $longitude,
                    localizacaoSetada: $coordenadaLocalizacao,
                    centrosEsportivos: $centrosEsportivos,
                    localizacaoEnderecoSetado: $localizacaoEnderecoSetado,
                    identificaMudancaEndereco: $identificaMudancaEndereco
                )
                .tabItem {
                    Image(systemName: "map")
                    Text("Mapa")
                }
            }
            .accentColor(CoresApp.corPrincipal.cor())
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {

                    Button {
                        inserirNovoEnderecoMostrando = true
                    } label: {
                        if localizacaoPermitida {
                            Text(nomeLocalizacao)
                            .foregroundColor(CoresApp.corPrincipal.cor())
                        } else {
                            Text(nomeLocalizacao)
                            .foregroundColor(CoresApp.corPrincipal.cor())
                        }

                    }
                    .padding(.bottom, 10)
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $inserirNovoEnderecoMostrando, content: {
                        InserirNovaLocalizacao(
                            localizacaoSetada: $coordenadaLocalizacao,
                            nomeLocalizacao: $nomeLocalizacao,
                            localizacaoEnderecoSetado: $localizacaoEnderecoSetado,
                            identificaMudancaEndereco: $identificaMudancaEndereco)
                    })

                }

                ToolbarItem(placement: .navigationBarTrailing, content: {
                    NavigationLink(destination: PaginaDInformacoes()) {
                        Image(systemName: "info.circle")
                    }
                    .padding(.bottom, 10)
                    .frame(width: 35, height: 35, alignment: .center)
                    .foregroundColor(CoresApp.corPlatinum.cor())
                })
            }
            .onChange(of: self.identificaMudancaEndereco) { _ in
                
                print("setou latitude")
                self.latitude = coordenadaLocalizacao.coordinate.latitude
                self.longitude = coordenadaLocalizacao.coordinate.longitude
            } 
        }
        .onAppear {
            observarAtualizacoesCoordenadas()
            observarLocalizacaoRecusada()
            locationManager.requisitarAtualizacaoDLocalizacao()
            
            //Verificação de acesso a localização para mandar para tela principal
            if locationManager.mostraAlerta {
                self.nomeLocalizacao = "Localização Indefinida"
                self.localizacaoPermitida = false
            }
        }
        
        
    }
    
    //MARK: - Funções de localização
    
    //Função responsável por setar e atualizar a localização do usuário requisitando do arquivo LocationManager
    func observarAtualizacoesCoordenadas() {
        
        locationManager.coordenadasPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { coordenada in
                
                print(localizacaoEnderecoSetado)
                if !self.localizacaoEnderecoSetado {
                    self.latitude = coordenada.latitude
                    self.longitude = coordenada.longitude
                }
                
                //Modificando variável que permite que atualize automaticamente
                if self.primeiraAtualizacaoMapa != false {
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
    
    
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
