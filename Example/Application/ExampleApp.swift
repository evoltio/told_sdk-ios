//
//  App.swift
//  Told Example
//
//  Created by Jérémy Magnier on 24/01/2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

@main
struct ExampleApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            TabView()
        }
    }
}
