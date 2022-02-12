//
//  ContentView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/08/2021.
//

import SwiftUI
import CoreData

enum ActiveFullScreenCover: Identifiable{
    case Auth;
    case WPMText;
    case Questionnaire;
    
    var id: Int{
        hashValue
    }
}

struct ContentView: View {
    @StateObject var viewRouter: ViewRouter = ViewRouter()
    @StateObject var globalViewModel: GlobalViewModel = GlobalViewModel()
    @StateObject var rsvpVM : RSVPViewModel = RSVPViewModel()
    @StateObject var kineticVM : KineticViewModel = KineticViewModel()
    
    @State var activeItem: ActiveFullScreenCover?// = ActiveFullScreenCover.Auth
    
    func setActiveItem(item: ActiveFullScreenCover?){
        self.activeItem = item
    }

    var body: some View {
        NavigationView {
            ZStack {
                switch viewRouter.selectedTab {
                case viewRouter.tabImages[0]:
                    RSVPView(vm: rsvpVM)
                       // .zIndex(2)
                case viewRouter.tabImages[1]:
                    GuidedView(rsvpVM: rsvpVM, kineticVM: kineticVM)
                        //.zIndex(2)
                    //Text("jd")
                       // .zIndex(2)
                case viewRouter.tabImages[2]:
                        LibraryView()
                         //   .zIndex(2)
                default:
                    ProfileView()
                       // .zIndex(2)
                        .tabBarPadding()
                }
                //Color.theme.primary.ignoresSafeArea()
                if globalViewModel.showTabBar{
                    CustomTabBarView(vr: viewRouter)
                        .transition(.move(edge: .bottom))
                }
                //.zIndex(3)
            } //:ZSTACK
            .background(Color.theme.background)
            .environmentObject(globalViewModel)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .fullScreenCover(item: $activeItem) { item in
                switch item{
                case .WPMText:
                    WPMText(setActiveItem: setActiveItem)
                case .Questionnaire:
                    Questionnaire(setActiveItem: setActiveItem)
                case .Auth:
                    Authentication(setActiveItem: setActiveItem)
                }
                
            }
        } //:NAVIGATIONVIEW
        .navigationViewStyle(.stack)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
