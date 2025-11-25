//
//  MovieApp.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import UIKit
import SwiftUI

public struct MovieAppView: UIViewControllerRepresentable {
    
    public init() {}
  
    public func makeUIViewController(context: Context) -> MainTabBarController {
        return MainTabBarController()
    }
    
    public func updateUIViewController(_ uiViewController: MainTabBarController, context: Context) {
        
    }
}
