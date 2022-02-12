//
//  ContinuePopUpView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/10/2021.
import SwiftUI
import Lottie

struct ContinuePopUpView: View {
    @ObservedObject var guidedVM: GuidedViewModel
    @ObservedObject var rsvpVM: RSVPViewModel
    @ObservedObject var kineticVM: KineticViewModel
    @EnvironmentObject var globalVM: GlobalViewModel
    
    
//    func delay( seconds: Double, content: @escaping () -> Void){
//        DispatchQueue.main.asyncAfter(deadline: .now() + seconds){
//            content()
//        }
//    }
    func nextStage(){
        guidedVM.currentRound += 1
        withAnimation{
            guidedVM.showContinuePopUp = false
        }
        
        if guidedVM.sessionType == SessionType.RSVP{
            rsvpVM.wpm += guidedVM.initialSpeed*0.333
            DispatchQueue.main.async {
                rsvpVM.toggleIsPlaying()
            }
            delay(seconds: guidedVM.timeInterval){
                if !guidedVM.started{
                    return
                }
                rsvpVM.toggleIsPlaying()
                
                // RSVP SESSION FINISHED
                if guidedVM.currentRound >= guidedVM.totalRounds{
                    guidedVM.currentRound = 0 // Reset session
                    
                    withAnimation{
                        guidedVM.started = false
                        guidedVM.showCompleteScreen = true
                    }
                    
                    // Remove completed screen after a few seconds
                    delay(seconds: 4){
                        withAnimation{
                            guidedVM.showCompleteScreen = false
                            globalVM.showTabBar = true
                        }
                    }
                }else{
                    withAnimation(.spring()){
                        guidedVM.showContinuePopUp = true
                    }
                }
            }
        }else{
            kineticVM.wpm += guidedVM.initialSpeed*0.333
            DispatchQueue.main.async {
                kineticVM.toggleIsPlaying()
            }
            delay(seconds: guidedVM.timeInterval){
                if !guidedVM.started{
                    return
                }
                kineticVM.toggleIsPlaying()
                
                // KINETIC SESSION FINISHED
                if guidedVM.currentRound >= guidedVM.totalRounds{
                    guidedVM.currentRound = 0 // Reset session
                    delay(seconds: 1){
                        withAnimation{
                            guidedVM.started = false
                            guidedVM.showCompleteScreen = true
                        }
                    }
                    
                    // Remove completed screen after a few seconds
                    delay(seconds: 4){
                        withAnimation{
                            guidedVM.showCompleteScreen = false
                        }
                        delay(seconds: 0.5){
                            withAnimation(.spring()){
                                globalVM.showTabBar = true
                            }
                        }
                    }
                    
                }else{
                    delay(seconds: guidedVM.popUpPause){
                        withAnimation(.spring()){
                            guidedVM.showContinuePopUp = true
                        }
                    }
                }
            }
        }
        
    }
    
    var body: some View {
        VStack() {
            //Background
            Spacer()
            //Popup
            VStack {
                
                // Animation
                HStack {
                    Spacer()
                    LottieView(fileName: "Speedometer_animation")
                        .frame(width: 200, height: 100)
                        .offset(x:-20)

                    Spacer()
                }
                
                // Text
                HStack(alignment:.center) {
                    Text("The speed will now be increased by \(Text("\(guidedVM.getWpmIncrease(currentRound: guidedVM.currentRound))%").font(.title3).foregroundColor(Color.theme.text).fontWeight(.black)) of your initial speed")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.text)
                        .multilineTextAlignment(.center)
                }
                
                // Continue button
                Button(action: nextStage, label: {
                    Text("Continue")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.vertical, 15)
                        .padding(.horizontal, UIScreen.main.bounds.width / 2.95)
                        .background(Color.theme.primary)
                        .foregroundColor(Color.theme.accent)
                        //.cornerRadius(44)
                        .clipShape(Capsule())
                })
                .padding(.bottom)
            } //:VSTACK
            
            .background(Color.theme.background)
            .cornerRadius(44, corners: [.topLeft, .topRight])
            .shadow(radius: 5)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContinuePopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ContinuePopUpView(guidedVM: GuidedViewModel(), rsvpVM: RSVPViewModel(), kineticVM: KineticViewModel())
    }
}
