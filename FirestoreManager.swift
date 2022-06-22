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
    
    // MARK: - USER ORDER / LATIN SQUARE
    func setCreationTimestampAndGroup(){
        if let currentUser = Auth.auth().currentUser{
            let userTimestamp = Date.timeIntervalSinceReferenceDate
            let docRef = db.collection("UserData").document(currentUser.uid)
            docRef.setData(["creationTimestamp": userTimestamp], merge: true){ error in
                guard error == nil else{
                    print("error creationTimestamp \(String(describing: error))")
                    return
                }
                print("Creation timestamp successfully set")
            }
            
            db.collection("UserData").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var userNum: Int = 0
                    for document in querySnapshot!.documents {
                        if document["creationTimestamp"] as? Double != nil{
                            if document.documentID != currentUser.uid{
                                userNum += 1
                            }
                        }
                    }
                    let groups = [["A", "K"], ["A", "R"], ["B", "K"], ["B", "R"]]
                    let textGroup = groups[userNum % 4][0]
                    let techniqueGroup = groups[userNum % 4][1]
                    docRef.setData(["textGroup": textGroup, "techniqueGroup": techniqueGroup], merge: true){ error in
                        guard error == nil else{
                            print("error creating A/B groups \(String(describing: error))")
                            return
                        }
                        print("Creation of A/B groups successfully set")
                    }
                    
                }
            }
        }
    }
    func getTechniqueGroup() async -> String?{
        if let currentUser = Auth.auth().currentUser{
            do{
                let doc = try await db.collection("UserData").document(currentUser.uid).getDocument().data()
                guard let userData = doc else{
                    print("error fetching techgroup")
                    return nil
                }
                return userData["techniqueGroup"] as? String
            }catch{
                print("error error fetching techgroup")
            }
        }
        return nil
    }
    func getTextGroup() async -> String?{
        if let currentUser = Auth.auth().currentUser{
            do{
                let doc = try await db.collection("UserData").document(currentUser.uid).getDocument().data()
                guard let userData = doc else{
                    print("error fetching textgroup")
                    return nil
                }
                return userData["textGroup"] as? String
            }catch{
                print("error error fetching textgroup")
            }
        }
        return nil
    }
    
    // MARK: - WPM TEST + QUESTIONNAIRE
    func setWPMBefore(wpmBefore: Double){
        if let currentUser = Auth.auth().currentUser{
            let docRef = db.collection("UserData").document(currentUser.uid)
            docRef.setData(["WPMBefore": wpmBefore > 400 ? 400 : wpmBefore, "WPMBeforeExceeding400": wpmBefore > 400 ? wpmBefore : 0, "Email": currentUser.email ?? ""], merge: true){ error in
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
                print("technique successfully set")
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
