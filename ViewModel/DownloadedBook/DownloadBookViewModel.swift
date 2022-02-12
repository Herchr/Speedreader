//
//  DownloadedBookViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 28/10/2021.
//

import Foundation
import CoreData
import SwiftUI

class DownloadBookViewModel: ObservableObject{
    
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    
    @Published var books: [DownloadedBook] = []
    
    
    
    func downloadBook(book: Book){
        coreDataManager.downloadBook(book: book)
    }
    
    func itemExists(title: String) -> Bool {
        return coreDataManager.itemExists(title: title)
    }
}
