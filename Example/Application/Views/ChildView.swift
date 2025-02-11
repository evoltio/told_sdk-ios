//
//  ChildView.swift
//  Told Example
//
//  Created by Jérémy Magnier on 27/01/2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI
import Told

struct ChildView: View {
    var body: some View {
        List {
            Text("ChildView")
        }
        .onAppear {
            Told.trackChangePage("ChildController")
        }
    }
}
