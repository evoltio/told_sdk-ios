# ToldSDK

## Example

To run the example project, clone the repo, and follow `Installation`

## Prerequisites

Create an account and a survey project on [Told website](https://told.club)

Minimum version iOS 16

## Installation

### 1. Install package

#### Swift Package Manager (SPM)

To install ToldSDK via SPM, simply add the following URL : `https://github.com/evoltio/told_sdk-ios.git` to your project dependencies.

#### Cocoapods

ToldSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ToldSDK'
```

### 2. Setup SDK

Call Told init method in AppDelegate.swift :

```swift
//
//  AppDelegate.swift
//

import Told // Import SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        ...
        
        let configuration: ToldConfiguration = .init(
            sourceId: "__SOURCE_ID__",
            applicationId: "__APPLICATION_ID__",
            environment: .development,
            appVersion: "__APP_VERSION__"
        )

        Told.init(configuration)
        
        return true
    }
    
    ...
}
```

## License

ToldSDK is available under the MIT license. See the LICENSE file for more info.

## Maintainers

### Compile app

Please be sure to have the last MacOS and Xcode versions.

Open terminal and install cocoapods package ./Example folder : `pod install`

Open the xworkspace file in the ./Example folder with Xcode : `open Told Example.xcworkspace`

In the top bar, select a device and click on the Run arrow icon to start an emulator. More info here : https://developer.apple.com/documentation/xcode/building-and-running-an-app

### Change environment

You can use for testing custom environment 
If you are testing in local, be sure to set your local IP adress and not localhost.

```swift
ToldConfiguration(
    sourceId: "__SOURCE_ID__",
    applicationId: "__APPLICATION_ID__",
    environment: .custom(
        serverUrl: URL(string: "__SERVER_URL__")!,
        widgetUrl: URL(string: "__WIDGET_URL__")!
    ),
    appVersion: "__APP_VERSION__"
)
```

### Changing GraphQL API

You need to re-build apollo graph by :
* Installing Apollo CLI : `swift package --allow-writing-to-package-directory apollo-cli-install`

### Publish new version SPM

* In root, type following command : `sh generate_apollo_files.sh spm`

* Commit and push your updated codebase on a public repository
* Create a git tag `git tag <version>` and push it with `git push --tags`

#### Publish new version Cocoapods 

* In root, type following command : `sh generate_apollo_files.sh pod`

* Increment version in Told.podspec
* Publish version to Cocoapods : `pod trunk push Told.podspec`
