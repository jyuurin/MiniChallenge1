//
//  DetalhesSheet.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 23/09/22.
//

import SwiftUI

struct DetalhesSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    var centroEsportivo: CentroEsportivo
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                        
                    Text("\(centroEsportivo.ceNome)")
                    .padding(.bottom, 20)
                    .font(.title.bold())
                    .lineLimit(3)
                    
                    //EXIBIÇÃO DADOS DO CENTRO ESPORTIVO:
                    Group {
                        Button(action: {
                            botaoAbrirMapas(latitudeJson: centroEsportivo.ceEndereco.latitude, longitudeJson: centroEsportivo.ceEndereco.longitude)
                        }) {
                            Text(centroEsportivo.ceEndereco.endereco)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(CoresApp.corPrincipal.cor())
                        }
                        .padding(.bottom, 5)
                        
                        Button(action: {
                            botaoLigar(numeroTelefone: centroEsportivo.ceTelefone[0])
                        }, label: {
                            Text("**Telefone:** ")
                                .foregroundColor(.black)
                            Text(centroEsportivo.ceTelefone[0])
                                .foregroundColor(CoresApp.corPrincipal.cor())
                        })
                        .padding(.bottom, 10)
                        
                        Text("**Horário de Funcionamento:** \(centroEsportivo.horarioSemana)")
                        Text("**Finais de Semana / Feriado:** \(centroEsportivo.horarioFinalSemanaFeriado )")
                        Text("**Piscinas:** \(centroEsportivo.horarioPiscinas)")
                    }
                    
                    //MARK: - Exibição de MODALIDADES do Centro Esportivo
                    Group {
                        
                        Text("Modalidades:")
                        .font(.title2.bold())
                        .padding(.top, 10)
                        
                        if(centroEsportivo.ceModalidades.isEmpty == true) {
                            Text("A unidade não possui modalidades disponíveis até o momento.")
                            .padding(.vertical, 5)
                        }
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                           
                            ForEach(centroEsportivo.ceModalidades.indices) { indiceModalidade in
                          
                                Text(centroEsportivo.ceModalidades[indiceModalidade].modalidade)
                                .font(.system(size: 15))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .foregroundColor(CoresApp.corSecundaria.cor())
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(CoresApp.corSecundaria.cor(), lineWidth: 1))
                                
                            }
                            
                        })
                    }
                    //MARK: - Exibição de ESTRUTURAS do Centro Esportivo
                    Group {
                        Text("Estrutura:")
                            .font(.title2.bold())
                        if(centroEsportivo.ceEstrutura.isEmpty == true)
                        {
                            Text("Sem informações para esta unidade. Entre em contato através do número de telefone.")
                            .padding(.vertical, 5)
                        }
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            ForEach(centroEsportivo.ceEstrutura.indices) { item in
                                
                             
                                Text(centroEsportivo.ceEstrutura[item].nomeEstrutura)
                                .font(.system(size: 15))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .foregroundColor(CoresApp.corSecundaria.cor())
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(CoresApp.corSecundaria.cor(), lineWidth: 1))
                                    
                               
                            }
                        })
                        
                    }
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
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
            .edgesIgnoringSafeArea(.leading)
            .edgesIgnoringSafeArea(.trailing)
            .edgesIgnoringSafeArea(.bottom)
        }
        
    }
    //função que direciona para o celular da pessoa. Não funciona pelo simulator, testar pelo tel de alguem
    func botaoLigar(numeroTelefone: String) {
        
        let telefone = "tel://"
        let telefoneFormatado = telefone + numeroTelefone
        guard let url = URL(string: telefoneFormatado) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        else {
            print("nunda")
        }
        //Text(numeroTelefone)
    }
    
    //função que direciona para o maps a partir das coordenadas do centro esportivo. O usuario precisa ativar a localizaçao pelo mapas.
    func botaoAbrirMapas(latitudeJson: String, longitudeJson: String) {
        
        let latitude = latitudeJson
        let longitude = longitudeJson
        
        let url = URL(string: "maps://?saddr=&daddr=\(latitude),\(longitude)")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
        
    }
    
    
    
}
