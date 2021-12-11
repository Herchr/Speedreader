//
//  RSVPViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import Foundation
import SwiftUI


class RSVPViewModel: ObservableObject {
    var text: [String]
    
    init(text: [String]){
        self.text = text
    }
    
    @Published var wpm: Double = 200
    @Published var isPlaying: Bool = false
    @Published var showSpeedPopOver: Bool = false
    @Published var currentIndex: Int = 0
    
    var rsvpText: String { return text[self.currentIndex]}
    
    
    var timer: Timer?
    
    @objc func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    
    func toggleIsPlaying(){
        print("toggled isPlaying")
        if isPlaying {
            stopTimer()
        }else {
            startTimer()
        }
        self.isPlaying = !self.isPlaying
        
    }
    @objc func startTimer(){
        print("started rsvp timer")
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
    
}
