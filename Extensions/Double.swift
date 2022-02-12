//
//  Double.swift
//  Speedreader
//
//  Created by Herman Christiansen on 20/01/2022.
//

import Foundation

extension Double {
    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
