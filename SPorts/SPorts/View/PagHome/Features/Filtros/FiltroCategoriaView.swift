//
//  FiltroCategoriaView.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 20/09/22.

import SwiftUI

struct FiltroCategoriaView: View {
    
    //váriável que aux a voltar pra página anterior
    @Environment(\.dismiss) var dismiss
    
    @Binding var arrayCategorias: [String]
    
    
    @State var idsSelecionadas = [Int]()
    
    //MARK: - Setando todas caategorias contidas no json com seus respectivos icones
    
    
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                //MARK: - Grade de categorias dos centros esportivos
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], content: {
                    ForEach(CategoriasCE.categorias.categoriasCE, id: \.idCategoria) { categoria in
                        //Criando o botão que deixará as categorias selecionáveis
                        Button(action: {
                        
                            //Criando variável que vai participar da estrutura condicional pr adicionar um novo item à lista de selecionados
                            var permiteInsercao = true
                            
                            //Se o id da categoria ja estiver dentro da array de selecionados, esse item será removido da lista e a permiçao para inserir um item será negada
                            if(self.idsSelecionadas.count > 0) {
                                for i in 0...self.idsSelecionadas.count - 1 {
                                    if(self.idsSelecionadas[i] == categoria.idCategoria) {
                                        self.idsSelecionadas.remove(at: i)
                                        self.arrayCategorias.remove(at: i)
                                        permiteInsercao = false
                                        break
                                    }
                                }
                            }
                            
                            //Caso permiteInsercao não tenha sido desativado, os comando de dentro da estrutura serão ativados
                            if permiteInsercao {
                                self.idsSelecionadas.append(categoria.idCategoria)
                                self.arrayCategorias.append(categoria.nomeCategoria)
                            }
                            
                        }, label: {
                            //MARK: - Lógica utilizada para deixar cada categoria selecionavel
                            //Se essa categoria ja estiver selecionada, entra no primeiro if, se não, entra no segundo
                            if idsSelecionadas.contains(categoria.idCategoria) {
                                VStack {
                                    Image("\(categoria.nomeSegImagem)")
                                        .resizable()
                                        .frame(width: 35, height: 35, alignment: .center)
                                        
                                    Text(categoria.nomeCategoria)
                                        .font(.system(size: 15))
                                }
                            } else {
                                VStack {
                                    Image("\(categoria.nomePriImagem)")
                                        .resizable()
                                        .frame(width: 35, height: 35, alignment: .center)
                                        
                                    Text(categoria.nomeCategoria)
                                        .font(.system(size: 15))
                                }
                            }
                        })
                        .foregroundColor(CoresApp.corSecundaria.cor())
                    }
                })
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
            .onAppear {
                //Implementando estrutura para pré-definir os filtros pré-existentes ja selecionados
                for itemArrayCategoria in self.arrayCategorias {
                    for categoria in CategoriasCE.categorias.categoriasCE {
                        if itemArrayCategoria == categoria.nomeCategoria {
                            self.idsSelecionadas.append(categoria.idCategoria)
                        }
                    }
                }
            }
        }
        
    }
    
    //MARK: - Função que limpa todas arrays necessárias para a filtragem
    func limparFiltro() {
        self.idsSelecionadas.removeAll()
        self.arrayCategorias.removeAll()
    }
}

struct FiltroCategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        FiltroCategoriaView(arrayCategorias: .constant([String]()))
    }
}
