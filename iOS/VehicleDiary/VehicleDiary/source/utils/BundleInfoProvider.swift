//
//  BundleInfoProvider.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-11-27.
//

import Foundation

enum BundleInfoProvider {
    static var versionNumber: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    }

    static var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
    }

    static var vbNumber: String {
        "\(versionNumber).\(buildNumber)"
    }
}

extension BundleInfoProvider {
    enum ConfigKey: String {
        case appEnvironment = "APP_ENVIRONMENT"

        /// value for configuration key that is stored within `Info.plist`
        var value: String {
            guard let infoDict = Bundle.main.infoDictionary,
                  let value = infoDict[self.rawValue],
                  let stringValue = value as? String,
                  !stringValue.isEmpty
            else {
                preconditionFailure("unable to find value for key=\(self.rawValue)")
            }
            return stringValue
        }
    }
}
