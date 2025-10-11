
//
//  AppMainApp.swift
//  ShyaLab
//
//  Created by Shrouk Yasser on 11/10/2025.
//

import SwiftUI
import SwiftUICombineApp

@main
struct AppMainApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
      //MARK: First module: Weather app (SwiftUI & Combine)
            SwiftUICombineAppView()
        }
    }
}
