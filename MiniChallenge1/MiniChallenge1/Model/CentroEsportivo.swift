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
    var ceEndereco: EnderecoCentroEsportivo
    var ceTelefone: [String]
    var horarioSemana: String
    var horarioFinalSemanaFeriado: String
    var horarioPiscinas: String
    var ceArea: String
    var ceEstrutura: [EstruturaCentroEsportivo]
    var ceModalidades: [ModalidadeCentroEsportivo]
}

//Fazendo uma extensão da struct Centro Esportivo para conformar com algumas funcionalidades que precisamos utilizar no sistema
extension CentroEsportivo: Identifiable {
  var id: Int { ceId }
}
