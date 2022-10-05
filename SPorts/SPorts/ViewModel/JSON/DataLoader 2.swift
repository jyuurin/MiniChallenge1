//
//  DataLoader.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 12/09/22.
//

import Foundation

public class DataLoader {
    
    @Published var centrosEsportivos = [CentroEsportivo]()
    
    init() {
        load()
        sort()
    }
    
    //Função que carregará todos os dados contido no arquivo json
    func load() {
        //Localizando o arquivo json
        if let arquivoJSON = Bundle.main.url(forResource: "CentroEsportivoJSON", withExtension: "json" ) {
            do {
                let data = try Data(contentsOf: arquivoJSON)
                let jsonDecoder = JSONDecoder()
                //Decodando os dados do arquivo json para a variável de array de objeto
                let dataFromJson = try jsonDecoder.decode([CentroEsportivo].self, from: data)
                
                self.centrosEsportivos = dataFromJson
                
                return
            } catch {
                print("Não foi possível buscar os dadso do arquivo JSON\n\nErro: \(error)")
            }
        }
        
    }
    
    //Função que organiza o array com itens contidos no arquivo json
    func sort() {
        self.centrosEsportivos = self.centrosEsportivos.sorted(by: { $0.ceId > $1.ceId } )
    }
}
