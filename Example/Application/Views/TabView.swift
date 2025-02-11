//
//  ContentView.swift
//  Told Example
//
//  Created by Jérémy Magnier on 24/01/2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        SwiftUI.TabView {
            UIKitControllerRepresentable()
                .tabItem {
                    Text("UIKit")
                }

            NavigationStack {
                SwiftUIView()
            }
            .tabItem {
                Text("SwiftUI")
            }

            DebugView()
                .tabItem {
                    Text("Debug")
                }
        }
    }
}
