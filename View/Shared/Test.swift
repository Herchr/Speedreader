//
//  AVCaption.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/10/2021.
//

import SwiftUI
import AVFoundation

struct Test: UIViewRepresentable {
    var textArr: [String] = Constants.dummyText.components(separatedBy: ",")
    var text: String = Constants.dummyText
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        let font = UIFont.systemFont(ofSize: 24)
        
        //let tc = NSTextContainer(size: CGSize(width: 40, height: 40))
        let attributes: [NSAttributedString.Key:Any] = [.font:font,.textEffect: NSAttributedString.TextEffectStyle.letterpressStyle]
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes(attributes, range: NSRange(text.startIndex..., in: text))
        view.attributedText = attributedText
        
//        let range = (view.text as NSString).range(of: text)
//        let glyphRange = view.layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
//
//        let container = view.layoutManager.textContainer(forGlyphAt: glyphRange.location, effectiveRange: nil)
        //let lineRext = container?.textLayoutManager?.usageBoundsForTextContainer
        
        //view.addSubview(lineRext)
        
        
        func addLineFragmentBorder(of text: String) {

                let range = (view.text as NSString).range(of: text)

                let glyphRange = view.layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)

                // You can try the difference by changing `lineFragmentUsedRect` to `lineFragmentRect`.
                let lineRect = view.layoutManager.lineFragmentUsedRect(forGlyphAt: glyphRange.location, effectiveRange: nil)



                let borderLayer = CALayer()

                borderLayer.frame = .init(x: lineRect.minX, y: lineRect.minY + view.textContainerInset.top, width: lineRect.width, height: lineRect.height)

                borderLayer.borderColor = UIColor.red.cgColor

                borderLayer.borderWidth = 2

                borderLayer.backgroundColor = UIColor.clear.cgColor



                view.layer.addSublayer(borderLayer)

            }
        addLineFragmentBorder(of: text)
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    
}

struct AVCaptionTest_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
