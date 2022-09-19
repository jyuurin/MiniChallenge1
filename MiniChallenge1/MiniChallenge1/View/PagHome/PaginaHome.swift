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
    

    
    var body: some View {
        NavigationView() {
            ZStack {
                MapaPaginaPrincipal()
                NavigationBarView()
                BottomSheet()
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
