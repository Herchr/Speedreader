//
//  NoImageModifier.swift
//  Speedreader
//
//  Created by Herman Christiansen on 11/01/2022.
//

import SwiftUI

struct NoImageModifier: ViewModifier {
    
    let imageName: String
    func body(content: Content) -> some View {
        Group{
            if imageName.count < 0{
                EmptyView()
            } else{
                content
            }
        }
    }
}

