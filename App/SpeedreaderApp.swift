//
//  SpeedreaderApp.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/08/2021.
//

import SwiftUI

@main
struct SpeedreaderApp: App {
    @StateObject var currentBookVM: CurrentBookViewModel = CurrentBookViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(currentBookVM)
        }
    }
}
