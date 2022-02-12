//
//  RSVPViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import Foundation
import SwiftUI
import CoreData


class RSVPViewModel: ObservableObject {
    var coreDataManager: CoreDataManager = CoreDataManager.shared
    
    @Published var text: [String] = [""]
    @Published var activeBook: DownloadedBook?
    init(){
        setActiveBook()
        
        let didSaveNotification = NSManagedObjectContext.didSaveObjectsNotification
        NotificationCenter.default.addObserver(self, selector: #selector(didSave(_:)), name: didSaveNotification, object: coreDataManager.container.viewContext)
    }
    
    @Published var wpm: Double = 200
    @Published var isPlaying: Bool = false
    @Published var showSpeedPopOver: Bool = false
    @Published var currentIndex: Int = 0
    
    var rsvpText: String { return text[self.currentIndex]}
    
    var timer: Timer?
    
    
    @objc func didSave(_ notification: Notification){
        //let updatedObjectsKey = NSManagedObjectContext.NotificationKey.updatedObjects.rawValue
        //print(notification.userInfo?[updatedObjectsKey])
        setActiveBook()
    }
    
    func setActiveBook(){
        if let activeBook = coreDataManager.getActiveBook(){
            self.activeBook = activeBook
            self.text = activeBook.text!.replacingOccurrences(of: "\n", with: " ").components(separatedBy: " ")
            self.currentIndex = Int(activeBook.currentIndex)

        }
    }
    @objc func stopTimer(){
        self.isPlaying = false
        timer?.invalidate()
        timer = nil
    }
    
    func toggleIsPlaying(){
        print("toggled isPlaying")
        if self.isPlaying {
            self.stopTimer()
        }else {
            self.startTimer()
        }
    }
    @objc func startTimer(){
        print("started rsvp timer")
        self.isPlaying = true
        timer = Timer.scheduledTimer(withTimeInterval: 60/wpm, repeats: true){ timer in
            //print(self.text.count, self.currentIndex)
            if self.currentIndex < self.text.count-1{
                //print(self.text[self.text.index(self.text.startIndex, offsetBy: self.currentIndex)].suffix(2))
                let lastCharofCurrString = self.text[self.text.index(self.text.startIndex, offsetBy: self.currentIndex)].suffix(1)
                if lastCharofCurrString == "." {
                    self.timer?.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (60/self.wpm)*2) {
                        self.startTimer()
                        self.currentIndex += 1
                    }
                }else{
                    self.currentIndex += 1
                }
                
            }else {
                self.currentIndex = 0
            }
        }
    }
    
    func fastForward(){
        if self.currentIndex + 30 < text.count{
            self.currentIndex += 30
        }
    }
    
    func rewind(){
        if self.currentIndex - 30 > 0{
            self.currentIndex -= 30
        }
    }
    
}
