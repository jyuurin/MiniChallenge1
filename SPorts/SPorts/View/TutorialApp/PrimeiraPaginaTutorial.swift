//
//  PrimeiraPaginaTutorial.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 17/10/22.
//

import SwiftUI

struct PrimeiraPaginaTutorial: View {
    
    @State var sairTutorial = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $sairTutorial, destination: {
                    SplashScreen()
                        .navigationBarTitle("")
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                }, label: {})
                
                Spacer()
                
                Image("saoPauloCity")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding()
                    
                Text("**Centros Esportivos (CEs) são estruturas públicas que oferecem diversas atividades esportivas para a saúde, bem-estar e lazer da população de todas as regiões da cidade de São Paulo.**")
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                NavigationLink(
                    destination: SegundaPaginaTutorial(),
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
        }
    }
}
