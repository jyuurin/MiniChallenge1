//
//  RelatorioCheckIn.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 19/10/22.
//

import SwiftUI

struct RelatorioCheckIn: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.data_check_in, order: .reverse)]) var checkin: FetchedResults<Check_In>
    
    @Binding var mostrandoPaginaRelatorio: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(String(checkin.count))")
                    .font(.title.bold())
                
                Text("Total de Check-ins ja feitos!")
                    .font(.title2.bold())
                    .padding(.top, 10)
            }
            .onAppear {
                self.mostrandoPaginaRelatorio = true
            }
            .onDisappear {
                self.mostrandoPaginaRelatorio = false
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        
    }
}
