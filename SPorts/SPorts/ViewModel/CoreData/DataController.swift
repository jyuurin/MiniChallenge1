//
//  DataController.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 18/10/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    //Selecionando a entidade que será manipulada e adicionando à uma variável
    let container = NSPersistentContainer(name: "Check_In")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load Core Dara \(error.localizedDescription)")
            }
        }
    }
    
    //Função para ir salvando constantemente as alterações
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Dados foram salvas ")
        } catch {
            print("Nós não conseguimos te ajudar no momento.")
        }
    }        
    
    //Função que adiciona um novo CheckIn
    func addCheckIn(nome_centro_esportivo: String, id_centro_esportivo: Int64, data_check_in: Date, anotacao_check_in: String, context: NSManagedObjectContext) {
        let checkin = Check_In(context: context)
        
        checkin.id = UUID()
        checkin.nome_centro_esportivo = nome_centro_esportivo
        checkin.id_centro_esportivo = id_centro_esportivo
        checkin.data_check_in = data_check_in
        checkin.anotacao_check_in = anotacao_check_in
        
        save(context: context)
    }
    
    //Função que edita um CheckIn em específico
    func editCheckIn(checkin: Check_In, id_centro_esportivo: Int64, data_check_in: Date, anotacao_check_in: String, context: NSManagedObjectContext) {
        checkin.data_check_in = data_check_in
        checkin.anotacao_check_in = anotacao_check_in
        
        save(context: context)
    }
}
