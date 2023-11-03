//
//  Date+Extension.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 3.11.2023.
//

import Foundation

extension Date {
    
    // This Swift extension adds some convenient properties to the Date data type.
    // This computed property allows you to access the date representing tomorrow.
    static var tomorrow: Date { return Date().dayAfter }
    
    // This computed property allows you to access the current date.
    static var today: Date { return Date() }
    
    // This computed property provides a way to get the date that is one day after the current date.
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
}
