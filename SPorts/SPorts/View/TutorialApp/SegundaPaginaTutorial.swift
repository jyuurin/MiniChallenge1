//
//  SegundaPaginaTutorial.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 17/10/22.
//

import SwiftUI

struct SegundaPaginaTutorial: View {
    
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
            
            Image("SPorts")
                .resizable()
                .frame(width: 200, height: 40, alignment: .center)
                .padding()
            
            Text("SPorts foi criado para reunir todos os Centros Esportivos de **SÃO PAULO** e exibir a localização de cada um através de um mapa.")
                .padding()
                .multilineTextAlignment(.center)
                
            Spacer()
            
            NavigationLink(
                destination: TerceiraPaginaTutorial(),
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
                    Image(systemName: "chevron.left")
                    Text("Voltar")
                })
                .foregroundColor(CoresApp.corPrincipal.cor())
            }
        }
    }
}
