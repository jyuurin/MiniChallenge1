//
//  NavigationBarView.swift
//  MiniChallenge1
//
//  Created by Luana Moraes on 13/09/22.
//

import SwiftUI

struct NavigationBarView: View {
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
          coloredAppearance.configureWithOpaqueBackground()
          coloredAppearance.backgroundColor = .white
          
          UINavigationBar.appearance().standardAppearance = coloredAppearance
          UINavigationBar.appearance().compactAppearance = coloredAppearance
          UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    var body: some View {
       
        Text("")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                
                Image(systemName: "location.fill")
                Text("Localização atual")
                    .padding(.trailing, 150)
                    
                NavigationLink(destination: ConfiguracoesView()) {
                    Image(systemName: "gearshape")
                }
                
            }
        }
        .foregroundColor(.blue)
        
            
        
      
            
        
        
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
