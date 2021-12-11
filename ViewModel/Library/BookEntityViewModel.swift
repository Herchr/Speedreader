////
////  BookEntityViewModel.swift
////  Speedreader
////
////  Created by Herman Christiansen on 01/10/2021.
////
//
//import Foundation
//import CoreData
//
//class BookEntityViewModel: ObservableObject {
//    let container: NSPersistentContainer
//
//    init() {
//        container = NSPersistentContainer(name: "Speedreader")
//        container.loadPersistentStores { (description, error) in
//            if let error = error {
//                print("Error loading data. \(error)")
//            } else {
//                //print("Successfully loaded data")
//            }
//        }
//    }
//
////    func fetchBooks(){
////        let req = NSFetchRequest<BookEntity>(entityName: "BookEntity")
////
////        do {
////            downloadedBooks = try container.viewContext.fetch(req)
////        } catch let error {
////            print(error)
////        }
////    }
//
//    func addBook(book: BookViewModel) {
//        let newBook = Book(context: container.viewContext)
//        newBook.about = book.about
//        newBook.author = book.author
//        newBook.text = book.text
//        newBook.img = book.img
//        newBook.title = book.title
//        saveData()
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
