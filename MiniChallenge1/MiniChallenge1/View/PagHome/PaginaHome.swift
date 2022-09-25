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
    
    @State var centrosEsportivos = [CentroEsportivo]()
    
    var body: some View {
        NavigationView {
            ZStack {
                MapaPaginaPrincipal()
                BottomSheet()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {

                    Image(systemName: "location.fill")
                    .foregroundColor(CoresApp.corPrincipal.cor())
                    
                    Text("Localização atual")
                    .padding(.trailing, 150)
                    .foregroundColor(CoresApp.corPrincipal.cor())
                }
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    NavigationLink(destination: ConfiguracoesView()) {
                        Image(systemName: "info.circle")
                    }
                    .foregroundColor(CoresApp.corPlatinum.cor())
                })
            }
            
            
            
        }
        
    }
}

struct PaginaHome_Previews: PreviewProvider {
    static var previews: some View {
            PaginaHome()
    }
}


