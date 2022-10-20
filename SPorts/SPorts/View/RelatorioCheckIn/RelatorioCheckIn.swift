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
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("\(String(checkin.count))")
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                        .foregroundColor(CoresApp.corSecundaria.cor())
                        .padding([.top, .bottom], 40)
                    Text("Visitas aos Centros Esportivos")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(CoresApp.corSecundaria.cor())
                        .padding(.bottom, 40)
                    Text("Histórico de visitas")
                        .multilineTextAlignment(.leading)
                    
                    ForEach(checkin, id: \.id) { check in
                        exibirHistoricoVisitas(
                            nomeCE: achaCentroEsportivoPelaId(
                                id: Int(check.id_centro_esportivo)).ceNome,
                            anotacaoCE: check.anotacao_check_in,
                            dataVisita: check.data_check_in ?? NSDate.now)
                    }
                    
                    
                }
                
            }
        }
        .onAppear {
            self.mostrandoPaginaRelatorio = true
        }
        .onDisappear {
            self.mostrandoPaginaRelatorio = false
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
        .background(Rectangle().fill(Color.white).cornerRadius(10).shadow(radius: 5).opacity(0.6))
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
