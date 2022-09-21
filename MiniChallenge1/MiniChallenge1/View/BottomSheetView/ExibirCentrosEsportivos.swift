//
//  ExibirCentrosEsportivos.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 14/09/22.
//

import SwiftUI

struct ExibirCentrosEsportivos: View {
    
    @State var centrosEsportivos = [CentroEsportivo]()
    @Binding var categoriasSelecionadas: [String]
    
    var body: some View {
        ScrollView{
            VStack {
                ForEach(centrosEsportivos, id:\.ceId) { centroEsportivo in
                    centroEsportivoDados(title: centroEsportivo.ceNome, subTitle: centroEsportivo.ceEndereco.endereco)
                }
            }
            .onAppear {
                
                for centroEsportivo in DataLoader().centrosEsportivos {
                    for modalidade in centroEsportivo.ceModalidades {
                        if categoriasSelecionadas.contains(modalidade.categoria) {
                            self.centrosEsportivos.append(centroEsportivo)
                            break
                        }
                    }
                }
                
                
            }
            
        }
    }
    
    func centroEsportivoDados(title: String, subTitle: String) -> some View {
        HStack{
            Rectangle()
                .foregroundColor(Color.gray)
                .cornerRadius(10)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text(title)
                Text(subTitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
    
    
    
}

