//
//  ListScrollingExtension.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/18/22.
//

import Foundation
import SwiftUI

extension View {
    
    func hasScrollEnabled(_ value: Bool) -> some View {
        self.onAppear {
            UITableView.appearance().isScrollEnabled = value
        }
    }
}
