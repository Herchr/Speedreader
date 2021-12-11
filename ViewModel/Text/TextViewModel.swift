//
//  RSVPViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import Foundation
import SwiftUI



class TextViewModel: ObservableObject {
    // MARK: - COMMON
    
 //   var text: [String] = "Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear. Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear".components(separatedBy: " ")
    var text: [String]
    
    init(text: [String]){
        self.text = text
    }
    
    //var text: [String] = Array(CurrentBookViewModel().currentBook!.about!.components(separatedBy: " "))
    
    
    @Published var wpm: Double = 200
    @Published var currentIndex: Int = 0
    @Published var isPlaying: Bool = false
    @Published var showSpeedPopOver: Bool = false
    
    var timer: Timer?
    
    @objc func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - RSVP
    var rsvpText: String { return text[self.currentIndex]}
    
    func toggleIsPlaying(type: String = "RSVP"){
        print("toggled")
        if isPlaying {
            stopTimer()
        }else {
            type == "Kinetic" ? startKineticTimer() : startTimer()
        }
        self.isPlaying = !self.isPlaying
        
    }
    @objc func startTimer(){
        print("started")
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
    
    // MARK: - KINETIC
    let charsPerRow: Int = 42
    let rows: Int = 15
    
    var kineticText: [String] { fetchKineticText()}
    var widths: [Int: CGFloat] = [:]
    var wordCount: Double = 0.0
    var currInterval: Double {
        ((wordCount / wpm) * 60) / Double(rows)
    }
    @Published var currLine: Int = 0
    
    func fetchKineticText() -> [String] {
        var newText: [String] = []
        var currWordCount: Int = 0
        var currRow: String = ""
        for s in text{
            if newText.count == rows{
                break
            }
            if currRow.count + s.count + 1 > charsPerRow{
                currWordCount += currRow.components(separatedBy: " ").count
                newText.append(currRow)
                currRow = s + " "
                continue
            }
            currRow.append(s + " ")
        }
        wordCount = Double(currWordCount)
        return newText
    }
    
    @objc func startKineticTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: currInterval, repeats: true){ timer in
            if self.currLine < self.rows{
                self.currLine += 1
            }else {
                self.timer!.invalidate()
            }
        }
    }
    
    // MARK: - GUIDED
    
    func startGuided(type: String, wpmIncrease: Double){
        wpm += wpmIncrease
        toggleIsPlaying(type: type)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10){
            self.toggleIsPlaying(type: type)
        }
    }
    
}
