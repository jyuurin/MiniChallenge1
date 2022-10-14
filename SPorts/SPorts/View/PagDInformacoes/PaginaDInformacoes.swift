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
                    VStack(alignment: .leading) {
                        Text("Conforme o site da Prefeitura de São Paulo informa, \"os Centros Esportivos (CEs) municipais são estruturas públicas que oferecem diversas atividades esportivas para a saúde, bem-estar e lazer da população de todas as regiões de São Paulo. A Secretaria Municipal de Esportes e Lazer administra atualmente 46 Centros Esportivos na cidade, abrangendo todas as regiões (zona leste, sul, norte, oeste e centro).\"\n\nMais informações devem e podem ser consultadas no site abaixo:")
                        
                        Link(
                            destination: URL(
                                string:
                                    "https://www.prefeitura.sp.gov.br/cidade/secretarias/esportes/centros_esportivos/index.php?p=8001")!,
                            label: {
                                Text("Centros Esportivos - Prefeitura da Cidade de São Paulo")
                                .padding(.bottom)
                                .multilineTextAlignment(.leading)
                            })
                            
                        
                        Text("O aplicativo SPorts foi criado para reunir todas as informações dos 46 Centros Esportivos de São Paulo e exibir a localização através de um mapa, desejando facilitar a busca por locais acessíveis à prática de atividades esportivas de qualidade.")
                    }
                    
                    
                    
                }
            }
            
            Link("Políticas de privacidade SPorts", destination: URL(string: "https://github.com/pedrohemmel/politicas-privacidade-sports/tree/main")!)
                .font(.system(size: 15))
                .foregroundColor(CoresApp.corPlatinum.cor())
            
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
