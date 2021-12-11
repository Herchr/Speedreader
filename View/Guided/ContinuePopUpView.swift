//
//  ContinuePopUpView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/10/2021.
//
//
//import SwiftUI
//
//struct ContinuePopUpView: View {
//    @ObservedObject var guidedVM: GuidedViewModel
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            Color.black.opacity(0.7)
//            VStack {
//                HStack {
//                    Spacer()
//                    Image("IncreaseSpeedIcon")
//                        .resizable()
//                        .frame(width: 60*1.41, height: 60)
//                        .padding()
//                    Text("+100 wpm")
//                        .font(.title)
//                        .foregroundColor(Color.green)
//                        .fontWeight(.black)
//                    Spacer()
//                }
//                Button(action: {
//                    guidedVM.currScreenIndex += 1
//                }, label: {
//                    Text("Continue")
//                        .font(.title)
//                        .fontWeight(.medium)
//                        .padding()
//                        .padding(.horizontal)
//                        .background(Color.theme.accent)
//                        .foregroundColor(.white)
//                        .cornerRadius(20)
//                })
//            } //:VSTACK
//            .background(Color.white)
//            .cornerRadius(40, corners: [.topLeft, .topRight])
//            .transition(.slide)
//        }
//    }
//}
//
//struct ContinuePopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContinuePopUpView(guidedVM: GuidedViewModel())
//    }
//}
