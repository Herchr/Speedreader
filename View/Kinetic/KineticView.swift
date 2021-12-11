//
//  KineticView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 04/10/2021.
//

import SwiftUI

struct KineticView: View {
    @ObservedObject var kineticVM: KineticViewModel
    @State var widths: [Int: CGFloat] = [:]

    
    var body: some View {
        VStack{
            KineticTextView(kineticVM: kineticVM)
            
        }
    }
}

struct KineticView_Previews: PreviewProvider {
    static var previews: some View {
        KineticView(kineticVM: KineticViewModel(text: Constants.dummyText.components(separatedBy: " ")))
    }
}
