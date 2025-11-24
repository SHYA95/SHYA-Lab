//
//  HomeView.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Home Screen")
                    .font(.largeTitle)
                
                NavigationLink("Go to Details", destination: DetailsView())
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .navigationTitle("Home")
        }
    }
}
