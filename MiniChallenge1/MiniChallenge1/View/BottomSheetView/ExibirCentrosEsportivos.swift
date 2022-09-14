//
//  ExibirCentrosEsportivos.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 14/09/22.
//

import SwiftUI

struct ExibirCentrosEsportivos: View {
    
    @State var centrosEsportivos = [CentroEsportivo]()
    
    var body: some View {
        ScrollView{
            VStack {
                ForEach(centrosEsportivos, id:\.ceId) { centroEsportivo in
                    centroEsportivoDados(title: centroEsportivo.ceNome, subTitle: centroEsportivo.ceEndereco)
                }
            }
            .onAppear {
                self.centrosEsportivos = DataLoader().centrosEsportivos
            }
            .padding(.top, 40)
            
        }
    }
    
    func centroEsportivoDados(title: String, subTitle: String) -> some View {
        HStack{
            Rectangle()
                .foregroundColor(Color.indigo)
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
        .padding(.horizontal)
    }
    
    
    
}

