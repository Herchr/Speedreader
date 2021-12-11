//
//  MyBooksViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 01/10/2021.
//

import Foundation
import CoreData

//class MyBooksViewModel: ObservableObject {
//    let container: NSPersistentContainer
//    @Published var downloadedBooks: [BookEntity] = []
//    
//    init() {
//        container = NSPersistentContainer(name: "Speedreader")
//        container.loadPersistentStores { (description, error) in
//            if let error = error {
//                print("Error loading data. \(error)")
//            } else {
//                print("Successfully loaded data")
//            }
//        }
//        fetchBooks()
//    }
//
//    func fetchBooks(){
//        let req = NSFetchRequest<BookEntity>(entityName: "BookEntity")
//        do {
//            downloadedBooks = try container.viewContext.fetch(req)
//        } catch let error {
//            print(error)
//        }
//    }
//
//    func saveData() {
//        do{
//            try container.viewContext.save()
//        } catch let error {
//            print(error)
//        }
//    }
//}
