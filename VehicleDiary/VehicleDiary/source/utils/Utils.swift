//
//  Utils.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-11-27.
//


/// Name space for all Utilities tht shall
enum Utils {}

extension Utils {
    enum AppEnvironment: String {
        case development = "DEBUG"
        case production = "RELEASE"

        static var current: AppEnvironment {
            let rawValue = BundleInfoProvider.ConfigKey.appEnvironment.value
            guard let value = AppEnvironment(rawValue: rawValue) else {
                preconditionFailure("unable to create \(String(describing: AppEnvironment.self)) from rawValue=\(rawValue)")
            }
            return value
        }
    }
}
