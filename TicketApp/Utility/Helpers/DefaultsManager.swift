//
//  DefaultsManager.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 1.11.2023.
//


import Foundation

public enum DefaultsKeys: String {
    case deviceToken = "deviceToken"
}

public protocol DefaultsManagerProtocol {
    func save<T:Encodable>(val: T, key: DefaultsKeys)
    func retrieve<T:Decodable>(type:T.Type, key: DefaultsKeys) -> T?
    func delete(_ element:DefaultsKeys)
}

public class DefaultsManager: DefaultsManagerProtocol {
    
    public static var shared: DefaultsManagerProtocol = DefaultsManager()
    
    public func save<T>(val: T, key: DefaultsKeys) where T : Encodable {
        if let encoded = try? JSONEncoder().encode(val) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
        }
        UserDefaults.standard.synchronize()
    }
    
    public func retrieve<T>(type: T.Type, key: DefaultsKeys) -> T? where T : Decodable {
        if let data = UserDefaults.standard.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            }else {
                print("Couldnt decode object \(key.rawValue)")
                return nil
            }
        }else {
            return nil
        }
    }
    
    
    public func delete(_ element: DefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: element.rawValue)
        UserDefaults.standard.synchronize()        
    }
    
    
}
