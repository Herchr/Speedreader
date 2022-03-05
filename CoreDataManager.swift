//
//  Persistence.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/08/2021.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    private let entityName: String = "DownloadedBook"
    
    
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()

    

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Speedreader")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    
    func save(){
        do{
            try container.viewContext.save()
        }catch let error{
            print("Error saving to core data \(error)")
        }
    }
    
    func delete(entity: DownloadedBook){
        container.viewContext.delete(entity)
        save()
    }
    
    func itemExists(title: String) -> Bool {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.predicate = NSPredicate(format: "title == %@", title)
            let results = try! container.viewContext.fetch(fetchRequest)
            return results.count > 0
    }
    
    func getBooks() -> [DownloadedBook]{
        let req = NSFetchRequest<DownloadedBook>(entityName: entityName)
        do{
            return try container.viewContext.fetch(req)
        }catch let error{
            print("error fetching core data books \(error)")
            return []
        }
    }
    
    func getActiveBook() -> DownloadedBook?{
        let req = NSFetchRequest<DownloadedBook>(entityName: entityName)
        req.predicate = NSPredicate(format: "%K.isActive == %@", #keyPath(DownloadedBook.isActive), NSNumber(value: true))
        
        do{
            return try container.viewContext.fetch(req).first
        }catch let error{
            print("error fetching active core data book \(error)")
            return nil
        }
    }
    
    func setActiveBook(book: DownloadedBook){
        if let currentActiveBook = self.getActiveBook(){
            currentActiveBook.isActive = false
        }
        book.isActive = true
        save()
    }
    
    func downloadBook(book: Book){
        let entity = DownloadedBook(context: container.viewContext)
        entity.img = book.img?.pngData()
        entity.title = book.title
        entity.about = book.about
        entity.author = book.author
        //entity.text = book.text
        let cleanedBook = book.text.replacingOccurrences(of: "\n", with: " ")
        entity.text = cleanedBook  //ENDRE TILBAKE NÅR ENTITY.TEXT ER ENDRET TIL BINARY DATA
        entity.id = UUID()
        entity.currentIndex = 0
        entity.isActive = false
        save()
    }
    
//    func add(book: Book){
//        print(book.title, book.author, "downloadedBookVM")
//        let entity = DownloadedBook(context: container.viewContext)
//        
//        entity.img = book.img?.pngData()
//        entity.title = book.title
//        entity.about = book.about
//        entity.author = book.author
//        entity.text = book.text
//        entity.id = UUID()
//        entity.currentIndex = 0
//        entity.isActive = false
//        
//        save()
//        getBooks()
//    }
}
