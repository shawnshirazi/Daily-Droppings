//
//  CustomNavBarView.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/18/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct CustomNavBarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    
    var body: some View {
        HStack {
            
            if showBackButton {
                backButton

            }
                        
            Spacer()
            
            titleSection
            
            Spacer()
            
            if showBackButton {
                backButton
                    .opacity(0)
            }

        }
        .padding()
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(
            Color.brown.ignoresSafeArea(edges: .top)
        )
    }
}

@available(iOS 15.0, *)
struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarView(showBackButton: true, title: "Title here", subtitle: "Subtitle here")
    }
}


@available(iOS 15.0, *)
extension CustomNavBarView {
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSection : some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            if let subtitle = subtitle {
                Text(subtitle)
            }

        }
    }
}

