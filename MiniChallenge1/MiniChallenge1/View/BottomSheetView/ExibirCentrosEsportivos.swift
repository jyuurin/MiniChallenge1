//
//  ExibirCentrosEsportivos.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 14/09/22.
//

import SwiftUI

struct ExibirCentrosEsportivos: View {
    
    @State var centrosEsportivos = [CentroEsportivo]()
    
    @State private var exibeDetalhesSheet = false
    
    var body: some View {
        // NavigationView {
        ScrollView {
            VStack {
                ForEach(centrosEsportivos, id:\.ceId) { item in
                    //NavigationLink(destination: DetalhesSheet(),  ){
                    
                    Button(action: {exibeDetalhesSheet.toggle()}, label: {
                        centroEsportivoDados(title: item.ceNome, subTitle: item.ceEndereco)
                    })
                        .sheet(isPresented: $exibeDetalhesSheet){
                            DetalhesSheet()
                        }
                    
                }
                
            
        
            // }
        }
    }
    //}
        .onAppear {
            self.centrosEsportivos = DataLoader().centrosEsportivos
        }
        .padding(.top, 40)
    
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




