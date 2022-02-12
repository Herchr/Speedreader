//
//  WPMText.swift
//  Speedreader
//
//  Created by Herman Christiansen on 19/01/2022.
//

import SwiftUI


struct WPMText: View {
    @StateObject var wpmTestVM: WPMTestViewModel = WPMTestViewModel()
    var firestoreManager: FirestoreManager = FirestoreManager()
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var setActiveItem: (ActiveFullScreenCover?) -> Void = {_ in }
    
    var initialTest: Bool = true
    
    @State var showQuestionnaire: Bool = false
    
    var body: some View {
        ZStack {
            // TEXT SCROLLVIEW
            ScrollView(showsIndicators: false){
                Text("\(Constants.wpmTestText)")
                    .multilineTextAlignment(.leading)
                    .lineSpacing(5)
                    .frame(width: width * 0.75)
                    .padding(.top, 40)
                
                Button(action: {
                    wpmTestVM.stopTimer()
                    
                    //wpmTestVM.uploadWPM()
                    if initialTest{
                        firestoreManager.setWPMBefore(wpmBefore: Double(wpmTestVM.calculateWPM()))
                        setActiveItem(ActiveFullScreenCover.Questionnaire)
                    }else{
                        firestoreManager.setWPMAfter(wpmAfter: Double(wpmTestVM.calculateWPM()))
                        showQuestionnaire = true
                    }
                    
                }, label: {
                    Text("Finish")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 50)
                        .background(Color.theme.accent)
                        .cornerRadius(50)
                })
            }
            // BLURRED OVERLAY
            .overlay{
                if !wpmTestVM.startReading{
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .opacity(0.9)
                        .frame(width: width, height: height) 
                }
            }
            // BUTTON
            if !wpmTestVM.startReading{
                VStack{
                    Spacer()
                    Button(action: {
                        withAnimation{
                            wpmTestVM.startReading = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                                wpmTestVM.startTimer()
                            }
                        }
                    }, label: {
                        Text("Start")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 50)
                            .background(Color.theme.accent)
                            .cornerRadius(50)
                            
                    })
                        .shadow(radius: 3, x: 4, y: 6)
                }
            }
        } //: ZSTACK
        .fullScreenCover(isPresented: $showQuestionnaire) {
            Questionnaire(initialTest: self.initialTest)
        }
        
    }
}
//
//struct WPMText_Previews: PreviewProvider
//    static var previews: some View {
//        WPMText()
//    }
//}
