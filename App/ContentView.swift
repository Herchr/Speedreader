//
//  ContentView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/08/2021.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @StateObject var viewRouter: ViewRouter = ViewRouter()
    @StateObject var currentBookVM: CurrentBookViewModel = CurrentBookViewModel()
    
    @StateObject var bookListVM: BookListViewModel = BookListViewModel()

    var body: some View {
        NavigationView {
            ZStack(alignment:.bottom) {
                Color.theme.primary.ignoresSafeArea()
                CustomTabBarView(vr: viewRouter)
                    .zIndex(1)
                
                switch viewRouter.selectedTab {
                case viewRouter.tabImages[0]:
                    RSVPView(vm: RSVPViewModel(text: self.currentBookVM.currentBook!.text!.components(separatedBy: " ")))
                        .zIndex(2)
                case viewRouter.tabImages[1]:
                    GuidedView(kineticVM: KineticViewModel(text: currentBookVM.currentBook!.about!.components(separatedBy: " "))
                               , guidedVM: GuidedViewModel())
                        .tabBarPadding()
                    //Text("jd")
                       // .zIndex(2)
                case viewRouter.tabImages[2]:
                    LibraryView(bookListVM: bookListVM)
                        .zIndex(2)
                default:
                    ProfileView()
                        .tabBarPadding()
                }
            } //:ZSTACK
        } //:NAVIGATIONVIEW
        .environmentObject(self.currentBookVM)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var currentBookVM: CurrentBookViewModel = CurrentBookViewModel()
    static var previews: some View {
        ContentView().environmentObject(currentBookVM)
    }
}
