//
//  Contants.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import Foundation
import UIKit
import CoreData
import SwiftUI



struct Constants {
    static let dummyText: String = "Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear. Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear"
    
    var books: [Book] = [Book(title: "Frankenstein", author: "Mary Shelley", img: UIImage(named: "Frankenstein_Or_The_Modern_Prometheus"), text: "sksksks", about: "Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear.", category: "Fiction")]

//    var initialBookEntity: DownloadedBook = DownloadedBook.init()
//    init(){
//        func getBookEntity() -> DownloadedBook{
//            let entity: DownloadedBook = DownloadedBook.init()
//            entity.title = "Dummy"
//            entity.text = "nsnsn"
//            entity.img = UIImage(named:"Initial_Book")!.pngData()
//            return entity
//        }
//
//
//        initialBookEntity = getBookEntity()
//    }
//    func getBookEntity() -> DownloadedBook{
//        let entity: DownloadedBook = DownloadedBook.init()
//        entity.title = "Dummy"
//        entity.text = "nsnsn"
//        entity.img = UIImage(named:"Initial_Book")!.pngData()
//        return entity
//    }
    
}
