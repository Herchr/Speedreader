//
//  RSVPViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import Foundation
import CoreData
import SwiftUI


class KineticViewModel: ObservableObject {
    var coreDataManager: CoreDataManager = CoreDataManager.shared

    @Published var text: [String] = [String]()
    var currentIndex: Int = 0  // Set to users index of the current book
    @Published var activeBook: DownloadedBook?
    @Published var kineticText: [[String]]? //= [[""]] //Constants.dummyText.components(separatedBy: " ") //Set to empty array
    @Published var wpm: Double = 300
    @Published var isPlaying: Bool = false
    //@Published var showKinetic: Bool = true
    
    @Published var currentLine: Int = 0
    @Published var lineWidths: [Int: Double] = [:]
    @Published var pointerOffset: Double = 0
    @Published var pointerScale: Double = 1
    @Published var finishingLineOpacity: Double = 1
    //@Published var animationDuration: Double = 0
    var wordsInCurrentKineticText: Double = 0
    var sumOfLineWidths: Double = 0
//    @Published var currentWordIndex: Int = 0

    init(){
        self.setActiveBook()
        let didSaveNotification = NSManagedObjectContext.didSaveObjectsNotification
        NotificationCenter.default.addObserver(self, selector: #selector(didSave(_:)), name: didSaveNotification, object: coreDataManager.container.viewContext)
        self.fetchKineticText()
       // print("tittel \(activeBook?.title)")
    }
    
    var timer: Timer?
    let charsPerRow: Int = 36
    let rows: Int = Int(screen.height / 35)

    var wordCount: Int = 1
    var currentInterval: Double {
        60/wpm
    }
//    var currentInterval: Double {
//        ((wordCount / wpm) * 60) / Double(rows)
//    }

    @objc func didSave(_ notification: Notification){
//        let updatedObjectsKey = NSManagedObjectContext.NotificationKey.updatedObjects.rawValue
//        print(notification.userInfo?[updatedObjectsKey])
        setActiveBook()
        self.currentIndex = 0
        self.currentLine = 0
    }
    
    func setActiveBook(){
        if let activeBook = coreDataManager.getActiveBook(){
            self.activeBook = activeBook
            self.text = activeBook.text!.components(separatedBy: " ")
            self.fetchKineticText()
           // self.currentIndex = Int(activeBook.currentIndex)
        }
    }

    // FETCHING 1 WORD
    
    func fetchKineticText() -> Void{//[[String]] {
        print("fetching")
        var newText: [[String]] = [[String]]()
        var currentRowText: [String] = [String]()
        var currentRowWordCount: Int = 0
        var currentTextWordCount: Int = 0
        if self.text.count > self.currentIndex + rows * charsPerRow{ // Change so that it gets the last part of the book as well
            print("currentindex \(self.currentIndex)")
            let endIndex = self.currentIndex + rows * charsPerRow
            for word in text[self.currentIndex..<endIndex]{

                if newText.count > rows{
                    break
                }
                currentTextWordCount += 1
                if currentRowWordCount + word.count + 1 > charsPerRow{
    //                print("\(currentRowText)")
                    newText.append(currentRowText)
                    currentRowText = [word]
                    currentRowWordCount = word.count
                    continue
                }
                currentRowWordCount += word.count
                currentRowText.append(word)
            }
        }
        self.wordCount = currentTextWordCount
//        if currentTextWordCount > 1{
//            self.currentIndex += currentTextWordCount - 1
//        }
        self.wordsInCurrentKineticText = Double(newText.flatMap{ $0 }.count)
        
       // self.charsInCurrentKineticText = Double(newText.flatMap{ $0 }.joined(separator: " ").count)
        self.kineticText = newText
        self.sumOfLineWidths = self.lineWidths.values.reduce(0, +)
    }
    


    func toggleIsPlaying(){
        if isPlaying {
//            self.currentLine = 0
//            self.pointerOffset = 0
            self.isPlaying = false
        }else {
            self.isPlaying = true
            self.sumOfLineWidths = self.lineWidths.values.reduce(0, +)
            animateLine()
        }
    }


   
    func animateLine(){
        if !self.isPlaying{
            return
        }
        
        //let charsInCurrentLine = Double((self.kineticText?[self.currentLine].flatMap{ $0 }.count)!)
        let totalTimeForCurrentText = (self.wordsInCurrentKineticText / self.wpm) * 60 //- (0.05*Double(self.rows)) // times 60 to get seconds. Subract 0.2 per row to account for end animation of each line
        let animationDuration =  ((self.lineWidths[self.currentLine] ?? 100) / self.sumOfLineWidths) * totalTimeForCurrentText
        
        
        withAnimation(.linear(duration: animationDuration)){
            self.pointerOffset = (self.lineWidths[self.currentLine] ?? 60) - 60
        }
        
        withAnimation(.linear(duration: animationDuration/6).delay(animationDuration - animationDuration/6)){
            self.finishingLineOpacity = 0
            self.pointerScale = 0
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration){
            
            self.finishingLineOpacity = 1
            self.pointerScale = 1
            //self.pointerWidth = 60
            if self.currentLine < self.rows{
                self.currentLine += 1
                self.pointerOffset = 0
                self.animateLine()
                
            }else{
                
                self.currentIndex += self.wordCount - 1
                self.currentLine = 0
                self.pointerOffset = 0
                self.fetchKineticText()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    self.animateLine()
                }
            }
        }
    }
    
    
    
    
//    var animationStart = Date()
////    var totalTimeForCurrentText: Double {
////        (self.wordsInCurrentKineticText / self.wpm) * 60 // times 60 to get seconds
////    }
//    var displayLink: CADisplayLink?
//
//    func start(){
//        self.sumOfLineWidths = self.lineWidths.values.reduce(0, +)
//        displayLink = CADisplayLink(target: self, selector: #selector(animate))
//        displayLink?.add(to: .main, forMode: .common)
//    }
//
//    func stop(){
//        displayLink?.invalidate()
//    }
//
//    @objc func animate(displayLink: CADisplayLink){
////        if !self.isPlaying{
////            return
////        }
//
//        let totalTimeForCurrentText = (self.wordsInCurrentKineticText / self.wpm) * 60 // times 60 to get seconds
//        let animationDuration =  ((self.lineWidths[self.currentLine] ?? 100) / self.sumOfLineWidths) * totalTimeForCurrentText
//        let elapsedTime = Date().timeIntervalSince(self.animationStart)
//
//        withAnimation(.linear(duration: animationDuration)){
//            self.pointerOffset = (self.lineWidths[self.currentLine] ?? 60) - 60
//        }
//
//        withAnimation(.linear(duration: animationDuration / 6.0).delay(animationDuration-0.1)){
//            self.finishingLineOpacity = 0
//
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration + 0.1){
//
//            self.finishingLineOpacity = 1
//
//            if self.currentLine < self.rows{
//
//                self.currentLine += 1
//                self.pointerOffset = 0
//                self.animateLine()
//            }else{
//                self.fetchKineticText()
//                self.currentLine = 0
//                self.pointerOffset = 0
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    self.animateLine()
//                }
//            }
//        }
//    }

    
    
    
    
    
    
    
    
    //PREVIOUS METHOD
//    @objc func startKineticTimer(){
//        //self.isPlaying = true
//        if self.isPlaying == false{
//            return
//        }
//        if let kineticText = self.kineticText {
////                print("\(kineticText)")
////                print(self.currentLineIndex)
//            let wordsInCurrentRow = kineticText[self.currentLineIndex].count
//
//            var charsInCurrentRow = 0
//            var charsInCurrentWord = 0
//            var totalTimeForCurrentRow = 0.0
//            var timeFractionForCurrentWord = 0.0
//            var animationDurationCurrentWord = 0.0
//
//            if self.currentWordIndex < wordsInCurrentRow && self.currentLineIndex < rows{
//                charsInCurrentRow = kineticText[self.currentLineIndex].reduce(0){ $0 + $1.count}
//                charsInCurrentWord = kineticText[self.currentLineIndex][self.currentWordIndex].count
//                totalTimeForCurrentRow = self.currentInterval * Double(wordsInCurrentRow) * 2 // REMOVE * 2 IF THERE IS ONLY 1 WORD PER ARRAY
//                timeFractionForCurrentWord = Double(charsInCurrentWord)/Double(charsInCurrentRow)
//                animationDurationCurrentWord = timeFractionForCurrentWord * totalTimeForCurrentRow
//
//            }else if (self.currentWordIndex >= wordsInCurrentRow && self.currentLineIndex < rows){
//                charsInCurrentRow = kineticText[self.currentLineIndex+1].reduce(0){ $0 + $1.count}
//                charsInCurrentWord = kineticText[self.currentLineIndex+1][0].count
//                totalTimeForCurrentRow = self.currentInterval * Double(wordsInCurrentRow)
//                timeFractionForCurrentWord = Double(charsInCurrentWord)/Double(charsInCurrentRow)
//                animationDurationCurrentWord = timeFractionForCurrentWord * totalTimeForCurrentRow
//
//            }
//
//            if self.currentWordIndex < wordsInCurrentRow{
//
//                print(charsInCurrentWord)
//                print(animationDurationCurrentWord)
//
//
//                withAnimation(.linear(duration: animationDurationCurrentWord)){
//                    self.currentWordIndex += 1
//                }
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + animationDurationCurrentWord){
//                    self.startKineticTimer()
//                }
//
//                }else{
//                    if self.currentLineIndex < self.rows{
//                        self.currentLineIndex += 1
//                        self.currentWordIndex = 0
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
//                            self.startKineticTimer()
//                        }
//
//                    }else{
//                        self.currentWordIndex = 0
//                        self.currentLineIndex = 0
//                        self.fetchKineticText()
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + animationDurationCurrentWord){
//                            self.startKineticTimer()
//                        }
//                    }
//                }
//        }
//
//    }
    
    
    
    //    //FETCHING 2 WORDS
    //    func fetchKineticText() -> Void{//[[String]] {
    //        var newText: [[String]] = [[]]
    //        var currentRowText: [String] = []
    //        var currentRowWordCount: Int = 0
    //        var currentTextWordCount: Double = 0
    //
    //        for i in stride(from: self.currentIndex, to: self.currentIndex + rows * charsPerRow, by: 2){
    //
    //            if newText.count > rows{
    //                break
    //            }
    //            currentTextWordCount += 1
    //
    //            if currentRowWordCount + text[i].count + text[i+1].count > charsPerRow{
    ////                print("\(currentRowText)")
    //                newText.append(currentRowText)
    //                currentRowText = [text[i] + " " + text[i+1]]
    //                currentRowWordCount = text[i].count + text[i+1].count
    //                continue
    //            }
    //            currentRowWordCount += text[i].count + text[i+1].count
    //            currentRowText.append(text[i] + " " + text[i+1])
    //        }
    //        var bookIndex = 0
    //        for s in newText{
    //            for w in s{
    //                bookIndex += w.count
    //            }
    //        }
    //        self.wordCount = currentTextWordCount
    //        self.currentIndex += bookIndex
    //        self.kineticText = newText
    //    }
}
