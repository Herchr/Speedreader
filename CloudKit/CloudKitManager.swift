//
//  CloudKitManager.swift
//  Speedreader
//
//  Created by Herman Christiansen on 20/01/2022.
//

import Foundation
import CloudKit

class CloudKitManager: ObservableObject{
    var container: CKContainer = CKContainer(identifier: "iCloud.com.hc.Book")
    
    @Published var isNotSignedInToiCloud: Bool = false
    @Published var firstTimeUsingApp: Int?
    @Published var userID: CKRecord.ID?
    
    init(){
        getiCloudStatus()
        getFirstTimeUsingApp()
    }
    
    private func getUserRecord() -> CKRecord?{
        var userRecord: CKRecord?
        self.container.fetchUserRecordID{ recordID, error in
            guard let recordID = recordID, error == nil else{
                print("\(String(describing: error))")
                return
            }
            self.container.publicCloudDatabase.fetch(withRecordID: recordID){ record, error in
                userRecord = record
            }
        }
        return userRecord
    }
    
    private func saveItem(record: CKRecord){
        self.container.publicCloudDatabase.save(record){ returnedRecord, returnedError in
            print("\(String(describing: returnedError))")
        }
    }
    
    private func getiCloudStatus(){
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            
            if returnedStatus == .available{
                DispatchQueue.main.async {
                    self?.isNotSignedInToiCloud = false
                }
            }else{
                DispatchQueue.main.async {
                    self?.isNotSignedInToiCloud = true
                }
                print(returnedError ?? "error in cloudkitmanager file. niiiiihao")
            }
        }
    }
    
    private func getFirstTimeUsingApp(){
        self.container.fetchUserRecordID{ recordID, error in
            guard let recordID = recordID, error == nil else{
                print("\(String(describing: error))")
                return
            }
            self.container.publicCloudDatabase.fetch(withRecordID: recordID){ record, error in
                //print("Record: \(String(describing: record?.object(forKey: "firstTimeUsingApp")))")
                DispatchQueue.main.async {
                    if record?.object(forKey: "firstTimeUsingApp") == nil{
                        self.firstTimeUsingApp = 1
                    }else{
                        self.firstTimeUsingApp = 0
                    }
                }

            }
        }
    }
    
    func setComprehensionScore(comprehensionScore: Double){
        
        self.container.fetchUserRecordID{ recordID, error in
            guard let recordID = recordID, error == nil else{
                print("\(String(describing: error))")
                return
            }
            let publicDB = self.container.publicCloudDatabase
            publicDB.fetch(withRecordID: recordID){ record, error in
                DispatchQueue.main.async {
                    record?["comprehensionScore"] = (record?["comprehensionScore"] ?? []) + [comprehensionScore]

                }
                
                if let record = record{
                    publicDB.save(record){ returnedRecord, returnedError in
                        print("\(String(describing: returnedError)), halla")
                        
                    }
                }
            }
        }
    }
    
}
