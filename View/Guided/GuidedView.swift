//
//  GuidedView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/10/2021.


import SwiftUI

struct GuidedView: View {
    @ObservedObject var kineticVM: KineticViewModel
    @StateObject var guidedVM: GuidedViewModel

    var body: some View {
        VStack {
            
            switch(guidedVM.currScreenIndex){
            case 0:
                GuidedStartScreen(guidedVM: guidedVM)
            case 1:
                ZStack{
                    Header(title:"Guided")
                    KineticTextView(kineticVM: kineticVM)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
                                kineticVM.toggleIsPlaying()
                            }
                        }
                }
            case 2:
                  Text("js")
//                RSVPTextView(textVM: textVM)
//                    .onAppear(perform: {
//                        textVM.toggleIsPlaying()
//                    })
//                    .onDisappear(perform: {
//                        textVM.toggleIsPlaying()
//                    })
            default:
                AnyView(Color.clear)
            }

        }
    }
}

struct GuidedView_Previews: PreviewProvider {
    static var previews: some View {
        GuidedView(kineticVM: KineticViewModel(text: Constants.dummyText.components(separatedBy: " ")), guidedVM: GuidedViewModel())
    }
}
