//
//  DetalhesSheet.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 23/09/22.
//

import SwiftUI
import CoreData

struct DetalhesSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.data_check_in, order: .reverse)]) var checkin: FetchedResults<Check_In>
    
    @Binding var centroEsportivoCDistancia: CentroEsportivoCDistancia
    
    @State var fezCheckin = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                    
                Text("\(centroEsportivoCDistancia.centroEsportivo.ceNome)")
                
                .font(.title.bold())
                .lineLimit(3)
                
                Text(String(format: "%.1f Km", centroEsportivoCDistancia.distancia/1000))
                .foregroundColor(.gray)
                .padding(.bottom, 20)
                
                //EXIBIÇÃO DADOS DO CENTRO ESPORTIVO:
                Group {
                    HStack {
                        Text(centroEsportivoCDistancia.centroEsportivo.ceEndereco.endereco)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(CoresApp.corPrincipal.cor())
                        
                        Button(action: {
                            botaoAbrirMapas(latitudeJson: centroEsportivoCDistancia.centroEsportivo.ceEndereco.latitude, longitudeJson: centroEsportivoCDistancia.centroEsportivo.ceEndereco.longitude)
                        }) {
                            Image(systemName: "arrowshape.turn.up.right.circle")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(CoresApp.corPrincipal.cor())
                        }
                    }
                    .padding(.bottom, 5)
                    
                    
                    Button(action: {
                        botaoLigar(numeroTelefone: centroEsportivoCDistancia.centroEsportivo.ceTelefone[0])
                    }, label: {
                        Text("**Telefone:** ")
                            .foregroundColor(.black)
                        Text(centroEsportivoCDistancia.centroEsportivo.ceTelefone[0])
                            .foregroundColor(CoresApp.corPrincipal.cor())
                    })
                    .padding(.bottom, 10)
                    
                    Text("**Horário de Funcionamento:** \(centroEsportivoCDistancia.centroEsportivo.horarioSemana)")
                    Text("**Finais de Semana / Feriado:** \(centroEsportivoCDistancia.centroEsportivo.horarioFinalSemanaFeriado )")
                    Text("**Piscinas:** \(centroEsportivoCDistancia.centroEsportivo.horarioPiscinas)")
                }
                
                //MARK: - Exibição de MODALIDADES do Centro Esportivo
                Group {
                    
                    Text("Modalidades:")
                    .font(.title2.bold())
                    .padding(.top, 10)
                    
                    if(centroEsportivoCDistancia.centroEsportivo.ceModalidades.isEmpty == true) {
                        Text("A unidade não possui modalidades disponíveis até o momento.")
                        .padding(.vertical, 5)
                    }
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible())],
                        alignment: .leading,
                        content: {
                       
                        ForEach(centroEsportivoCDistancia.centroEsportivo.ceModalidades.indices, id: \.self) { indiceModalidade in

                            Text(centroEsportivoCDistancia.centroEsportivo.ceModalidades[indiceModalidade].modalidade)
                            .font(.system(size: 15))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .foregroundColor(CoresApp.corPlatinum.cor())
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(CoresApp.corPlatinum.cor(), lineWidth: 1))

                        }
                        
                    })
                }
                //MARK: - Exibição de ESTRUTURAS do Centro Esportivo
                Group {
                    Text("Estrutura:")
                        .font(.title2.bold())
                    if(centroEsportivoCDistancia.centroEsportivo.ceEstrutura.isEmpty == true)
                    {
                        Text("Sem informações para esta unidade. Entre em contato através do número de telefone.")
                        .padding(.vertical, 5)
                    }
                    
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible())],
                        alignment: .leading,
                        content: {
                        ForEach(centroEsportivoCDistancia.centroEsportivo.ceEstrutura.indices, id: \.self) { item in
                            
                         
                            Text(centroEsportivoCDistancia.centroEsportivo.ceEstrutura[item].nomeEstrutura)
                            .font(.system(size: 15))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .foregroundColor(CoresApp.corPlatinum.cor())
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(CoresApp.corPlatinum.cor(), lineWidth: 1))
                                
                           
                        }
                    })
                    
                }
                
                Group {
                    Text("Check-ins")
                        .font(.title2.bold())
                    
                    if self.fezCheckin {
                        ForEach(checkin, id: \.id) { check in
                            HStack {
                                if check.id_centro_esportivo == centroEsportivoCDistancia.centroEsportivo.id {
                                    Text(check.data_check_in?.addingTimeInterval(600) ?? NSDate.now, style: .date)
                                        .padding()
                                        .overlay(RoundedRectangle(cornerRadius: 5)
                                                    .stroke(CoresApp.corPrincipal.cor(), lineWidth: 1))
                                        .foregroundColor(CoresApp.corPrincipal.cor())
                                    Text(check.anotacao_check_in ?? "")
                                    
                                    
                                }
                                
                                
                            }
                            .padding(.vertical, 5)
                        }
                    } else {
                        Text("Você ainda não fez Check-in nesse Centro Esportivo.")
                            .padding(.vertical, 5)
                    }
                    
                    
                }
                
            }
            .padding()
            .onAppear {
                for check in checkin {
                    if check.id_centro_esportivo == centroEsportivoCDistancia.centroEsportivo.id {
                        self.fezCheckin = true
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.leading)
        .edgesIgnoringSafeArea(.trailing)
        .edgesIgnoringSafeArea(.bottom)
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
            
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AdicionandoOuEditando(id_centro_esportivo: .constant(centroEsportivoCDistancia.centroEsportivo.id), titulo_check_in: "", data_check_in: NSDate.now, anotacao_check_in: "", avaliacao_check_in: ""), label: {
                    Text("Novo CheckIn")
                })
            }
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
