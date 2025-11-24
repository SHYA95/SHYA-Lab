
//
//  AppMainApp.swift
//  ShyaLab
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import SwiftUI
import SwiftUICombineApp
import MovieApp

@main
struct AppMainApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
      //MARK: First module: Weather app (SwiftUI & Combine)
//            SwiftUICombineAppView()
      //MARK: Second module: Movies app (Uikit)
            MovieAppView()
        }
    }
}
