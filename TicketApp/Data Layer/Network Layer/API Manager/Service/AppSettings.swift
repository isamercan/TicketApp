//
//  AppSettings.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import UIKit

public struct AppSettings {
    public static let bundleId = Bundle.main.bundleIdentifier!
    public static let groupId = "group." + Bundle.main.bundleIdentifier!
    public static let defaultLocale = Locale(identifier: "tr")
    public static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    public static let platform: String = "ios"
    public static let deviceName: String = UIDevice.current.model
    public static let authorization: String = "Basic JEcYcEMyantZV095WVc3G2JtVjNZbWx1"
    public static let contentType: String = "application/json"
}
