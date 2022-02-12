//
//  LottieView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 23/01/2022.
//

import SwiftUI
import UIKit
import Lottie

struct LottieView: UIViewRepresentable {
    
    var fileName: String
    var repeats: Bool = true
    
    func makeUIView(context: Context) -> UIView {
        let rootView = UIView(frame:.zero)
        
        let animationView = AnimationView()
        animationView.animation = Animation.named(fileName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = repeats ? .loop : .playOnce
        animationView.play()
        
        rootView.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: rootView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: rootView.heightAnchor)
        ])
        
        return rootView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //yo
    }
    
    typealias UIViewType = UIView
}
