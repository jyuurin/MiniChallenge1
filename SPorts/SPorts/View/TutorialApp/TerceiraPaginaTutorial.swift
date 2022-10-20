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
            
            Image("pagRelatorio")
                .resizable()
                .frame(width: 260, height: 350, alignment: .center)
                .padding()
            
            Text("**Registre suas visitas aos Centros Esportivos relatando sua experiência no local!**")
            Spacer()
            
            NavigationLink(
                destination: quartaPaginaTutorial(),
                label: {
                    Text("Próximo")
                    .foregroundColor(CoresApp.corPrincipal.cor())
                })
            .padding(.bottom, 10)
            .buttonStyle(.bordered)
            
            Button(
                action: {
                    UserDefaults.standard.set(
                        true,
                        forKey: "passouTutorial")
                    self.sairTutorial = true
                },
                label: {
                    Text("Já entendi!")
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
                    Text("Voltar")
                })
                .foregroundColor(CoresApp.corPrincipal.cor())
            }
        }
        
    }
}
