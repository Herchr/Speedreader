////
////  KineticTextView.swift
////  Speedreader
////
////  Created by Herman Christiansen on 14/10/2021.
////
//
//import SwiftUI
//
//struct KineticTextView: View {
//    @ObservedObject var kineticVM: KineticViewModel
//
//    var body: some View {
//        GeometryReader { geometry in
//            VStack {
//                VStack(alignment: .leading, spacing: 10) {
//                    ForEach(Array(zip(kineticVM.kineticText.indices, kineticVM.kineticText)), id: \.1){ index, text in
//                        VStack(alignment: .leading, spacing: 0) {
//                            ZStack(alignment: .bottomLeading) {
//                                    Text("\(text)")
//                                        .background(GeometryReader{ geo in
//                                            Color.clear
//                                                .onAppear{
//                                                    kineticVM.widths[index] = (geo.size.width)
//                                                }
//                                        })
//
//                                Capsule()
//                                    .opacity(index == kineticVM.currLine ? 1 : 0)
//                                    .frame(width: (kineticVM.isPlaying) ? kineticVM.widths[index] : 0, height: 5)
//                                    .offset(y: 3)
//                                Capsule()
//                                    .frame(width: (kineticVM.isPlaying && (index == kineticVM.currLine)) ? kineticVM.widths[index] : 0, height: 5)
//                                    .animation( (kineticVM.isPlaying) ?
//                                                Animation.linear(duration: kineticVM.currInterval).repeatForever(autoreverses: false) : Animation.default
//                                )
//                                    .opacity(index == kineticVM.currLine ? 1 : 0)
//                                    .foregroundColor(.white)
//                                    .offset(y: 3)
//                            }
//                        }
//                    }
//                }
//                .frame(width: geometry.size.width)
//                .padding()
//                .font(.callout)
//                Button(action: {
//                    kineticVM.toggleIsPlaying()
//                }, label: {Text("togg")})
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//        }
//    }
//}
//
//struct KineticTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        KineticTextView(kineticVM: KineticViewModel(text: Constants.dummyText.components(separatedBy: " ")))
//    }
//}
