//
//  KineticTest.swift
//  Speedreader
//
//  Created by Herman Christiansen on 02/11/2021.
//

import SwiftUI


struct KineticTest: View {
    @ObservedObject var kineticVM: KineticViewModel
    @Namespace var underline
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let kineticText = kineticVM.kineticText{
                ForEach(Array(zip(kineticText.indices, kineticText)), id: \.0){ i, sentenceArray in
                    HStack(spacing: 0) {
                        ForEach(Array(zip(sentenceArray.indices, sentenceArray)), id: \.0){ j, w in
                            //WordView(kineticVM: kineticVM, word: w, wordIndex: [i, j], underline: underline)
                            Text("\(w)")
                        }
                    }
                }
            }
            
            Button("Toggle"){
                kineticVM.toggleIsPlaying()
            }
            //Text("\(kineticVM.ad)")
        }
        .frame(width: screen.width)
    }
}

//struct WordView: View {
//    @ObservedObject var kineticVM: KineticViewModel
//    var word: String
//    var wordIndex: [Int]
//    var underline: Namespace.ID
//
//    var body: some View {
//        HStack(spacing: 0) {
//            VStack(spacing: 0) {
//                Text("\(word)")
//                    .background(
//                        VStack{
//                            Spacer()
//                            if wordIndex == [kineticVM.currentLineIndex, kineticVM.currentWordIndex]{
//                                RoundedRectangle(cornerRadius: 12)
//                                    .frame(width: 60, height: 5)
//                                    .foregroundStyle(Color.theme.text)
//                                    .offset(y: 2)
//                                    .matchedGeometryEffect(id: "underline", in: underline)
//                            }else{
//                                RoundedRectangle(cornerRadius: 12)
//                                    .frame(width: 60, height: 5)
//                                    .offset(y: 2)
//                                    //.foregroundStyle(Color.clear)
//                                    .opacity(0)
//                            }
//                        }
//                    )
//            }
//            Text(" ")
//        }
//
////        HStack(spacing: 0) {
////            VStack(alignment: .leading, spacing: 0) {
////                Text("\(word)")
////                    .background(
////                        VStack{
////                            Spacer()
////                            if wordIndex == [kineticVM.currentLineIndex, kineticVM.currentWordIndex]{
////                                RoundedRectangle(cornerRadius: 12)
////                                    .frame(width: nil, height: 5)
////                                    .foregroundStyle(Color.theme.text)
////                                    .matchedGeometryEffect(id: "underline", in: underline)
////                            }else{
////                                RoundedRectangle(cornerRadius: 12)
////                                    .frame(width: nil, height: 5)
////                                    .foregroundStyle(Color.clear)
////                            }
////                        }
////                            .offset(y: 3)
////                    )
////            }
////            Text(" ")
////        }
//    }
//}

struct KineticTest_Previews: PreviewProvider {
    static var previews: some View {
        KineticTest(kineticVM: KineticViewModel())
    }
}
