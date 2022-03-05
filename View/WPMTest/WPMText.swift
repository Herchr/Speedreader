//
//  WPMText.swift
//  Speedreader
//
//  Created by Herman Christiansen on 19/01/2022.
//

import SwiftUI


struct WPMText: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject var wpmTestVM: WPMTestViewModel = WPMTestViewModel()
    var firestoreManager: FirestoreManager = FirestoreManager()
    
    @State var showQuestionnaire: Bool = false
    @State var moveStartScreenToBottom = false
    var initialTest = true
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            // TEXT SCROLLVIEW
            ScrollView(showsIndicators: false){
                Text("\(wpmTestVM.wpmText)")
                    .multilineTextAlignment(.leading)
                    .lineSpacing(5)
                    .frame(width: screen.width * 0.9)
                    .padding(.top, 40)
                    
                
                Button(action: {
                    wpmTestVM.stopTimer()
                    
                    //wpmTestVM.uploadWPM()
                    if initialTest{
                        firestoreManager.setWPMBefore(wpmBefore: Double(wpmTestVM.calculateWPM()))
                        appViewModel.activeFullScreenCover = ActiveFullScreenCover.Questionnaire
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
                        .padding(.bottom, 30)
                })
                    .shadow(radius: 5)
            }
            .ignoresSafeArea()
            // BLURRED OVERLAY
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(wpmTestVM.startReading ? 0 : 0.97)
                .frame(width: screen.width, height: screen.height)
                .ignoresSafeArea()
            
            // BUTTON
            if !wpmTestVM.startReading{
                VStack{
                    Text("Read the following text and complete the quiz at the end to compute your current reading speed")
                        .font(Font.title2.bold())
                        .padding(.bottom, 30)
                    Button(action: {
                        withAnimation{
                            moveStartScreenToBottom = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                            withAnimation{
                                wpmTestVM.startReading = true
                            }
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
                    .shadow(radius: 5, x: 2, y: 2)
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 30)
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .foregroundStyle(Color.white)
                )
                .frame(width: screen.width*0.9, height: screen.height*0.5)
                .offset(y: moveStartScreenToBottom ? 600 : 0)
            }
        } //: ZSTACK
        .fullScreenCover(isPresented: $showQuestionnaire) {
            Questionnaire(initialTest: initialTest, isActive: $isActive)
        }
        .onAppear{
            if initialTest{
                wpmTestVM.wpmText = Constants.honeyBadgerText
            }else{
                wpmTestVM.wpmText = Constants.dodoText
            }
        }
        
    }
}

struct WPMText_Previews: PreviewProvider {
    static var previews: some View {
        WPMText(initialTest: false, isActive: Binding.constant(true))
    }
}
