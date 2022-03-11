//
//  AppViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 30/01/2022.
//

import Foundation
import FirebaseAuth

enum ActiveFullScreenCover: Identifiable{
    case Auth;
    case WPMText;
    case Questionnaire;
    
    var id: Int{
        hashValue
    }
}

class AppViewModel: ObservableObject{
    @Published var showTabBar: Bool = true
    @Published var activeFullScreenCover: ActiveFullScreenCover?
    
    init(){
        if Auth.auth().currentUser == nil{
            self.activeFullScreenCover = ActiveFullScreenCover.Auth
        }
    }
}
