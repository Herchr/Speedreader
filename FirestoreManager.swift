//
//  FirebaseManager.swift
//  Speedreader
//
//  Created by Herman Christiansen on 11/02/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreManager: ObservableObject{
    let db = Firestore.firestore()
    var currentUser = Auth.auth().currentUser
    
    // MARK: - WPM TEST + QUESTIONNAIRE
    func setWPMBefore(wpmBefore: Double){
        if let currentUser = currentUser{
            let docRef = db.collection("UserData").document(currentUser.uid)
            docRef.setData(["WPMBefore": wpmBefore], merge: true){ error in
                guard error == nil else{
                    print("\(String(describing: error))")
                    return
                }
                print("WPMBefore successfully set")
            }
        }
        
        
    }
    
    func setWPMAfter(wpmAfter: Double){
        if let currentUser = currentUser{
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
        if let currentUser = currentUser{
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
        if let currentUser = currentUser{
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
