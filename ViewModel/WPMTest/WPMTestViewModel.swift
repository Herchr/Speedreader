//
//  WPMTestViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 19/01/2022.
//

import Foundation
import SwiftUI
import CloudKit

class WPMTestViewModel: ObservableObject {
    @Published var startReading: Bool = false
    @Published var wpm: Int = 0
    var secondsElapsed: Int = 0
    var timer: Timer?
    
    
    @objc func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            self.secondsElapsed += 1
        }
    }
    
    @objc func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func calculateWPM() -> Int{
        let totalWords = Constants.wpmTestText.components(separatedBy: .whitespacesAndNewlines).count
        let minutesElapsed: Double = Double(secondsElapsed) / 60.0
        self.wpm = (Double(totalWords) / minutesElapsed).toInt() ?? 0
        return self.wpm
    }
    
    func uploadWPM(){
        let container = CKContainer(identifier: "iCloud.com.hc.Book")
        let publicDB = container.publicCloudDatabase
        
        container.fetchUserRecordID{ recordID, error in
            guard let recordID = recordID, error == nil else{
                print("\(String(describing: error))")
                return
            }
            
            publicDB.fetch(withRecordID: recordID){ record, error in
                DispatchQueue.main.async {
                    record?["wpm"] = self.wpm
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
