//
//  Delay.swift
//  Speedreader
//
//  Created by Herman Christiansen on 02/02/2022.
//

import Foundation

func delay( seconds: Double, content: @escaping () -> Void){
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds){
        content()
    }
}
