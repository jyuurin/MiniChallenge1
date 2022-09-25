//
//  PaginaDInformacoes.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 25/09/22.
//

import SwiftUI

struct PaginaDInformacoes: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Sobre nós")
                .font(.title.bold())
                .padding(.top, 10)
                
                ScrollView {
                    
                }
            }
            Button(action: {
                
            }, label: {
                Text("Políticas de privacidade SPorts")
                .font(.system(size: 15))
                .foregroundColor(CoresApp.corPlatinum.cor())
            })
            
        }
        .padding()
        .navigationTitle("Informações")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Voltar")
                    }
                    .foregroundColor(CoresApp.corPrincipal.cor())
                    
                })
            })
        }
    }
}

struct PaginaDInformacoes_Previews: PreviewProvider {
    static var previews: some View {
        PaginaDInformacoes()
    }
}
