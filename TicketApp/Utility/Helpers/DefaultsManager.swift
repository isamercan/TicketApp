//
//  DefaultsManager.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//
import Foundation

// Enum to define keys for user defaults
public enum DefaultsKeys: String {
    case deviceToken = "deviceToken"
}

// Protocol for managing user defaults
public protocol DefaultsManagerProtocol {
    func save<T: Encodable>(val: T, key: DefaultsKeys)
    func retrieve<T: Decodable>(type: T.Type, key: DefaultsKeys) -> T?
    func delete(_ element: DefaultsKeys)
}

// Implementation of the DefaultsManager using UserDefaults
public class DefaultsManager: DefaultsManagerProtocol {
    // Shared instance of DefaultsManager
    public static var shared: DefaultsManagerProtocol = DefaultsManager()
    
    // Save a value in user defaults
    public func save<T>(val: T, key: DefaultsKeys) where T: Encodable {
        if let encoded = try? JSONEncoder().encode(val) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
        }
        UserDefaults.standard.synchronize()
    }
    
    // Retrieve a value from user defaults
    public func retrieve<T>(type: T.Type, key: DefaultsKeys) -> T? where T: Decodable {
        if let data = UserDefaults.standard.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            } else {
                print("Couldn't decode object \(key.rawValue)")
                return nil
            }
        } else {
            return nil
        }
    }
    
    // Delete a value from user defaults
    public func delete(_ element: DefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: element.rawValue)
        UserDefaults.standard.synchronize()
    }
}
