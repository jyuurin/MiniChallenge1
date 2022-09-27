//
//  CoresApp.swift
//  MiniChallenge1
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 24/09/22.
//

import SwiftUI

//Enum que contem as cores do design do app
enum CoresApp {
    
    case corPrincipal, corSecundaria, corPlatinum, corColumbiaBlue
    
    func cor() -> Color {
        switch self {
        case .corPrincipal:
            return Color(UIColor(red: 144/255, green: 34/255, blue: 37/255, alpha: 1))
        case .corSecundaria:
            return Color(UIColor(red: 35/255, green: 126/255, blue: 169/255, alpha: 1))
        case .corPlatinum:
            return Color(UIColor(red: 108/255, green: 108/255, blue: 108/255, alpha: 1))
        case .corColumbiaBlue:
            return Color(UIColor(red: 174/255, green: 202/255, blue: 213/255, alpha: 1))
        }
    }
}
