//
//  SplashScreen.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 25/09/22.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var mostraPaginaPrincipal = false
    @State var tamanho = 0.8
    @State var opacidade = 0.5
    
    var body: some View {
        if mostraPaginaPrincipal {
            TabBarView()
        } else {
            ZStack {
                ZStack {
                    Image("SPorts")
                }
                .scaleEffect(self.tamanho)
                .opacity(self.opacidade)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.tamanho = 0.9
                        self.opacidade = 1
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.mostraPaginaPrincipal = true
                })
            }
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
