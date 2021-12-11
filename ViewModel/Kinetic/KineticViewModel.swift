//
//  RSVPViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import Foundation
import SwiftUI


class KineticViewModel: ObservableObject {
    var text: [String]
    
    init(text: [String]){
        self.text = text
    }
    
    @Published var wpm: Double = 200
    @Published var currentIndex: Int = 0
    @Published var isPlaying: Bool = false
    @Published var showSpeedPopOver: Bool = false
    
    @Published var currLine: Int = 0
    var timer: Timer?
    let charsPerRow: Int = 42
    let rows: Int = 15
    
    var kineticText: [String] { fetchKineticText()}
    var widths: [Int: CGFloat] = [:]
    var wordCount: Double = 0.0
    var currInterval: Double {
        ((wordCount / wpm) * 60) / Double(rows)
    }
    
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
    
    func toggleIsPlaying(){
        if isPlaying {
            stopTimer()
        }else {
            startKineticTimer()
        }
        self.isPlaying = !self.isPlaying
        
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
    
    @objc func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    
    
}
