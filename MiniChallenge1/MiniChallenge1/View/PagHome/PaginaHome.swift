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
    
    @State var centrosEsportivos = [CentroEsportivo]()
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
          coloredAppearance.configureWithOpaqueBackground()
          coloredAppearance.backgroundColor = .white
          
          UINavigationBar.appearance().standardAppearance = coloredAppearance
          UINavigationBar.appearance().compactAppearance = coloredAppearance
          UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                MapaPaginaPrincipal()
//                NavigationBarView()
                BottomSheet()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {

                    Image(systemName: "location.fill")
                        .padding(.vertical)
                        .foregroundColor(.blue)
                    
                    Text("Localização atual")
                        .padding(.trailing, 150)
                        .padding(.vertical)
                        .foregroundColor(.blue)

                    NavigationLink(destination: ConfiguracoesView()) {
                        Image(systemName: "gearshape")
                    }
                    .foregroundColor(.blue)
                    .padding(.vertical)

                }
                
                
               
            }
            
        }
        
    }
}

struct PaginaHome_Previews: PreviewProvider {
    static var previews: some View {
            PaginaHome()
    }
}

//FUNÇÕES

extension PaginaHome{
    
    
    
}
