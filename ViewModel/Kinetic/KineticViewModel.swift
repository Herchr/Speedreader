//
//  RSVPViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import Foundation
import SwiftUI
import CoreData


class KineticViewModel: ObservableObject {
    var coreDataManager: CoreDataManager = CoreDataManager.shared

    var text: [String] = [""]
    var currentIndex: Int = 0  // Set to users index of the current book
    @Published var activeBook: DownloadedBook?
    @Published var kineticText: [String] = [""]//Constants.dummyText.components(separatedBy: " ") //Set to empty array
    @Published var wpm: Double = 450
    @Published var isPlaying: Bool = false
    @Published var currLine: Int = -1
    @Published var lineWidth: CGFloat? = CGFloat(0)

    init(){
        setActiveBook()
        self.kineticText = fetchKineticText()
        let didSaveNotification = NSManagedObjectContext.didSaveObjectsNotification
        NotificationCenter.default.addObserver(self, selector: #selector(didSave(_:)), name: didSaveNotification, object: coreDataManager.container.viewContext)
    }
    
    var timer: Timer?
    let charsPerRow: Int = 42
    let rows: Int = 15

    var wordCount: Double = 0.0
    var currInterval: Double {
        ((wordCount / wpm) * 60) / Double(rows)
    }
    
    @objc func didSave(_ notification: Notification){
//        let updatedObjectsKey = NSManagedObjectContext.NotificationKey.updatedObjects.rawValue
//        print(notification.userInfo?[updatedObjectsKey])
        setActiveBook()
    }
    
    func setActiveBook(){
        if let activeBook = coreDataManager.getActiveBook(){
            self.activeBook = activeBook
            self.text = activeBook.text!.replacingOccurrences(of: "\n", with: " ").components(separatedBy: " ")
            self.currentIndex = Int(activeBook.currentIndex)
        }
    }

    func fetchKineticText() -> [String] {
        var newText: [String] = []
        var currWordCount: Int = 0
        var currRowText: String = ""
        
        for word in text[self.currentIndex..<text.count]{
            if newText.count > rows{
                break
            }
            if currRowText.count + word.count + 1 > charsPerRow{
                currWordCount += currRowText.components(separatedBy: " ").count
                newText.append(currRowText)
                currRowText = word + " "
                continue
            }
            currRowText.append(word + " ")
        }
        wordCount = Double(currWordCount)
        self.currentIndex += currWordCount
        return newText
    }

    func toggleIsPlaying(){
        if isPlaying {
            stopTimer()
        }else {
            startKineticTimer()
        }
    }

    @objc func startKineticTimer(){
        self.isPlaying = true
        timer = Timer.scheduledTimer(withTimeInterval: currInterval, repeats: true){ timer in
            if self.currLine < self.rows{
                DispatchQueue.main.async {
                    withAnimation(.linear(duration: self.currInterval)){
                        self.lineWidth = nil
                    }
                }
                self.currLine += 1
                self.lineWidth = CGFloat(0)
                
            }else {
                self.currLine = -1
                DispatchQueue.main.async {
                    self.kineticText = self.fetchKineticText()
                }
                //self.timer!.invalidate()
            }
        }
    }

    @objc func stopTimer(){
        self.isPlaying = false
        timer?.invalidate()
        timer = nil
    }

    
    
}
