//
//  CentrosEsportivosFavoritos.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 01/11/22.
//

import SwiftUI

class CentrosEsportivosFavoritos: ObservableObject {
    @Published var cesFavoritos: [CentroEsportivo] = []
    
    var fezMudanca = false
    
    //Criando a variável que será a chave para guardar os objetos em JSON
    let cesFavoritosChave = "cesFavoritos"
    
    init() {
        buscandoCentroEsportivoFavorito()
    }
    
    //Função que busca dos itens armazenados no JSON
    func buscandoCentroEsportivoFavorito() {
        guard
            let dados = UserDefaults.standard.data(forKey: cesFavoritosChave),
            let dadosSalvos = try? JSONDecoder().decode([CentroEsportivo].self, from: dados)
        else { return }
        
        self.cesFavoritos = dadosSalvos
    }
    
    //Função que salva a lista de centros esportivos favoritados
    func salvarCentroEsportivoFavorito() {
        //Tentando encondar a lista de objetos no JSON
        if let encodedData = try? JSONEncoder().encode(cesFavoritos) {
            //Aqui vamos inserir a lista transformada em JSON para o userDefaults
            UserDefaults.standard.set(encodedData, forKey: cesFavoritosChave)
        }
    }
    
    //Função que desfavorita o item selecionado e salva novamente a nova lista de favoritados
    func desfavoritandoCentroEsportivo(indice: Int) {
        cesFavoritos.remove(at: indice)
        salvarCentroEsportivoFavorito()
    }
}
