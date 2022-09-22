//
//  DetalhesSheet.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 15/09/22.
//

// detalhes sheet vai receber um centro esportivo como parametro.

import SwiftUI

struct DetalhesSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    var centroEsportivo: CentroEsportivo
    
    
    //    let buttons = [
    //        Button(action: {
    //            botaoLigar()
    //        }) {
    //            Image(systemName: "map")
    //        },
    //        Button(action: {}) {
    //            Image(systemName: "phone")
    //        }
    //    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ) {
                Button(action: {dismiss()}, label: {
                    Image(systemName: "chevron.left")
                    Text("Voltar")
                })
                    .padding(3)
                HStack{
                    Text("\(centroEsportivo.ceNome)")
                        .padding(.bottom, 20)
                        .font(.title.bold())
                        .lineLimit(3)
                }
                
                //EXIBIÇÃO DADOS DO CENTRO ESPORTIVO:
                Group {
                    Button(action: {botaoAbrirMapas(latitudeJson: centroEsportivo.ceEndereco.latitude, longitudeJson: centroEsportivo.ceEndereco.longitude)}) {
                        Text(centroEsportivo.ceEndereco.endereco)
                            .multilineTextAlignment(.leading)
                    }
                    //
                    Button(action: {botaoLigar(numeroTelefone: centroEsportivo.ceTelefone[0])}, label: {
                        Text("**Telefone:** ")
                            .foregroundColor(.black)
                        Text(centroEsportivo.ceTelefone[0])
                    })
                    Spacer()
                    Text("**Horário de Funcionamento:** \(centroEsportivo.horarioSemana)")
                    Text("**Finais de Semana / Feriado:** \(centroEsportivo.horarioFinalSemanaFeriado )")
                    Text("**Piscinas:** \(centroEsportivo.horarioPiscinas)")
                }
                Spacer()
                    .frame(height: 3)
                
                
                //Exibição de MODALIDADES do Centro Esportivo
                Group{
                    Text("Modalidades:")
                        .font(.title2.bold())
                    if(centroEsportivo.ceModalidades.isEmpty == true)
                    {
                        Text("A unidade não possui modalidades disponíveis no momento.")
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(centroEsportivo.ceModalidades.indices) { item in
                                VStack {
                                    Image(systemName: "sportscourt")
                                        .font(.system(size: 20))
                                        .padding(.bottom, 2)
                                    Text(centroEsportivo.ceModalidades[item].modalidade)
                                        .font(.caption)
                                        .lineLimit(2)
                                        .frame(width: 100)
                                        .multilineTextAlignment(.center)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                //Exibição de ESTRUTURAS do Centro Esportivo
                Group{
                    Text("Estrutura:")
                        .font(.title2.bold())
                    if(centroEsportivo.ceEstrutura.isEmpty == true)
                    {
                        Text("Sem informações para esta unidade. Entre em contato através do número de telefone.")
                    }
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(), GridItem()]) {
                            ForEach(centroEsportivo.ceEstrutura.indices) { item in
                                VStack {
                                    Image(systemName: "sportscourt")
                                        .font(.system(size: 20))
                                        .padding(.bottom, 2)
                                    Text(centroEsportivo.ceEstrutura[item].nomeEstrutura)
                                        .font(.caption)
                                        .lineLimit(2)
                                        .frame(width: 100)
                                        .multilineTextAlignment(.center)
                                    
                                }
                                .frame(height: 120)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
        
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

//struct DetalhesSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        DetalhesSheet()
//
//    }
//}
