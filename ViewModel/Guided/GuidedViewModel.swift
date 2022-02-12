//
//  GuidedViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/10/2021.
//

import Foundation
import SwiftUI

enum SessionType{
    case RSVP
    case KINETIC
}

class GuidedViewModel: ObservableObject{
    var sessionType: SessionType = SessionType.KINETIC
    
    @Published var showContinuePopUp: Bool = false
    @Published var showCompleteScreen: Bool = false
    @Published var started: Bool = false
    @Published var currentRound = 0
    
    var initialSpeed: Double = 200.0
    var totalRounds: Int = 3
    
    var timeInterval: Double = 5.0
    var popUpPause: Double = 0.5
    
    let increase: [String] = ["33", "66", "100"]
    
    func getWpmIncrease(currentRound: Int) -> String{
        if currentRound >= 0 && currentRound < self.totalRounds{
            return increase[currentRound]
        }
        return ""
    }
    func start(){
        started = true
        DispatchQueue.main.asyncAfter(deadline: .now() + self.timeInterval){
            self.showContinuePopUp = true
        }
    }
    
    func end(){
        self.currentRound = 0 // Reset session
        delay(seconds: 1){
            withAnimation{
                self.started = false
                self.showCompleteScreen = true
            }
        }
        // Remove completed screen after a few seconds
        delay(seconds: 4){
            withAnimation{
                self.showCompleteScreen = false
            }
        }
    }
    
    func endPrematurely(){
        self.currentRound = 0 // Reset session
        self.showContinuePopUp = false
        withAnimation{
            self.started = false
        }
    }
}
