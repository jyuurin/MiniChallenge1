//
//  FiltroZonaView.swift
//  MiniChallenge1
//
//  Created by Luana Moraes on 19/09/22.
//

import SwiftUI

struct Zona {
    var idZona: Int
    var nomeZona: String
    var identificadorZona: String
}

struct FiltroZonaView: View {
    
    @State var zonas: [String] = ["Zona Sul", "Zona Norte", "Zona Leste", "Zona Oeste", "Região Central"]
    @Binding var zonaSelecionada: [String]
    var body: some View {
        
        ScrollView {
            
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "chevron.left")
                    Text("Voltar")
                })
                
                Spacer()
                Text("Filtros")
                    .foregroundColor(.black)
                Spacer()
                Button(action: {}, label: {
                    Text("Limpar")
                })
            }
            .padding(.horizontal)
            .padding(.bottom)

            LazyVGrid(columns: [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())]) {
                ForEach(zonas, id: \.self) { zona in
                    Button {
                        
                    } label: {
                        Text(zona)
                            .font(.system(size: 15))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 1))

                    
                }
                
            }
                                
        }
        
    }

}


struct FiltroZonaView_Previews: PreviewProvider {
    static var previews: some View {
        FiltroZonaView(zonaSelecionada: .constant([String]()))
    }
}
