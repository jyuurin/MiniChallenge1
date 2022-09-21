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
    @Environment(\.dismiss) var dismiss  //váriável que aux a voltar pra página anterior
    
    var onDismiss: ((_ model: [String]) -> Void)?
    
    @Binding var arrayCategorias: [String]
    
    
    @State var idsSelecionadas = [Int]()
    
    //Setando todas caategorias contidas no json com seus respectivos icones
    private var categorias: [Categoria] = [
        Categoria(
            idCategoria: 1,
            nomeCategoria: "Dança",
            nomePriImagem: "figure.dance",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 2,
            nomeCategoria: "Tênis",
            nomePriImagem: "figure.tennis",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 3,
            nomeCategoria: "Vôlei",
            nomePriImagem: "figure.volleyball",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 4,
            nomeCategoria: "Corpo e Mente",
            nomePriImagem: "figure.mind.and.body",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 5,
            nomeCategoria: "Futebol",
            nomePriImagem: "figure.soccer",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 6,
            nomeCategoria: "Ginástica",
            nomePriImagem: "figure.gymnastics",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 7,
            nomeCategoria: "Luta",
            nomePriImagem: "figure.boxing",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 8,
            nomeCategoria: "Aquático",
            nomePriImagem: "figure.pool.swim",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 9,
            nomeCategoria: "Cárdio",
            nomePriImagem: "figure.run",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 10,
            nomeCategoria: "Patinação",
            nomePriImagem: "figure.roller.skate",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 11,
            nomeCategoria: "Condicionamento Físico",
            nomePriImagem: "figure.core.training",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 12,
            nomeCategoria: "Musculação",
            nomePriImagem: "figure.strengthtraining.traditional",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 13,
            nomeCategoria: "Alongamento",
            nomePriImagem: "figure.flexibility",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 14,
            nomeCategoria: "Handebol",
            nomePriImagem: "figure.handball",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 15,
            nomeCategoria: "Beisebol",
            nomePriImagem: "figure.baseball",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 16,
            nomeCategoria: "Basquete",
            nomePriImagem: "figure.basketball",
            nomeSegImagem: ""),
        Categoria(
            idCategoria: 17,
            nomeCategoria: "Funcional",
            nomePriImagem: "figure.strengthtraining.functional",
            nomeSegImagem: "")
    ]
    
    
    
    var body: some View {
        ScrollView {
            
            HStack {
                //Adicionando botão para voltar a view anterior
                Button(action: {
                    //Ativando a função que retorna a view anterior
                    dismiss()
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
                Button(action: {}, label: {
                    Text("Limpar filtro")
                })
                
            }
            .padding()
            
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
                                    permiteInsercao = false
                                    break
                                }
                            }
                        }
                        
                        if permiteInsercao {
                            self.idsSelecionadas.append(categoria.idCategoria)
                        }
                        
                    }, label: {
                        //Se essa categoria ja estiver selecionada, entra no primeiro if, se não, entra no segundo
                        if idsSelecionadas.contains(categoria.idCategoria) {
                            VStack {
                                Image("\(categoria.nomePriImagem)")
                                    .resizable()
                                    .frame(width: 15, height: 18, alignment: .center)
                                    
                                Text(categoria.nomeCategoria)
                                    .font(.system(size: 15))
                            }
                            .foregroundColor(Color(UIColor(red: 35/255, green: 126/255, blue: 169/255, alpha: 1)))
                            .background(Color(UIColor(red: 35/255, green: 126/255, blue: 169/255, alpha: 1)))
                        } else {
                            VStack {
                                Image("\(categoria.nomePriImagem)")
                                    .resizable()
                                    .frame(width: 15, height: 18, alignment: .center)
                                    
                                Text(categoria.nomeCategoria)
                                    .font(.system(size: 15))
                            }
                            .foregroundColor(Color(UIColor(red: 35/255, green: 126/255, blue: 169/255, alpha: 1)))
                        }
                        
                    })
                    
                }
            })
            
        }
        
        
    }
}

struct FiltroCategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        FiltroCategoriaView()
    }
}
