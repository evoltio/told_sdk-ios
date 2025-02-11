//
//  ChildController.swift
//  Told Example
//
//  Created by Jérémy Magnier on 14/01/2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

final class ChildController: UIHostingController<AnyView> {
    init() {
        super.init(rootView: AnyView(ContentView()))
    }
    
    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private struct ContentView: View {
        var body: some View {
            Text("Child View")
        }
    }
}


final class ChildDelayController: UIHostingController<AnyView> {
    init() {
        super.init(rootView: AnyView(ContentView()))
    }

    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private struct ContentView: View {
        var body: some View {
            Text("Child Delay View")
        }
    }
}
