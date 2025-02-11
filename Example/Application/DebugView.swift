//
//  DebugView.swift
//  Told Example
//
//  Created by Jérémy Magnier on 24/01/2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI
import Told

enum Environment: String, Identifiable, CaseIterable {
    case production
    case development
    case custom

    var id: Self { self }
}

struct DebugView: View {
    @State private var isAlreadyInitialized: Bool = false
    @State private var sourceId: String = ""
    @State private var applicationId: String = ""
    @State private var selectedEnvironment: Environment = .development
    @State private var serverURL: String = ""
    @State private var widgetURL: String = ""

    @State private var addPropertyIdentify: Bool = false
    @State private var propertiesIdentify: [String: AnyHashable] = [:]
    @State private var newKeyIdentify: String = ""
    @State private var newValueIdentify: String = ""

    @State private var addPropertyEvent: Bool = false
    @State private var propertiesEvent: [String: AnyHashable] = [:]
    @State private var newKeyEvent: String = ""
    @State private var newValueEvent: String = ""

    @State private var language: String = ""

    @State private var debug: Bool = true

    @State private var customEvent = ""

    @State private var email: String = ""
    @State private var name: String = ""

    var body: some View {
        List {
            Section {
                TextField("SourceId", text: $sourceId)
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                TextField("ApplicationId", text: $applicationId)
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                Picker("Environment", selection: $selectedEnvironment) {
                    ForEach(Environment.allCases) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                }
                if selectedEnvironment == .custom {
                    TextField("ServerURL", text: $serverURL)
                        .keyboardType(.URL)
                        .textInputAutocapitalization(.never)
                    TextField("WidgetURL", text: $widgetURL)
                        .keyboardType(.URL)
                        .textInputAutocapitalization(.never)
                }
                Toggle("Debug", isOn: $debug)
                Button("Init") {
                    if let configuration = createConfiguration() {
                        Told.init(configuration, debug: debug)
                        isAlreadyInitialized = true
                    }
                }
            } footer: {
                if isAlreadyInitialized {
                    Text("Relaunch the app if the initialization fails.")
                }
            }
            .disabled(isAlreadyInitialized)

            Section {
                Button("Activate Screen Tracking") {
                    Told.activateAutomaticScreenTracking()
                }

                Button("Deactivate Screen Tracking") {
                    Told.deactivateAutomaticScreenTracking()
                }
            }

            Section {
                TextField("Custom Event Name", text: $customEvent)
                ForEach(propertiesEvent.sorted(by: { $0.key < $1.key }), id: \.key) { (key, value) in
                    LabeledContent(key, value: String(describing: value))
                }

                Button("Add Property") {
                    addPropertyEvent = true
                }

                Button("Send Custom Event") {
                    Told.trackEvent(customEvent, properties: propertiesEvent)
                }
            }

            Section {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)

                ForEach(propertiesIdentify.sorted(by: { $0.key < $1.key }), id: \.key) { (key, value) in
                    LabeledContent(key, value: String(describing: value))
                }

                Button("Add Property") {
                    addPropertyIdentify = true
                }

                Button("Identify") {
                    Told.identify(properties: [
                        "email": email,
                        "name": name
                    ].merging(propertiesIdentify, uniquingKeysWith: { _, value in value }))
                }
            }

            Section {
                TextField("Language", text: $language)
                    .textInputAutocapitalization(.never)
                Button("Update Language") {
                    Told.updateLanguage(language)
                }
            }

            Section {
                Button("Reset") {
                    Told.reset()
                }
            }

            Section {
                Button("Debug") {
                    Told.debugWidget()
                }
            }
        }
        .alert("Add Property Identify", isPresented: $addPropertyIdentify) {
            TextField("Key", text: $newKeyIdentify)
                .textInputAutocapitalization(.never)
            TextField("Value", text: $newValueIdentify)
                .textInputAutocapitalization(.never)
            Button("Ok") {
                propertiesIdentify[newKeyIdentify] = newValueIdentify
                newValueIdentify = ""
                newKeyIdentify = ""
            }
        }
        .alert("Add Property Custom Event", isPresented: $addPropertyEvent) {
            TextField("Key", text: $newKeyEvent)
                .textInputAutocapitalization(.never)
            TextField("Value", text: $newValueEvent)
                .textInputAutocapitalization(.never)
            Button("Ok") {
                propertiesEvent[newKeyEvent] = newValueEvent
                newValueIdentify = ""
                newKeyIdentify = ""
            }
        }
    }

    private func createConfiguration() -> ToldConfiguration? {
        let environment: ToldEnvironment?
        switch selectedEnvironment {
        case .production:
            environment = .production
        case .development:
            environment = .development
        case .custom:
            if let serverURL = URL(string: serverURL), let widgetURL = URL(string: widgetURL) {
                environment = .custom(serverUrl: serverURL, widgetUrl: widgetURL)
            } else {
                environment = nil
            }
        }
        guard
            let environment = environment,
            !sourceId.isEmpty,
            !applicationId.isEmpty
        else {
            return nil
        }
        return ToldConfiguration(
            sourceId: sourceId,
            applicationId: applicationId,
            environment: environment,
            appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
        )

    }
}
