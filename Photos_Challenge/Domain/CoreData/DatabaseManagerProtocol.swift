//
//  DatabaseManagerProtocol.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/18/22.
//

import CoreData

protocol DatabaseManagerProtocol {
    func fetchListList() -> [ItemModel]
    func addItem(item: ItemModel?)
    func deleteItem(item: ItemModel?)
    func isItem(item: ItemModel?) -> Bool?
}

extension DatabaseManagerProtocol {
    func fetchListList() -> [ItemModel] {
        fetchListList()
    }
}

class DatabaseManager {
    static let shared: DatabaseManagerProtocol = DatabaseManager()
    
    var databaseHelper: CoreDataHelper = CoreDataHelper.shared
        
    private func getItem(for todo: ItemModel) -> DataUser? {
        let predicate =  NSPredicate(format: "id == %@", todo.id ?? "")
        let result = databaseHelper.fetchFirst(DataUser.self, predicate: predicate)
        switch result {
        case .success(let todoMO):
            return todoMO
        case .failure(_):
            return nil
        }
    }
}

// MARK: - DataManagerProtocol
extension DatabaseManager: DatabaseManagerProtocol {
        
    func deleteItem(item: ItemModel?) {
        guard let item = item ,let todoMO = getItem(for: item) else {
            return
        }
        databaseHelper.delete(todoMO)
    }
    
    func isItem(item: ItemModel?) -> Bool? {
        
        guard let item = item ,let _ = getItem(for: item) else {
            return false
        }
        return true
    }
    
    func addItem(item: ItemModel?) {
        let entity = DataUser.entity()
        let newTodo = DataUser(entity: entity, insertInto: databaseHelper.context)
        guard let item = item,!(isItem(item: item) ?? false) else {
            return
        }
        
        newTodo.id = item.id
        newTodo.image = item.image
        databaseHelper.create(newTodo)
    }
    
    func fetchListList() -> [ItemModel] {
        let result: Result<[DataUser], Error> = databaseHelper.fetch(DataUser.self)
        switch result {
        case .success(let todoMOs):
            return todoMOs.map { $0.convertToTodo() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
}
