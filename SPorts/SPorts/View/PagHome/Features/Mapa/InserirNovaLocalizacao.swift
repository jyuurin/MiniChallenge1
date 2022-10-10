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
    @State var cont = 0
    
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
                        self.localizacaoEnderecoSetado = false
                        self.identificaMudancaEndereco.toggle()
                        //self.identificaMudancaAbaixarBottomSheet.toggle()
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
                    Divider()
                    if mostraEndereco {
                        ForEach(opcoesEndereco, id: \.self) { endereco in
                            Button(action: {
                                self.nomeLocalizacao = endereco
                                self.identificaMudancaEndereco.toggle()
                                //self.identificaMudancaAbaixarBottomSheet.toggle()
                                self.localizacaoEnderecoSetado = true
                                dismiss()
                            }, label: {
                                Text("\(endereco)")
                                    .foregroundColor(.black)
                            })
                        }
                    }
                    
                }
                .padding([.bottom, .leading, .trailing])
                
            }
            
            
        }
        .onChange(of: txtFieldEndereco) { _ in
            
            if cont >= 1 {
                encontraCoordenadasPeloEndereco(endereco: txtFieldEndereco, completion: { localizacao, enderecos, mostraEnderecoFuncao in
                    DispatchQueue.main.async {
                        opcoesEndereco = enderecos
                        localizacaoSetada = localizacao
                        mostraEndereco = mostraEnderecoFuncao
                    }
                })
                cont = 0
            } else {
                cont = cont + 1
            }
            
        }
        
        
    }
}

struct InserirNovaLocalizacao_Previews: PreviewProvider {
    static var previews: some View {
        InserirNovaLocalizacao(localizacaoSetada: .constant(CLLocation(latitude: 0.0, longitude: 0.0)), nomeLocalizacao: .constant(""), localizacaoEnderecoSetado: .constant(false), identificaMudancaEndereco: .constant(false))
    }
}
