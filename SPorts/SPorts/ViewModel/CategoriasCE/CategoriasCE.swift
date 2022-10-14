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
    var zonas: [String]
}

public class CategoriasCE {
    public var categoriasCE: [Categoria]
    
    static let categorias: CategoriasCE = CategoriasCE(
        categoriasCE: [
            Categoria(
                idCategoria: 1,
                nomeCategoria: "Dança",
                nomePriImagem: "figure.dance",
                nomeSegImagem: "figure.dance-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste"]
            ),
            Categoria(
                idCategoria: 2,
                nomeCategoria: "Tênis",
                nomePriImagem: "figure.tennis",
                nomeSegImagem: "figure.tennis-seg",
                zonas: ["Zona Norte","Zona Sul","Zona Leste","Região Central"]
            ),
            Categoria(
                idCategoria: 3,
                nomeCategoria: "Vôlei",
                nomePriImagem: "figure.volleyball",
                nomeSegImagem: "figure.volleyball-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste", "Zona Oeste", "Região Central"]
            ),
            Categoria(
                idCategoria: 4,
                nomeCategoria: "Corpo e Mente",
                nomePriImagem: "figure.mind.and.body",
                nomeSegImagem: "figure.mind.and.body-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste", "Zona Oeste", "Região Central"]),
            Categoria(
                idCategoria: 5,
                nomeCategoria: "Futebol",
                nomePriImagem: "figure.soccer",
                nomeSegImagem: "figure.soccer-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste", "Região Central"]),
            Categoria(
                idCategoria: 6,
                nomeCategoria: "Ginástica",
                nomePriImagem: "figure.gymnastics",
                nomeSegImagem: "figure.gymnastics-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste", "Zona Oeste", "Região Central"]),
            Categoria(
                idCategoria: 7,
                nomeCategoria: "Luta",
                nomePriImagem: "figure.boxing",
                nomeSegImagem: "figure.boxing-seg",
                zonas: ["Zona Sul", "Zona Leste"]),
            Categoria(
                idCategoria: 8,
                nomeCategoria: "Aquático",
                nomePriImagem: "figure.pool.swim",
                nomeSegImagem: "figure.pool.swim-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste"]),
            Categoria(
                idCategoria: 9,
                nomeCategoria: "Cárdio",
                nomePriImagem: "figure.run",
                nomeSegImagem: "figure.run-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste", "Zona Oeste"]),
            Categoria(
                idCategoria: 10,
                nomeCategoria: "Patinação",
                nomePriImagem: "figure.roller.skate",
                nomeSegImagem: "figure.roller.skate-seg",
                zonas: ["Zona Sul", "Zona Leste"]),
            Categoria(
                idCategoria: 11,
                nomeCategoria: "Condicionamento Físico",
                nomePriImagem: "figure.core.training",
                nomeSegImagem: "figure.core.training-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste", "Zona Oeste", "Região Central"]),
            Categoria(
                idCategoria: 12,
                nomeCategoria: "Musculação",
                nomePriImagem: "figure.strengthtraining.traditional",
                nomeSegImagem: "figure.strengthtraining.traditional-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste"]),
            Categoria(
                idCategoria: 13,
                nomeCategoria: "Alongamento",
                nomePriImagem: "figure.flexibility",
                nomeSegImagem: "figure.flexibility-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste", "Zona Oeste", "Região Central"]),
            Categoria(
                idCategoria: 14,
                nomeCategoria: "Handebol",
                nomePriImagem: "figure.handball",
                nomeSegImagem: "figure.handball-seg",
                zonas: ["Zona Norte", "Zona Sul"]),
            Categoria(
                idCategoria: 15,
                nomeCategoria: "Beisebol",
                nomePriImagem: "figure.baseball",
                nomeSegImagem: "figure.baseball-seg",
                zonas: ["Região Central"]),
            Categoria(
                idCategoria: 16,
                nomeCategoria: "Basquete",
                nomePriImagem: "figure.basketball",
                nomeSegImagem: "figure.basketball-seg",
                zonas: ["Zona Norte"]),
            Categoria(
                idCategoria: 17,
                nomeCategoria: "Funcional",
                nomePriImagem: "figure.strengthtraining.functional",
                nomeSegImagem: "figure.strengthtraining.functional-seg",
                zonas: ["Zona Norte", "Zona Sul", "Zona Leste", "Zona Oeste", "Região Central"]
            )
        ]
    )
    
    init(categoriasCE: [Categoria]) {
        self.categoriasCE = categoriasCE
    }
}
