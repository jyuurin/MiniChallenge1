//
//  TerceiraPaginaTutorial.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 17/10/22.
//

import SwiftUI

struct TerceiraPaginaTutorial: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var sairTutorial = false
    
    var body: some View {
        VStack {
            
            NavigationLink(isActive: $sairTutorial, destination: {
                SplashScreen()
                    .navigationBarTitle("")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }, label: {})
            
            Spacer()
            
            Image("grupoDeIcones")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
                .padding()
            
            Text("Busque o Centro Esportivo ideal para você praticar seu esporte favorito. \n\nFaça a busca do seu jeito!\n\n**Vamos lá?!**")
                .padding()
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(
                action: {
                    UserDefaults.standard.set(
                        true,
                        forKey: "passouTutorial")
                    self.sairTutorial = true
                },
                label: {
                    Text("Vamos!")
                    .foregroundColor(CoresApp.corPrincipal.cor())
                })
            .padding(.bottom, 10)
            .buttonStyle(.bordered)
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                    Text("Voltar")
                })
                .foregroundColor(CoresApp.corPrincipal.cor())
            }
        }
        
    }
}
