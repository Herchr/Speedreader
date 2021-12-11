//
//  DownloadedBookViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 28/10/2021.
//

import Foundation
import CoreData
import SwiftUI

class DownloadedBookViewModel: ObservableObject{
    
    private let container: NSPersistentContainer
    private let containerName: String = "Speedreader"
    private let entityName: String = "DownloadedBook"
    
    @Published var books: [DownloadedBook] = []
    @Published var currentBook: DownloadedBook?
    
    init(){
        container = PersistenceController.shared.container
        currentBook = self.getBook()
    }
    
    func getBooks(){
        let req = NSFetchRequest<DownloadedBook>(entityName: entityName)
        do{
            books = try container.viewContext.fetch(req)
        }catch let error{
            print("error fetching core data books \(error)")
        }
    }
    
    func getBook() -> DownloadedBook{
//        add(book: Book(id: UUID(), title: "hhallaa", author: "s", img: UIImage(named:"Frankenstein_Or_The_Modern_Prometheus"), text: "KJA", about: "JKW", category: "KA"))
        let req = NSFetchRequest<DownloadedBook>(entityName: entityName)
        var book: DownloadedBook?
        do{
            book = try container.viewContext.fetch(req).first!
        }catch let error{
//            book = convert(book: Book(id: UUID(), title: "hhallaa", author: "s", img: UIImage(named:"Frankenstein_Or_The_Modern_Prometheus"), text: "KJA", about: "JKW", category: "KA"))
            print("error fetching core data books \(error)")
        }
        return book!
    }
    
    func add(book: Book){
        let entity = DownloadedBook(context: container.viewContext)
        
        entity.img = book.img?.pngData()
        entity.title = book.title
        entity.about = book.about
        entity.author = book.author
        entity.text = book.text
        entity.id = UUID()
        
        save()
        getBooks()
    }
    
    func convert(book: Book) -> DownloadedBook{
        let entity = DownloadedBook(context: container.viewContext)
        
        entity.img = book.img?.pngData()
        entity.title = book.title
        entity.about = book.about
        entity.author = book.author
        entity.text = book.text
        entity.id = UUID()
        
        return entity
    }
    
    func delete(entity: DownloadedBook){
        container.viewContext.delete(entity)
        
        save()
        getBooks()
    }
    
    func itemExists(title: String) -> Bool {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.predicate = NSPredicate(format: "title == %@", title)
            let results = try! container.viewContext.fetch(fetchRequest)
            return results.count > 0
    }
    
    func save(){
        do{
            try container.viewContext.save()
        }catch let error{
            print("Error saving to core data \(error)")
        }
    }
}
