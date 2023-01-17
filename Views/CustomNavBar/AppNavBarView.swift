//
//  AppNavBarView.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/18/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct AppNavBarView: View {
    var body: some View {
        CustomNavView  {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(destination:
                                Text("Destingation")
                                .customNavigationTitle("SECON SCREEN")
                                .customNavigationSubtitle("should be showing suvtitle")
                ) {
                    Text("asdad")
                }
                

            }
            .customNavigationTitle("Custom Title")
            .CustomNavBarBackButtonHidden(true)
        }
    }
}

@available(iOS 15.0, *)
struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}

@available(iOS 15.0, *)
extension AppNavBarView {
    private var defaultNavView: some View {
        NavigationView {
            ZStack {
                Color.green.ignoresSafeArea()

                NavigationLink(destination: {
                    Text("Destingation")
                        .navigationTitle("Titile 2")
                        .navigationBarBackButtonHidden(false)
                }, label: {
                    Text("Navigate")
                })
                
            }
            .navigationTitle("Nav title here")
        }
        
    }
}

