//
//  InternetReachability.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 11/10/2025.
//

import Foundation
import Network
import SystemConfiguration

final class InternetReachability {
    
    /// Shared instance of internet class.
    ///
    static var shared: InternetReachability {
        let instance = InternetReachability()
        return instance
    }
    
    
    /// Proprites.
    ///
    private let monitor = NWPathMonitor()
    
    
    /// Init cycle.
    ///
    private init() { }
    
    deinit {
        monitor.cancel()
    }
    
    /// check internet reachability
    /// - Parameters:
    ///   - successCompletion: success block of code
    ///   - failedCompletion: fail block of code
    func InternetConnectivity(successCompletion: @escaping ()->(), failCompletion: @escaping ()->()) {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            failCompletion()
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        switch ret {
        case true: successCompletion()
        case false: failCompletion()
        }
    }
}
