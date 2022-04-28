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
    @Published var wpm: Double = 500
    @Published var isPlaying: Bool = false
    @Published var showSpeedPopOver: Bool = false
    @Published var currentIndex: Int = 0
    @Published var punctuationPause: Bool = true
    
    var textCount: Int{
        text.count
    }
    init(){
        setActiveBook()
        let didSaveNotification = NSManagedObjectContext.didSaveObjectsNotification
        NotificationCenter.default.addObserver(self, selector: #selector(didSave(_:)), name: didSaveNotification, object: coreDataManager.container.viewContext)
    }
    
    var rsvpText: String { return text[self.currentIndex]}
    
    var timer: Timer?
    
    var displayLink: CADisplayLink?
    
    
    @objc func didSave(_ notification: Notification){
        //let updatedObjectsKey = NSManagedObjectContext.NotificationKey.updatedObjects.rawValue
        //print(notification.userInfo?[updatedObjectsKey])
        setActiveBook()
    }
    
    func setActiveBook(){
        if let activeBook = coreDataManager.getActiveBook(){
            self.activeBook = activeBook
            self.text = activeBook.text!.components(separatedBy: " ")
            self.currentIndex = Int(activeBook.currentIndex)

        }
    }
    @objc func stopTimer() {
        self.isPlaying = false
        timer?.invalidate()
        //timer = nil
    }
    
    @objc func startTimer() {
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
    
    var animationStart = Date()
    
    func start(){
        self.isPlaying = true
        displayLink = CADisplayLink(target: self, selector: #selector(animateWords))
        displayLink?.add(to: .main, forMode: .common)
    }
    func stop(){
        self.isPlaying = false
        displayLink?.invalidate()
    }
    @objc func animateWords(displayLink: CADisplayLink) {
        var duration = 60/self.wpm
        let elapsedTime = Date().timeIntervalSince(animationStart)
        if self.currentIndex < self.textCount{
            //print(self.text[self.text.index(self.text.startIndex, offsetBy: self.currentIndex)].suffix(2))
            if punctuationPause{
                let lastCharofCurrString = self.text[self.text.index(self.text.startIndex, offsetBy: self.currentIndex)].suffix(1)
                if lastCharofCurrString == "." {
                    duration *= 2
                }
            }
        }else {
            self.currentIndex = 0
        }
        if elapsedTime > duration{
            self.currentIndex += 1
            self.animationStart = Date()
        }
        
    }
    
    func getPercentageProgress() -> Double{
        return Double(self.currentIndex) / Double(self.textCount)
    }
    
    func getTimeRemaining() -> Int{
        return (self.textCount - self.currentIndex)/Int(self.wpm)
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



