//
//  FirebaseManager.swift
//  Speedreader
//
//  Created by Herman Christiansen on 11/02/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

enum DatabaseError: Error {
    case failed
}

class FirestoreManager: ObservableObject{
    let db = Firestore.firestore()
    
    @Published var wpm: Double = 0
    
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
    
    func getBooks(){
        db.collection("Books").getDocuments{ (querySnapshot, error) in
            guard error == nil else{
                print("error fetching from firestore: ", error ?? "")
                return
            }
            var documents: [QueryDocumentSnapshot] = []
            for doc in querySnapshot!.documents{
                documents.append(doc)
            }
            print(documents)
        }
    }
}
