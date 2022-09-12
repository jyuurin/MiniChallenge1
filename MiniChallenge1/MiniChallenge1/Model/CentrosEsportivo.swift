//
//  CentrosEsportivos.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 12/09/22.
//

import Foundation


struct CentroEsportivo: Codable {
    var ceId: Int
    var ceNome: String
    var ceZona: String
    var ceEndereco: String
    var ceTelefone: [String]
    var horarioSemana: String
    var horarioFinalSemanaFeriado: String
    var horarioPiscinas: String
    var ceArea: String
    var ceEstrutura: [EstruturaCentroEsportivo]
    var ceModalidades: [String]
}
