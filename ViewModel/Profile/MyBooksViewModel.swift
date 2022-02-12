//
//  MyBooksViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 01/10/2021.
//

import Foundation
import CoreData

class MyBooksViewModel: ObservableObject {
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    @Published var books: [DownloadedBook] = []
    
    init(){
        self.books = coreDataManager.getBooks()
    }
    func setActiveBook(book: DownloadedBook){
        coreDataManager.setActiveBook(book: book)
    }
    
    func delete(entity: DownloadedBook){
        coreDataManager.delete(entity: entity)
    }
    
    func getActiveBook() -> DownloadedBook?{
        return coreDataManager.getActiveBook()
    }
    
}
