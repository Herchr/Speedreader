//
//  BlurView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 30/03/2022.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        //
    }
}

