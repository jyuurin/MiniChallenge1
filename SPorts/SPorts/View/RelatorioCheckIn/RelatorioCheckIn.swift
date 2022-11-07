//
//  RelatorioCheckIn.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 19/10/22.
//

import SwiftUI

struct RelatorioCheckIn: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.data_check_in, order: .reverse)]) var checkin: FetchedResults<Check_In>
    
    @Binding var mostrandoPaginaRelatorio: Bool
    
    @State var editarCheckin = false
    @State var checkinSelecionado: Check_In? = nil
    @State var centroEsportivoSelecionado: CentroEsportivo? = nil
    
    
    var body: some View {
        
        VStack {
            
            NavigationLink(destination: AdicionandoOuEditando(id_centro_esportivo: .constant(centroEsportivoSelecionado?.id ?? 0), nome_centro_esportivo: .constant(centroEsportivoSelecionado?.ceNome ?? ""), zona_centro_esportivo: .constant(centroEsportivoSelecionado?.ceZona ?? ""), mostrandoPagCadCheckin: .constant(false), checkinSelecionado: $checkinSelecionado, salvandoCheckin: .constant(false)), isActive: $editarCheckin,  label: {
                
            })
            
            Text("\(String(checkin.count))")
                .font(.system(size: 100, weight: .bold, design: .rounded))
                .foregroundColor(CoresApp.corSecundaria.cor())
                .padding([.top, .bottom], 30)
            
            Text("Visitas aos Centros Esportivos")
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(CoresApp.corSecundaria.cor())
                .padding(.bottom, 30)
            
            
            
            if !checkin.isEmpty {
            
                HStack {
                    Text("Histórico de visitas")
                        .font(Font.headline.weight(.bold))
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    Spacer()
                }
                
                ScrollView {
                    VStack{
                        ForEach(checkin, id: \.id) { check in
                            
                            Button(action: {
                                self.editarCheckin = true
                                self.checkinSelecionado = check
                                self.centroEsportivoSelecionado = achaCentroEsportivoPelaId(id: Int(check.id_centro_esportivo))
                            }, label: {
                                exibirHistoricoVisitas(
                                    nomeCE: check.nome_centro_esportivo ?? "",
                                    anotacaoCE: check.anotacao_check_in,
                                    dataVisita: check.data_check_in ?? NSDate.now)
                            })
                            
                        }
                    }
                    .padding(.vertical, 5)
                    
                }
            }
            
            
        }
        .onAppear {
            self.mostrandoPaginaRelatorio = true
        }
        .navigationBarTitleDisplayMode(.inline)
    
            
        
        
    }
    
    //FUNCAO PARA PARA FORMATAR OS CENTROS QUE VAO SER EXIBIDOS, RECEBE O NOME CENTRO ESPORTIVO, A ANOTACAO DO USUARIO E A DATA DO CHECK IN
    func exibirHistoricoVisitas(nomeCE: String, anotacaoCE: String?, dataVisita: Date) -> some View {
        HStack {
            VStack (alignment: .leading) {
                Text(dataVisita.addingTimeInterval(600), style: .date)
                    .foregroundColor(CoresApp.corSecundaria.cor())
                    .font(Font.headline.weight(.bold))
                    .padding(.bottom, 5)
                
                Text("\(nomeCE)")
                    .foregroundColor(CoresApp.corSecundaria.cor())
                    .padding(.bottom, 5)
                    .lineLimit(1)
            
                if anotacaoCE != ""{
                    Text(anotacaoCE!)
                    .foregroundColor(CoresApp.corPlatinum.cor())
                    .lineLimit(1)
                } else {
                    Text("Sem anotações até o momento.")
                    .foregroundColor(CoresApp.corPlatinum.cor())
                    .lineLimit(1)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
            .foregroundColor(CoresApp.corSecundaria.cor())
        }
        .padding()
        .background(Rectangle()
            .fill(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3))
        .padding([.leading, .trailing])
        
    }
    
    func achaCentroEsportivoPelaId(id: Int) -> CentroEsportivo {
        for centroEsportivo in DataLoader().centrosEsportivos {
            if centroEsportivo.id == id {
                return centroEsportivo
            }
        }
        
        return CentroEsportivo(
            ceId: 0,
            ceNome: "",
            ceZona: "",
            ceEndereco: EnderecoCentroEsportivo(
                endereco: "",
                latitude: "",
                longitude: ""),
            ceTelefone: [],
            horarioSemana: "",
            horarioFinalSemanaFeriado: "",
            horarioPiscinas: "",
            ceArea: "",
            ceEstrutura: [],
            ceModalidades: [])
    }
   
}
