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
    @Binding var nome_centro_esportivo: String
    @Binding var zona_centro_esportivo: String

    @State var titulo_check_in: String = ""
    @State var data_check_in: Date = NSDate.now
    @State var anotacao_check_in: String = ""
    @State var avaliacao_check_in: String = ""
    
    @Binding var test: Bool
    
    @Binding var checkinSelecionado: Check_In?
    
    @State var usuarioGostou = false
    
    @Binding var salvandoCheckin: Bool
    
    var body: some View {
        VStack {
            
            if !salvandoCheckin {
                Text(checkinSelecionado?.data_check_in?.addingTimeInterval(600) ?? NSDate.now, style: .date)
                    .font(Font.headline.weight(.bold))
                    .foregroundColor(CoresApp.corSecundaria.cor())
                    .padding()
            }
            
            VStack(alignment: .leading) {
                
                if !salvandoCheckin {
                    
                    
                    HStack {
                        Image(zona_centro_esportivo)
                        .resizable()
                        .frame(width: 60, height: 60)
                        Text(nome_centro_esportivo)
                        Spacer()
                    }
                    .padding([.leading, .trailing])
                    
                }
                
                
                
                Text("O que você fez nessa visita?")
                .bold()
                .padding([.top, .leading])

                TextEditor(text: $anotacao_check_in)
                .frame(height: 250)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding(.horizontal)
            }
            

            if !salvandoCheckin  {
                Button(action: {
                    DataController().deleteCheckIn(checkin: self.checkinSelecionado!, context: managedObjectContext)
                    dismiss()
                }, label: {
                    Text("Apagar visita")
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(CoresApp.corPrincipal.cor(), lineWidth: 1))
                })
                .foregroundColor(CoresApp.corPrincipal.cor())
                .padding(.top)
                
                
            }
            Spacer()
            
        }
        .onDisappear {
            self.checkinSelecionado = nil
        }
        .onAppear {
            
            print(self.test)
            
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
                            nome_centro_esportivo: nome_centro_esportivo,
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

