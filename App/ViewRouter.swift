//
//  ViewRouter.swift
//  Speedreader
//
//  Created by Herman Christiansen on 06/10/2021.
//

import Foundation

class ViewRouter: ObservableObject{
    let tabImages: [String] = ["bolt", "map", "books.vertical", "person"]
    var counter: Int = 0
    @Published var tabMidPoints: [Double] = []
    @Published var selectedTab: String = "books.vertical"
    
    func setTabMidPoint(midPoint: Double) {
        if counter >= tabImages.count && tabMidPoints.count<4{
            tabMidPoints.append(midPoint)
            //print(counter, midPoint, tabMidPoints.count)
        }
        counter += 1
    }
    func getCurvePoint() -> Double{
        if tabMidPoints.isEmpty{
            return 76.5
        }
        else{
            switch selectedTab {
            case tabImages[0]:
                return tabMidPoints[3]
            case tabImages[1]:
                return tabMidPoints[2]
            case tabImages[2]:
                return tabMidPoints[1]
            default:
                return tabMidPoints[0]
            }
        }
    }
}
