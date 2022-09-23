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
    
    @State var centroEsportivoMostrando: CentroEsportivo?
    
    var body: some View {
        ScrollView{
            VStack {
                
                ForEach(centrosEsportivos, id:\.ceId) { item in
                    //Botão de cada centro esportivo, ao clicar nele abre uma sheet.
                    Button(action: {centroEsportivoMostrando = item}, label: {
                        centroEsportivoDados(title: item.ceNome, subTitle: item.ceEndereco.endereco, zona: item.ceZona)
                    })
                    // se tem um item ele vai exibir uma sheet passando os dados dos centros esportivos para a DetalhesSheet.
                    .sheet(item: $centroEsportivoMostrando){ CE in
                        DetalhesSheet(centroEsportivo: CE)
                        
                    }
                }
                
            }
            .onChange(of: self.categoriasSelecionadas, perform: { _ in
                print("Ao mudar: \(categoriasSelecionadas)")
                selecionaCentrosEsportivos()
                print("Ja mudou: \(categoriasSelecionadas)")
            })
            .onAppear {
                selecionaCentrosEsportivos()
            }
            
        }
    }
    
    func selecionaCentrosEsportivos() {
        
        //Removendo os centros esportivos para setar os novos centros esportivos filtrados
        self.centrosEsportivos.removeAll()
        
        print("Entrou ExebirCentros")
        if(!categoriasSelecionadas.isEmpty) {
            for centroEsportivo in DataLoader().centrosEsportivos {
                for modalidade in centroEsportivo.ceModalidades {
                    if categoriasSelecionadas.contains(modalidade.categoria) {
                        self.centrosEsportivos.append(centroEsportivo)
                        break
                    }
                }
            }
        } else {
            self.centrosEsportivos = DataLoader().centrosEsportivos
        }
    }
    
    func centroEsportivoDados(title: String, subTitle: String, zona: String) -> some View {
        HStack{
            Image(zona)
                .resizable()
                .frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text(title)
                Text(subTitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .multilineTextAlignment(.leading)
            .padding(5)
            Spacer()
        }
    }
    
    
    
}

