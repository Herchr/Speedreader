//
//  SpeedreaderApp.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/08/2021.
//

import SwiftUI
import Firebase

@main
struct SpeedreaderApp: App {

    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ZStack{
                ContentView()
            }
            .preferredColorScheme(.light)
        }
    }
}
