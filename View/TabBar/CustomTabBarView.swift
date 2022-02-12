//
//  CustomTabBarView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 05/10/2021.
//

import SwiftUI

struct CustomTabBarView: View {
    @ObservedObject var vr: ViewRouter
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing:0){
                ForEach(vr.tabImages, id: \.self){ tabImage in
                    TabBarButton(image: tabImage, vr: vr)
                }
            }
            .padding(22)
            .background(
                Color.white
                    .clipShape(TabCurve(tabPoint: CGFloat(vr.getCurvePoint()) - 15))
            )
            .overlay(
                Circle()
                    .fill(Color.theme.accent)
                    .frame(width: 10, height: 10)
                    .offset(x: CGFloat(vr.getCurvePoint()) - 20)
                ,alignment: .bottomLeading
            )
            .mask(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
            )
            .padding(.horizontal)
            .shadow(radius: 6, y:5)
        }
        .padding(.bottom, 20)
        .ignoresSafeArea()
        
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabBarButton: View {
    var image: String
    @ObservedObject var vr: ViewRouter
    
    var body: some View{
        GeometryReader{ geometry -> AnyView in
            let midX = geometry.frame(in: .global).midX
            DispatchQueue.main.async {
                vr.setTabMidPoint(midPoint: Double(midX))
            }
            return AnyView(
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)){
                        vr.selectedTab = image
                    }
                }, label: {
                    Image(systemName: "\(image)\(vr.selectedTab == image ? ".fill" : ".fill")")
                        .font(.system(size: 26, weight: .black))
                        .foregroundColor(vr.selectedTab == image ? Color.theme.accent : Color.black)
                        .offset(y: vr.selectedTab == image ? -10 : 0)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                })
            )
        } //:GEOMETRYREADER
        .frame(height: 50)
        
    }
}
