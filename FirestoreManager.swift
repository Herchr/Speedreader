//
//  FirebaseManager.swift
//  Speedreader
//
//  Created by Herman Christiansen on 11/02/2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

enum DatabaseError: Error {
    case failed
}

class FirestoreManager: ObservableObject{
    let db = Firestore.firestore()
    let storage = Storage.storage()
    @Published var currentText: String = ""
    
    // MARK: - WPM TEST + QUESTIONNAIRE
    func setWPMBefore(wpmBefore: Double){
        if let currentUser = Auth.auth().currentUser{
            let docRef = db.collection("UserData").document(currentUser.uid)
            docRef.setData(["WPMBefore": wpmBefore > 400 ? 400 : wpmBefore], merge: true){ error in
                guard error == nil else{
                    print("error wpmbefore \(String(describing: error))")
                    return
                }
                print("WPMBefore successfully set")
            }
        }
    }
    
    func getWPMBefore() async -> Double?{
        if let currentUser = Auth.auth().currentUser{
            do{
                let doc = try await db.collection("UserData").document(currentUser.uid).getDocument().data()
                guard let userData = doc else{
                    print("error fetching wpmbefore")
                    return nil
                }
                return userData["WPMBefore"] as? Double
            }catch{
                print("error error fetching wpmbefore")
            }
        }
        return nil
    }
    
    func setWPMAfter(wpmAfter: Double){
        if let currentUser = Auth.auth().currentUser{
            let docRef = db.collection("UserData").document(currentUser.uid)
            docRef.setData(["WPMAfter": wpmAfter], merge: true){ error in
                guard error == nil else{
                    print("\(String(describing: error))")
                    return
                }
                print("WPMAfter successfully set")
            }
        }
    }

    func setComprehensionBefore(comprehensionBefore: Double){
        if let currentUser = Auth.auth().currentUser{
            let docRef = db.collection("UserData").document(currentUser.uid)
            docRef.setData(["ComprehensionBefore": comprehensionBefore], merge: true){ error in
                guard error == nil else{
                    print("\(String(describing: error))")
                    return
                }
                print("ComprehensionBefore successfully set")
            }
        }
    }
    
    func setComprehensionAfter(comprehensionAfter: Double){
        if let currentUser = Auth.auth().currentUser{
            let docRef = db.collection("UserData").document(currentUser.uid)
            docRef.setData(["ComprehensionAfter": comprehensionAfter], merge: true){ error in
                guard error == nil else{
                    print("\(String(describing: error))")
                    return
                }
                print("ComprehensionAfter successfully set")
            }
        }
    }
    
    func setTechnique(technique: String){
        if let currentUser = Auth.auth().currentUser{
            let docRef = db.collection("UserData").document(currentUser.uid)
            docRef.setData(["Technique": technique], merge: true){ error in
                guard error == nil else{
                    print("\(String(describing: error))")
                    return
                }
                print("ComprehensionAfter successfully set")
            }
        }
    }
    
    // MARK: - LIBRARY BOOKS
    
//    func getBooks() -> [Book]{
//        var books: [Book] = [Book]()
//        db.collection("Books").getDocuments{ (querySnapshot, error) in
//            guard error == nil else{
//                print("error fetching from firestore: ", error ?? "")
//                return
//            }
//            //var documents: [QueryDocumentSnapshot] = []
//            
//            for doc in querySnapshot!.documents{
//                let data = doc.data()
//                let id = data["id"] as? String ?? ""
//                let title = data["title"] as? String ?? ""
//                let author = data["author"] as? String ?? ""
//                var img: UIImage?
//                if let image = UIImage(named: title){
//                    img = image
//                }
//                let imgUrl = data["imgUrl"] as? String ?? ""
//                let about = data["about"] as? String ?? ""
//                var categories: [Category] = []
//                if let cats = data["categories"] as? [String]{
//                    for cat in cats{
//                        categories.append(Category(title: cat))
//                    }
//                }
//                
//                let book = Book(id: id, title: title, author: author, img: img, imgUrl: imgUrl, about: about, categories: categories)
//                books.append(book)
//                //documents.append(doc)
//            }
//           // print(documents[0]["title"] as? String ?? "g")
//        }
//        return books
//    }
    
//    func getText(title: String){
//        let storageRef = storage.reference()
//        let textRef = storageRef.child("texts/Frankenstein; Or, The Modern Prometheus.txt")
//        let handler: (Data?, Error?) -> Void = { (data, error) in
//            if let error = error {
//               print("error", error)
//            }
//
//            let text = String(data: data!, encoding: String.Encoding.utf8)
//            self.currentText = text!
//        }
//
//        textRef.getData(maxSize: 15728640, completion: handler)
//    }
}
