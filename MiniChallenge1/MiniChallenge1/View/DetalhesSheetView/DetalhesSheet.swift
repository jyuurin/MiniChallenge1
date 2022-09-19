//
//  DetalhesSheet.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 15/09/22.
//

// detalhes sheet vai receber um centro esportivo como parametro.

import SwiftUI

struct DetalhesSheet: View {

    //    var centroEsportivoId: Int
    //    var centroEsportivoNome: String
    //    var centroEsportivoEndereco: String
    //    var centroEsportivoHorario: [String]
    //    var centroEsportivoModalidades: [String]
    //    var centroEsportivoEstruturas: [String]
    
    var centroEsportivoId = 1
    var centroEsportivoNome = "TesteNome"
    var centroEsportivoEndereco = "Rua dos Bobos, 0"
    var centroEsportivoHorario = ["10h40 as 40h35", "19h50 a 10h40", "50h34"]
    var centroEsportivoModalidades = ["Bale", "Dança"]
    var centroEsportivoEstruturas = ["Quadra com Piscina", "Cozinha"]
    
    
    var body: some View {
        
        let buttons = [
            Button(action: {}) {
                Image(systemName: "map")
            },
            Button(action: {}) {
                Image(systemName: "phone")
            }
        ]
        ZStack {
            NavigationView {
                Text("")
            }
            .navigationBarHidden(true)
            //Color.blue.edgesIgnoringSafeArea(.all)
            NavigationViewPersonalizada(buttons: buttons)
            InformacoesCentroEsportivo(centroEsportivoEndereco: centroEsportivoEndereco, centroEsportivoHorario: centroEsportivoHorario)
            //        .onAppear {
            //            self.centrosEsportivos = DataLoader().centrosEsportivos
            //        }
        }
    }
    
}
//centroEsportivoModalidades: centroEsportivoModalidades, centroEsportivoEstruturas: centroEsportivoEstruturas
struct NavigationViewPersonalizada: View {
    
    @Environment(\.dismiss) var dismiss
    
    var centroEsportivoNome = "TesteNome"
    var buttons: [Button<Image>]
    
    var body: some View {
        VStack(alignment: .leading ){
//                NavigationLink {
//                    ExibirCentrosEsportivos()
//                } label: {
//                    Label("Voltar", systemImage: "chevron.left")
//                }
//
//            }
            Button(action: {dismiss()}, label: {
                Image(systemName: "chevron.left")
                Text("Voltar")
            })
                .padding(.leading, 20)
                
            HStack{
                Text(centroEsportivoNome)
                    .font(.system(size: 35, weight: .bold))
                Spacer()
                ForEach(0..<buttons.count) { i in
                    self.buttons[i]
                        .foregroundColor(.blue)
                        .padding(10)
                        .font(.system(size: 20))
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct InformacoesCentroEsportivo: View {
    
    var centroEsportivoEndereco : String
    var centroEsportivoHorario : [String]
    //var centroEsportivoModalidades : [String]
    //var centroEsportivoEstruturas : [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(centroEsportivoEndereco)
            Text("Horário de Funcionamento: \(centroEsportivoHorario[0])")
                .font(.system(size: 5, weight: .bold))
            Text("Finais de Semana / Feriado: \(centroEsportivoHorario[1])")
            Text("Piscinas: \(centroEsportivoHorario[2])")
    }
    
    }
}
struct DetalhesSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetalhesSheet()
        
    }
}
