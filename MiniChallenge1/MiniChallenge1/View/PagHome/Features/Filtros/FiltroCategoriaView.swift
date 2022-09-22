//
//  FiltroCategoriaView.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 20/09/22.

import SwiftUI

struct Categoria {
    var idCategoria: Int
    var nomeCategoria: String
    var nomePriImagem: String
    var nomeSegImagem: String
}

struct FiltroCategoriaView: View {
//    @Environment(\.dismiss) var dismiss  //váriável que aux a voltar pra página anterior
    @Environment(\.presentationMode) var presentationModel
    
//    var onDismiss: ((_ model: [String]) -> Void)?
    
    @Binding var arrayCategorias: [String]
    
    
    @State var idsSelecionadas = [Int]()
    
    //Setando todas caategorias contidas no json com seus respectivos icones
    var categorias: [Categoria] = [
        Categoria(
            idCategoria: 1,
            nomeCategoria: "Dança",
            nomePriImagem: "figure.dance",
            nomeSegImagem: "figure.dance-seg"),
        Categoria(
            idCategoria: 2,
            nomeCategoria: "Tênis",
            nomePriImagem: "figure.tennis",
            nomeSegImagem: "figure.tennis-seg"),
        Categoria(
            idCategoria: 3,
            nomeCategoria: "Vôlei",
            nomePriImagem: "figure.volleyball",
            nomeSegImagem: "figure.volleyball-seg"),
        Categoria(
            idCategoria: 4,
            nomeCategoria: "Corpo e Mente",
            nomePriImagem: "figure.mind.and.body",
            nomeSegImagem: "figure.mind.and.body-seg"),
        Categoria(
            idCategoria: 5,
            nomeCategoria: "Futebol",
            nomePriImagem: "figure.soccer",
            nomeSegImagem: "figure.soccer-seg"),
        Categoria(
            idCategoria: 6,
            nomeCategoria: "Ginástica",
            nomePriImagem: "figure.gymnastics",
            nomeSegImagem: "figure.gymnastics-seg"),
        Categoria(
            idCategoria: 7,
            nomeCategoria: "Luta",
            nomePriImagem: "figure.boxing",
            nomeSegImagem: "figure.boxing-seg"),
        Categoria(
            idCategoria: 8,
            nomeCategoria: "Aquático",
            nomePriImagem: "figure.pool.swim",
            nomeSegImagem: "figure.pool.swim-seg"),
        Categoria(
            idCategoria: 9,
            nomeCategoria: "Cárdio",
            nomePriImagem: "figure.run",
            nomeSegImagem: "figure.run-seg"),
        Categoria(
            idCategoria: 10,
            nomeCategoria: "Patinação",
            nomePriImagem: "figure.roller.skate",
            nomeSegImagem: "figure.roller.skate-seg"),
        Categoria(
            idCategoria: 11,
            nomeCategoria: "Condicionamento Físico",
            nomePriImagem: "figure.core.training",
            nomeSegImagem: "figure.core.training-seg"),
        Categoria(
            idCategoria: 12,
            nomeCategoria: "Musculação",
            nomePriImagem: "figure.strengthtraining.traditional",
            nomeSegImagem: "figure.strengthtraining.traditional-seg"),
        Categoria(
            idCategoria: 13,
            nomeCategoria: "Alongamento",
            nomePriImagem: "figure.flexibility",
            nomeSegImagem: "figure.flexibility-seg"),
        Categoria(
            idCategoria: 14,
            nomeCategoria: "Handebol",
            nomePriImagem: "figure.handball",
            nomeSegImagem: "figure.handball-seg"),
        Categoria(
            idCategoria: 15,
            nomeCategoria: "Beisebol",
            nomePriImagem: "figure.baseball",
            nomeSegImagem: "figure.baseball-seg"),
        Categoria(
            idCategoria: 16,
            nomeCategoria: "Basquete",
            nomePriImagem: "figure.basketball",
            nomeSegImagem: "figure.basketball-seg"),
        Categoria(
            idCategoria: 17,
            nomeCategoria: "Funcional",
            nomePriImagem: "figure.strengthtraining.functional",
            nomeSegImagem: "figure.strengthtraining.functional-seg")
    ]
    
    
    
    var body: some View {
        ScrollView {
            
            HStack {
                //Adicionando botão para voltar a view anterior
                Button(action: {
                    presentationModel.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Voltar")
                    }
                })
                Spacer()
                Text("Filtros")
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    limparFiltro()
                }, label: {
                    Text("Limpar filtro")
                })
                
            }
            .padding()
            .padding(.vertical)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], content: {
                ForEach(self.categorias, id: \.idCategoria) { categoria in
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
                        
                        if permiteInsercao {
                            self.idsSelecionadas.append(categoria.idCategoria)
                            self.arrayCategorias.append(categoria.nomeCategoria)
                        }
                        
                    }, label: {
                        //Se essa categoria ja estiver selecionada, entra no primeiro if, se não, entra no segundo
                        if idsSelecionadas.contains(categoria.idCategoria) {
                            VStack {
                                Image("\(categoria.nomeSegImagem)")
                                    .resizable()
                                    .frame(width: 35, height: 35, alignment: .center)
                                    
                                Text(categoria.nomeCategoria)
                                    .font(.system(size: 15))
                            }
                            .foregroundColor(Color(UIColor(red: 35/255, green: 126/255, blue: 169/255, alpha: 1)))
                        } else {
                            VStack {
                                Image("\(categoria.nomePriImagem)")
                                    .resizable()
                                    .frame(width: 35, height: 35, alignment: .center)
                                    
                                Text(categoria.nomeCategoria)
                                    .font(.system(size: 15))
                            }
                            .foregroundColor(Color(UIColor(red: 35/255, green: 126/255, blue: 169/255, alpha: 1)))
                        }
                        
                    })
                    
                }
            })
            
        }
        .onAppear {
            
            //Implementando estrutura para pré-definir os filtros pré-existentes ja selecionados
            for itemArrayCategoria in self.arrayCategorias {
                for categoria in self.categorias {
                    if itemArrayCategoria == categoria.nomeCategoria {
                        self.idsSelecionadas.append(categoria.idCategoria)
                    }
                }
            }
        }
        
        
        
    }
    
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
