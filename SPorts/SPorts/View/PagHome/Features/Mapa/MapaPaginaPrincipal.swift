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

struct CentroEsportivoCNomeImagem: Identifiable {
    var id: UUID
    var centroEsportivo: CentroEsportivo
    var nomeImagem: String
}

struct MapaPaginaPrincipal: View {
    
    //A variável locationManager vai receber valor da view principal, TabBarView
    @Binding var locationManager: LocationManager
    @Binding var tokens: Set<AnyCancellable>
    @Binding var region: MKCoordinateRegion
    
    @Binding var localizacaoPermitida: Bool
    @State var mostraAlertaDLocalizacao = false
    
    //Quando for false, a atualização do mapa não vai mais acontecer automaticamente, e sim quando o usuário clicar no botão de atualizar
    @Binding var primeiraAtualizacaoMapa: Bool
    @Binding var atualizacaoDistancia: Bool
    @Binding var nomeLocalizacao: String
    
    //Variável que será utilizada quando clicar em um icone do centro esportivo no mapa
    @State var centroEsportivoMostrando = false
    @State var centroEsportivoAtual = DataLoader().centrosEsportivos[0]
    @State var centroEsportivoCNomeImagem = [CentroEsportivoCNomeImagem]()
    @Binding var centroEsportivoCDistancia: [CentroEsportivoCDistancia]
    
    @State var adicionouPinEnderecoSetado = true
    
    @Binding var latitude: Double
    @Binding var longitude: Double
    @Binding var localizacaoSetada: CLLocation
    @Binding var centrosEsportivos: [CentroEsportivo]
    @Binding var localizacaoEnderecoSetado: Bool
    @Binding var identificaMudancaEndereco: Bool
    
    var body: some View {
        
        
        ZStack(alignment: .topTrailing) {
            //NavigationLink que envia o usuário para tela de detalhes do centro esportivo com o centroEsportivoAtual como parâmetro
            NavigationLink(destination: DetalhesSheet(centroEsportivo: centroEsportivoAtual), isActive: $centroEsportivoMostrando, label: {})
            
            if localizacaoEnderecoSetado {
                Map(coordinateRegion: $region,
                    annotationItems: centroEsportivoCNomeImagem,
                    annotationContent: { centroEsportivo in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(centroEsportivo.centroEsportivo.ceEndereco.latitude) ?? 0.0, longitude: Double(centroEsportivo.centroEsportivo.ceEndereco.longitude) ?? 0.0), content: {
                            
                        if centroEsportivo.nomeImagem == "mapMarker" {
                            Button(action: {
                                self.centroEsportivoMostrando = true
                                self.centroEsportivoAtual = centroEsportivo.centroEsportivo
                                
                            }, label: {
                                
                                Image("mapMarker")
                                .resizable()
                                .frame(width: 40.0, height: 50.0)
                            })
                        } else {
                            Image(systemName: centroEsportivo.nomeImagem)
                            .resizable()
                            .frame(width: 35.0, height: 35.0)
                            .foregroundColor(CoresApp.corPrincipal.cor())
                            
                        }
                            
                            
                        })
                    })
            } else {
                Map(coordinateRegion: $region,
                    showsUserLocation: true,
                    annotationItems: centrosEsportivos,
                    annotationContent: { centroEsportivo in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0, longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0), content: {
                            Button(action: {
                                self.centroEsportivoMostrando = true
                                self.centroEsportivoAtual = centroEsportivo
                                
                            }, label: {
                                Image("mapMarker")
                                .resizable()
                                .frame(width: 40.0, height: 50.0)
                            })
                            
                        })
                    })
            }
            //MARK: - Botão para centralizar a localização do usuário no mapa
            Button(action: {
                
                if !self.localizacaoEnderecoSetado {
                    locationManager = LocationManager()
                    observarAtualizacoesCoordenadas()
                    observarLocalizacaoRecusada()
                    locationManager.requisitarAtualizacaoDLocalizacao()
                    
                    //Atribuindo valor booleano ao alerta, caso for verdadeiro, será mostrado um alerta com instruções para permitir a localizacao
                    self.mostraAlertaDLocalizacao = locationManager.mostraAlerta
                }
                
                let menorDistancia = centroEsportivoCDistancia[0].distancia
                print(menorDistancia)
                
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), latitudinalMeters: menorDistancia, longitudinalMeters: menorDistancia * 2)
                
                
//                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                
                
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
        .onChange(of: self.primeiraAtualizacaoMapa) { _ in
            //Esse onChange só vai rodar quando primeiraAtualizacaoMapa for modificado, e isso só acontece uma vez
            
            //__________________
            let menorDistancia = centroEsportivoCDistancia[0].distancia
            print("\(menorDistancia)")

            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), latitudinalMeters: menorDistancia, longitudinalMeters: menorDistancia * 2)
            
            
            //-----------------

//            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

        }
        .onChange(of: centroEsportivoCDistancia[0].distancia) { _ in
            if self.atualizacaoDistancia {
                self.atualizacaoDistancia = false
                
                let menorDistancia = centroEsportivoCDistancia[0].distancia
                print("oi\(menorDistancia)")

                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), latitudinalMeters: menorDistancia, longitudinalMeters: menorDistancia * 2)
                
                print("Acabou de atualizar essa merda")
            }
        }
        .onChange(of: self.identificaMudancaEndereco) { _ in
            
            if self.localizacaoEnderecoSetado {

                //Setando essa variável para true novamente para que quando o usuário selecionar Minha localizacao novamente, atualizar automaticamente a regiao do mapa
                self.primeiraAtualizacaoMapa = true
                  
//                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                
                //__________________
                let menorDistancia = centroEsportivoCDistancia[0].distancia
                print(menorDistancia)
                
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), latitudinalMeters: menorDistancia, longitudinalMeters: menorDistancia * 2)
                //-----------------
                
                buscaETrataCentrosEsportivos()
                                            
            } else {
                self.primeiraAtualizacaoMapa = true
                locationManager = LocationManager()
                observarAtualizacoesCoordenadas()
                observarLocalizacaoRecusada()
                locationManager.requisitarAtualizacaoDLocalizacao()
            }
        }
        .onAppear {
            
            self.centroEsportivoCNomeImagem = []
            
            
            if !self.localizacaoEnderecoSetado {
                observarAtualizacoesCoordenadas()
                observarLocalizacaoRecusada()
                locationManager.requisitarAtualizacaoDLocalizacao()
                
                //Verificação de acesso a localização para mandar para tela principal
                if locationManager.mostraAlerta {
                    self.nomeLocalizacao = "Localização Indefinida"
                    self.localizacaoPermitida = false
                }
                
                let menorDistancia = centroEsportivoCDistancia[0].distancia
                print("oi\(menorDistancia)")

                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), span: MKCoordinateSpan(latitudeDelta: menorDistancia / 15000, longitudeDelta: menorDistancia / 15000))
                
//            latitudinalMeters: menorDistancia, longitudinalMeters: menorDistancia * 2
                
            } else {
            
                let menorDistancia = centroEsportivoCDistancia[0].distancia
                print("oi\(menorDistancia)")

                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), latitudinalMeters: menorDistancia, longitudinalMeters: menorDistancia * 2)
            }
            buscaETrataCentrosEsportivos()
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
    
    func buscaETrataCentrosEsportivos() {
        
        //Inicializa array de centroEsportivoCImagem
        self.centroEsportivoCNomeImagem = []
        
        for centroEsportivo in centrosEsportivos {
            self.centroEsportivoCNomeImagem.append(CentroEsportivoCNomeImagem(id: UUID(), centroEsportivo: centroEsportivo, nomeImagem: "mapMarker"))
        }
        
        self.centroEsportivoCNomeImagem.append(
            CentroEsportivoCNomeImagem(
                id: UUID(),
                centroEsportivo: CentroEsportivo(
                            ceId: 0,
                            ceNome: "",
                            ceZona: "",
                            ceEndereco: EnderecoCentroEsportivo(endereco: "", latitude: String(self.latitude), longitude: String(self.longitude)),
                            ceTelefone: [""],
                            horarioSemana: "",
                            horarioFinalSemanaFeriado: "",
                            horarioPiscinas: "",
                            ceArea: "",
                            ceEstrutura: [],
                            ceModalidades: []),
                            nomeImagem: "mappin.circle.fill"
                )
        )
    }
    
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapaPaginaPrincipal(
            locationManager: .constant(LocationManager()),
            tokens: .constant([]),
            region: .constant(MKCoordinateRegion()),
            localizacaoPermitida: .constant(false),
            primeiraAtualizacaoMapa: .constant(false),
            atualizacaoDistancia: .constant(true), nomeLocalizacao: .constant(""),
            centroEsportivoCDistancia: .constant([CentroEsportivoCDistancia]()), latitude: .constant(0.0),
            longitude: .constant(0.0),
            localizacaoSetada: .constant(CLLocation(latitude: 0.0, longitude: 0.0)),
            centrosEsportivos: .constant([CentroEsportivo]()),
            localizacaoEnderecoSetado: .constant(false),
            identificaMudancaEndereco: .constant(false)
        )
    }
}
