//
//  PaginaHome.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 12/09/22.
//

import SwiftUI

struct PaginaHome: View {
    
    @State var centrosEsportivos = [CentroEsportivo]()
    
    var body: some View {
        ZStack {
        
            List {
                ForEach(centrosEsportivos, id:\.ceId) { centroEsportivo in
                    Text(String(centroEsportivo.ceId) + centroEsportivo.ceNome)
                }
            }
            
        }
        .onAppear {
            self.centrosEsportivos = DataLoader().centrosEsportivos
            print("Entrou aqui")
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
