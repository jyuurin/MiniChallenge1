//
//  PaginaHome.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 12/09/22.
//

import SwiftUI
import MapKit
import Combine

struct PaginaHome: View {
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .white
          
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    @State var localizacaoPermitida = true
    
    @State var centrosEsportivos = [CentroEsportivo]()
    
    var body: some View {
        NavigationView {
            ZStack {
                MapaPaginaPrincipal(localizacaoPermitida: $localizacaoPermitida, centrosEsportivos: $centrosEsportivos)
                BottomSheet(centrosEsportivos: $centrosEsportivos)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {

                    Button {
                        
                    } label: {
                        if localizacaoPermitida {
                            Text("Localização atual")
                            .foregroundColor(CoresApp.corPrincipal.cor())
                        } else {
                            Text("Localização indefinida")
                            .foregroundColor(CoresApp.corPrincipal.cor())
                        }
                            
                    }
                    .padding(.bottom, 10)
                    .buttonStyle(.bordered)
                    
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
            .onTapGesture {
                self.endEditing()
            }
            
            
            
        }
    }
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct PaginaHome_Previews: PreviewProvider {
    static var previews: some View {
            PaginaHome()
    }
}


