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
    
    func load() {
        if let arquivoJSON = Bundle.main.url(forResource: "CentroEsportivoJSON", withExtension: "json" ) {
            do {
                let data = try Data(contentsOf: arquivoJSON)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([CentroEsportivo].self, from: data)
                
                self.centrosEsportivos = dataFromJson
                
                return
            } catch {
                print("Não foi possível buscar os dadso do arquivo JSON\n\nErro: \(error)")
            }
        }
        
    }
    
    func sort() {
        self.centrosEsportivos = self.centrosEsportivos.sorted(by: { $0.ceId > $1.ceId } )
    }
}
