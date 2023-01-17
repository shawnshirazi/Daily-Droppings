//
//  CustomNavBarContainerView.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/18/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct CustomNavBarContainerView<Content:View> : View {
    
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil

    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self) { value in
            self.title = value
        }
        .onPreferenceChange(CustomNavBarSubtitilePreferenceKey.self) { value in
            self.subtitle = value
        }
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self) { value in
            self.showBackButton = !value
        }
    }
}

@available(iOS 15.0, *)
struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            ZStack {
                Color.green.ignoresSafeArea()
                
                Text("Hello world")
                    .foregroundColor(.white)
                    .customNavigationTitle("New title")
                    .customNavigationSubtitle("Subtitle")
                    .CustomNavBarBackButtonHidden(true)
            }
        }
    }
}

