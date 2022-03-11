//
//  Padding.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/10/2021.
//

import SwiftUI

extension View{
    func tabBarPadding(started: Bool = false) -> some View{
        if started{
            return padding(.bottom, CGFloat(0))
        }
        return padding(.bottom, CGFloat(screen.height*0.16))
    }
    func headerPadding() -> some View{
        return padding(.top, CGFloat(120))
    }
}

struct Padding{
    public static var buttonHorizonalPadding: CGFloat{
        return CGFloat(50)
    }
    public static var buttonVerticalPadding: CGFloat{
        return CGFloat(12)
    }
}
