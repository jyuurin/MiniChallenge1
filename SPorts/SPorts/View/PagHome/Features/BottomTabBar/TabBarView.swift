//
//  TabBarView.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 10/10/22.
//

import SwiftUI
import MapKit

struct TabBarView: View {
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .white
          
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    
    @State var localizacaoPermitida = true
    @State var localizacaoEnderecoSetado = false
    @State var identificaMudancaEndereco = false
    @State var coordenadaLocalizacao = CLLocation(latitude: 0.0, longitude: 0.0)
    @State var nomeLocalizacao = "Minha Localização"
    
    @State var inserirNovoEnderecoMostrando = false
    
    @State var latitude = 0.0
    @State var longitude = 0.0
    
    @State var centrosEsportivos = [CentroEsportivo]()
    
    @State var identificaMudancaAbaixarBottomSheet = false
    
    var body: some View {
        TabView {
            MapaPaginaPrincipal(
                localizacaoPermitida: $localizacaoPermitida,
                nomeLocalizacao: $nomeLocalizacao,
                latitude: $latitude,
                longitude: $longitude,
                localizacaoSetada: $coordenadaLocalizacao,
                centrosEsportivos: $centrosEsportivos,
                localizacaoEnderecoSetado: $localizacaoEnderecoSetado,
                identificaMudancaEndereco: $identificaMudancaEndereco
            )
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Lista D/Centros Esportivos")
            }
            BottomSheet(
                centrosEsportivos: $centrosEsportivos,
                latitude: $latitude,
                longitude: $longitude,
                identificaMudancaAbaixarBottomSheet: $identificaMudancaAbaixarBottomSheet
            )
            .tabItem {
                Image(systemName: "map")
                Text("Mapa C/Centros Esportivos")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItemGroup(placement: .navigationBarLeading) {
//
//                Button {
//                    inserirNovoEnderecoMostrando = true
//                } label: {
//                    if localizacaoPermitida {
//                        Text(nomeLocalizacao)
//                        .foregroundColor(CoresApp.corPrincipal.cor())
//                    } else {
//                        Text(nomeLocalizacao)
//                        .foregroundColor(CoresApp.corPrincipal.cor())
//                    }
//
//                }
//                .padding(.bottom, 10)
//                .buttonStyle(.bordered)
//                .sheet(isPresented: $inserirNovoEnderecoMostrando, content: {
//                    InserirNovaLocalizacao(
//                        localizacaoSetada: $coordenadaLocalizacao,
//                        nomeLocalizacao: $nomeLocalizacao,
//                        localizacaoEnderecoSetado: $localizacaoEnderecoSetado,
//                        identificaMudancaEndereco: $identificaMudancaEndereco,
//                        identificaMudancaAbaixarBottomSheet: $identificaMudancaAbaixarBottomSheet)
//                })
//
//            }
//
//            ToolbarItem(placement: .navigationBarTrailing, content: {
//                NavigationLink(destination: PaginaDInformacoes()) {
//                    Image(systemName: "info.circle")
//                }
//                .padding(.bottom, 10)
//                .frame(width: 35, height: 35, alignment: .center)
//                .foregroundColor(CoresApp.corPlatinum.cor())
//            })
//        }
        .onChange(of: self.identificaMudancaEndereco) { _ in
            self.latitude = coordenadaLocalizacao.coordinate.latitude
            self.longitude = coordenadaLocalizacao.coordinate.longitude
        }
    }
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
