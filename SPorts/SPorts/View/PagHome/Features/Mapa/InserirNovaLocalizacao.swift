//
//  InserirNovaLocalizacao.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 06/10/22.
//

import SwiftUI
import MapKit

struct InserirNovaLocalizacao: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var txtFieldEndereco = ""
    @State var opcoesEndereco = [String]()
    @State var mostraEndereco = true
    
    @StateObject var mapAPI = MapAPI()
    
    @Binding var localizacaoSetada: CLLocation
    @Binding var nomeLocalizacao: String
    @Binding var localizacaoEnderecoSetado: Bool
    @Binding var identificaMudancaEndereco: Bool
    
    //@Binding var identificaMudancaAbaixarBottomSheet: Bool
    
    var body: some View {
        VStack {
            //Icone arredondado
            Capsule()
            .fill(Color.init(UIColor.systemGray4))
            .frame(width: 50, height: 4)
            .padding(.top, 10)
            
            ScrollView {
                VStack(alignment: .leading) {
                    //MARK: - Search Bar
                    TextField("Digite aqui o endereço desejado", text: $txtFieldEndereco)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.init(UIColor.systemGray6))
                    .cornerRadius(10)
                    
                    Button(action: {
                        //Variáveis para auxiliar no manuseio do endereço escolhido
                        self.identificaMudancaEndereco.toggle()
                        self.localizacaoEnderecoSetado = true
                        self.localizacaoEnderecoSetado = false
                        self.identificaMudancaEndereco.toggle()
                        
                        self.nomeLocalizacao = "Minha Localização"
                        
                        dismiss()
                    }, label: {
                        HStack(alignment: .center) {
                            
                            Image(systemName: "location.fill")
                            .frame(width: 35, height: 35, alignment: .center)
                            .foregroundColor(CoresApp.corPrincipal.cor())
                            
                            Text("Minha Localização")
                            .foregroundColor(.black)
                        }
                    })
                    
                    if mostraEndereco {
                        ForEach(mapAPI.locations.data, id: \.self) { endereco in
                            Divider()
                            Button(action: {
                                //Setando dados do endereço selecionado
                                self.localizacaoSetada = CLLocation(latitude: endereco.latitude, longitude: endereco.longitude)
                                self.nomeLocalizacao = endereco.name ?? ""
                                
                                //Variáveis para auxiliar no manuseio do endereço escolhido
                                self.identificaMudancaEndereco.toggle()
                                self.localizacaoEnderecoSetado = true
                                
                                dismiss()
                            }, label: {
                                HStack {
                                    Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(CoresApp.corPlatinum.cor())
                                    
                                    Text("\(endereco.name ?? "")")
                                    .lineLimit(1)
                                    .foregroundColor(.black)
                                }
                                
                            })
                            .padding(5)
                        }
                    }
                }
                .padding([.bottom, .leading, .trailing])
                
            }
            
            
        }
        .onChange(of: txtFieldEndereco) { _ in
                mapAPI.getLocation(address: txtFieldEndereco)
        }
    }
}

struct InserirNovaLocalizacao_Previews: PreviewProvider {
    static var previews: some View {
        InserirNovaLocalizacao(localizacaoSetada: .constant(CLLocation(latitude: 0.0, longitude: 0.0)), nomeLocalizacao: .constant(""), localizacaoEnderecoSetado: .constant(false), identificaMudancaEndereco: .constant(false))
    }
}
