//
//  ExibirCentrosEsportivos.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 14/09/22.
//

import SwiftUI

struct ExibirCentrosEsportivos: View {
    
    @State var centrosEsportivos = [CentroEsportivo]()
    
    @State var centroEsportivoMostrando: CentroEsportivo?
    
    var body: some View {
        ScrollView {
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
            .onAppear {
                self.centrosEsportivos = DataLoader().centrosEsportivos
            }
        }
    }
    
    //estrutura do botão de cada centro esportivo. zona é a zona local do centro esportivo para exibir a imagem referente.
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




