//
//  KineticTestViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 16/02/2022.
//

import Foundation
import SwiftUI

class KinecticTestViewModel: ObservableObject{
    @Published var kineticText: [[String]] = ["Obsessed with the idea of".components(separatedBy: " "), "creating life itself, Victor Frankenstein".components(separatedBy: " "),"Obsessed with the idea of".components(separatedBy: " "),"Obsessed with the idea of".components(separatedBy: " "),"Obsessed with the idea of".components(separatedBy: " "),"Obsessed with the idea of".components(separatedBy: " "),"Obsessed with the idea of".components(separatedBy: " ")]
    @Published var currentLineIndex: Int = 0
    @Published var currentWordIndex: Int = 0
    
    func kjor(){
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
           // DispatchQueue.global(qos: .userInteractive).async {
            if self.currentWordIndex < 5{
                    withAnimation{
                        self.currentWordIndex += 1
                    }
                }else{
                    
                    if self.currentLineIndex < 6{
                        
                        withAnimation{
                            self.currentLineIndex += 1
                        }
                        self.currentWordIndex = 0
                        
                        
                    }else{
                        self.currentWordIndex = 0
                        self.currentLineIndex = 0
                    }
                }
            //}
        }
    }
}
