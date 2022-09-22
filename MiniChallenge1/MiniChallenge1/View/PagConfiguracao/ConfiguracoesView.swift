//
//  ConfiguracoesView.swift
//  MiniChallenge1
//
//  Created by Luana Moraes on 13/09/22.
//

import SwiftUI

struct ConfiguracoesView: View {
    
    //Variáveis que decidem para qual página será redirecionado nas configurações
    @State private var acessibilidadeAtivo = false
    @State private var centrosEsportivosAtivo = false
    
    @State var configuracoes = ["Centros Esportivos", "Acessibilidade"]
    var body: some View {
        VStack() {
           
            //Redirecionamentos feitos aguardando a mudança das variáveis acessibilidadeAtivo e centrosEsportivosAtivo
            NavigationLink(destination: CentrosEsportivos(), isActive: $centrosEsportivosAtivo, label: {})
            
            NavigationLink(destination: Acessibilidade(), isActive: $acessibilidadeAtivo, label: {})
            
            
            List {
                ForEach(configuracoes, id: \.self) { configuracao in

                    Button(action: {
                        if configuracao == "Centros Esportivos" {
                            self.centrosEsportivosAtivo = true
                        } else {
                            self.acessibilidadeAtivo = true
                        }
                    }, label: {
                        Text(String(configuracao))
                    })
                
                }
            } .navigationTitle("Configurações")
        }
    }
}

struct ConfiguracoesView_Previews: PreviewProvider {
    static var previews: some View {
        ConfiguracoesView()
    }
}
