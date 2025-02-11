//
//  SwiftUIView.swift
//  Told Example
//
//  Created by Jérémy Magnier on 27/01/2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        List {
            NavigationLink("Push") {
                ChildView()
            }
        }
    }
}
