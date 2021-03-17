//
//  SystemConfig.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 17/03/21.
//

import Foundation

enum SystemConfig {
    case prod
    case dev
    case test
    
    static var current: SystemConfig {
        #if RELEASE
            return .prod
        #elseif DEBUG
            if isTestRunning() {
                return .test
            } else {
                return .dev
            }
        #else
            fatalError("Not valid system config")
        #endif
    }
    
    private static func isTestRunning() -> Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}
