//
//  FiltroZonaView.swift
//  MiniChallenge1
//
//  Created by Luana Moraes on 19/09/22.
//

import SwiftUI

struct FiltroZonaView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var zonas: [String] = ["Zona Sul", "Zona Norte", "Zona Leste", "Zona Oeste", "Região Central"]
    
    @Binding var zonasSelecionadas: [String]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                //MARK: - Grade de zonas dos centros esportivos
                LazyVGrid(columns: [GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())]) {
                    ForEach(zonas, id: \.self) { zona in
                        //Criando o botão que deixará as zonas selecionáveis
                        Button {
                            
                            //Criando variável que vai participar da estrutura condicional pra adicionar um novo item à lista de selecionados
                            var permiteInsercao = true
                            
                            //Se o id da zona ja estiver dentro da array de selecionados, esse item será removido da lista e a permiçao para inserir um item será negada
                            if self.zonasSelecionadas.count > 0 {
                                for i in 0...self.zonasSelecionadas.count-1 {
                                    if self.zonasSelecionadas[i] == zona {
                                        self.zonasSelecionadas.remove(at: i)
                                        permiteInsercao = false
                                        break
                                    }
                                }
                            }
                            
                            //Caso permiteInsercao não tenha sido desativado, os comando de dentro da estrutura serão ativados
                            if permiteInsercao {
                                self.zonasSelecionadas.append(zona)
                            }
                        } label: {
                            //MARK: - Lógica utilizada para deixar cada zona selecionavel
                            //Se essa zona ja estiver selecionada, entra no primeiro if, se não, entra no segundo
                            if(self.zonasSelecionadas.contains(zona)) {
                                Text(zona)
                                    .font(.system(size: 15))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .foregroundColor(.white)
                                    .background(CoresApp.corSecundaria.cor())
                                    .cornerRadius(10)
                            } else {
                                Text(zona)
                                    .font(.system(size: 15))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .foregroundColor(CoresApp.corSecundaria.cor())
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(CoresApp.corSecundaria.cor(), lineWidth: 1))
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Filtrar")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    //Adicionando botão para voltar a view anterior
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Voltar")
                        }
                    })
                    .foregroundColor(CoresApp.corPrincipal.cor())
                })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    //Setando botão de limpar filtros por categoria
                    Button(action: {
                        limparFiltro()
                    }, label: {
                        Text("Limpar")
                    })
                    .foregroundColor(CoresApp.corPrincipal.cor())
                })
            }
        }
        
        
    }
    
    //MARK: - Função que limpa todas arrays necessárias para a filtragem
    func limparFiltro() {
        self.zonasSelecionadas = []
    }

}


struct FiltroZonaView_Previews: PreviewProvider {
    static var previews: some View {
        FiltroZonaView(zonasSelecionadas: .constant([String]()))
    }
}
