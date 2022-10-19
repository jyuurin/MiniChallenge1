//
//  AdicionandoOuEditando.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 19/10/22.
//

import SwiftUI
import CoreData

struct AdicionandoOuEditando: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @Binding var id_centro_esportivo: Int

    @State var titulo_check_in: String = ""
    @State var data_check_in: Date = NSDate.now
    @State var anotacao_check_in: String = ""
    @State var avaliacao_check_in: String = ""
    
    @Binding var checkinSelecionado: Check_In?
    
    @State var usuarioGostou = false
    
    @Binding var salvandoCheckin: Bool
    
    var body: some View {
        VStack {

            Text("Observações do usuário")
                .bold()
                .padding()

                TextEditor(text: $anotacao_check_in)
                .frame(height: 250)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white.opacity(1), lineWidth: 1)
                        .shadow(radius: 5)
                )
                .padding()

            if !salvandoCheckin  {
                Button(action: {
                    print("\(anotacao_check_in)")
                }, label: {
                    Text("Apagar visita")
                        .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(CoresApp.corPrincipal.cor(), lineWidth: 1))
                })
                .foregroundColor(CoresApp.corPrincipal.cor())
                .padding(5)
                
            }
            Spacer()
            
        }
        .onDisappear {
            self.checkinSelecionado = nil
        }
        .onAppear {
            if self.checkinSelecionado != nil {
                self.anotacao_check_in = self.checkinSelecionado?.anotacao_check_in ?? ""
            }
        }
        .navigationTitle("Visita")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                    Text("Voltar")
                })
                .foregroundColor(CoresApp.corPrincipal.cor())
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if salvandoCheckin {
                        DataController().addCheckIn(
                            id_centro_esportivo: Int64(id_centro_esportivo),
                            data_check_in: data_check_in,
                            anotacao_check_in: anotacao_check_in,
                            context: managedObjectContext)
                    } else {
                        DataController().editCheckIn(
                            checkin: self.checkinSelecionado!,
                            id_centro_esportivo: self.checkinSelecionado?.id_centro_esportivo ?? 0,
                            data_check_in: self.checkinSelecionado?.data_check_in ?? NSDate.now,
                            anotacao_check_in: self.anotacao_check_in,
                            context: managedObjectContext)
                    }
                    
                    dismiss()
                }, label: {
                    Text("Salvar")
                        .foregroundColor(CoresApp.corPrincipal.cor())
                })
            }
        }
    }
}

