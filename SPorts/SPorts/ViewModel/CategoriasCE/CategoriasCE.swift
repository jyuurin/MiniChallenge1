//
//  CategoriasCE.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 10/10/22.
//

import Foundation
import SwiftUI

public struct Categoria {
    var idCategoria: Int
    var nomeCategoria: String
    var nomePriImagem: String
    var nomeSegImagem: String
}

public class CategoriasCE {
    public var categoriasCE: [Categoria]
    
    static let categorias: CategoriasCE = CategoriasCE(
        categoriasCE: [
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
    )
    
    init(categoriasCE: [Categoria]) {
        self.categoriasCE = categoriasCE
    }
}
