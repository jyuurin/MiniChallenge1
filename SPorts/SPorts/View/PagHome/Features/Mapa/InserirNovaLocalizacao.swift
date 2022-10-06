//
//  InserirNovaLocalizacao.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 06/10/22.
//

import SwiftUI

struct InserirNovaLocalizacao: View {
    
    @State var txtFieldEndereco = ""
    
    var body: some View {
        VStack {
            
            //Icone arredondado
            Capsule()
            .fill(Color.init(UIColor.systemGray4))
            .frame(width: 50, height: 4)
            .padding(.top, 10)
            
            //MARK: - Search Bar
            TextField("Digite aqui o endereço desejado", text: $txtFieldEndereco)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.init(UIColor.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct InserirNovaLocalizacao_Previews: PreviewProvider {
    static var previews: some View {
        InserirNovaLocalizacao()
    }
}
