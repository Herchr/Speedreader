//
//  Persistence.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/08/2021.
//

import CoreData
import Firebase
import FirebaseStorage
import PDFKit

struct CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    private let entityName: String = "DownloadedBook"
    
    let storage = Storage.storage()
    
    
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
        
        let storageRef = storage.reference()
        let textRef = storageRef.child("texts/\(book.title).txt")
        textRef.getData(maxSize: 15728640){ (data, error) in
            if let error = error {
               print("error", error)
            }

            let text = String(data: data!, encoding: String.Encoding.utf8)
            entity.text = text
            save()
            
            if self.getActiveBook() == nil{
                self.setActiveBook(book: entity)
            }
        }
    }
    
    func uploadPDF(result: Result<URL, Error>){
        switch result {
        case .success(let url):
            if url.startAccessingSecurityScopedResource(){
                if let pdf = PDFDocument(url: url) {
                    let pageCount = pdf.pageCount
                    let documentContent = NSMutableAttributedString()

                    for i in 0 ..< pageCount {
                        guard let page = pdf.page(at: i) else { continue }
                        guard let pageContent = page.attributedString else { continue }
                        documentContent.append(pageContent)
                    }
                    let entity = DownloadedBook(context: container.viewContext)
                    entity.title = url.lastPathComponent //FileName
                    entity.id = UUID()
                    entity.currentIndex = 0
                    entity.about = ""
                    entity.author = ""
                    //entity.isActive = false
                    entity.img = UIImage(color: UIColor.random)?.pngData()
                    entity.text = documentContent.string
                    if self.getActiveBook() == nil{
                        self.setActiveBook(book: entity)
                    }
                    save()
                }else{
                    print("no pdf")
                }
            }
            
        case .failure(let error):
            print(error.localizedDescription)
        }
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
