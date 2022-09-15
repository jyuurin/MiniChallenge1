//
//  CantoPersonalizado.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 12/09/22.
//

import SwiftUI

struct CustomCorner: Shape {
   
    var corners: UIRectCorner
    var radius: CGFloat
    
    //Recebe um retangulo e retorna um retangulo com os cantos arredondados
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
