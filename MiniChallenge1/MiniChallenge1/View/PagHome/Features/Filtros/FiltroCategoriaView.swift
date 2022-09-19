//
//  FiltroCategoriaView.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 19/09/22.
//

import SwiftUI

struct FiltroCategoriaView: View {
    
    @Binding var categorias: [String]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.fixed(100.0)), GridItem(.fixed(100.0))], content: {
//                ForEach()
            })
        }
    }
}

struct FiltroCategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        FiltroCategoriaView(categorias: .constant([String]()))
    }
}
