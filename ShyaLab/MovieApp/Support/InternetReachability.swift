//
//  InternetReachability.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import Foundation
import Network

final class InternetReachability {
    
    static let shared = InternetReachability()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetReachabilityMonitor")
    
    var isInternetAvailable: Bool = false
    
    private init() {
        startMonitoring()
    }
    
    deinit {
        monitor.cancel()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isInternetAvailable = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
