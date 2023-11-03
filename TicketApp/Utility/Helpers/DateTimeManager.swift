//
//  DateTimeManager.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation

// Protocol for a date and time manager
protocol DateTimeManagerProtocol {
    // Format a date to a string using a specific date format
    func format(_ dateTimeFormat: UBDateTimeFormat, date: Date) -> String
    
    // Format a date string to a string using a specific date format
    func format(_ dateTimeFormat: UBDateTimeFormat, date: String) -> String
    
    // Convert a date string to a Date object using a specific date format
    func formatToDate(_ dateTimeFormat: UBDateTimeFormat, dateString: String) -> Date
    
    // Check if the first date is before the second date
    func isBeforeDate(d1: Date, d2: Date) -> Bool
    
    // Check if the first date is after the second date
    func isAfterDate(d1: Date, d2: Date) -> Bool
}

protocol DateTimeFormat {
    var iso: String { get }
}

enum UBDateTimeFormat: DateTimeFormat {
    case longDateFormat
    case searchDateFormat
    case calendarTextFormat
    case listDateFormat
    case monthAndDay
    case justYear
    case typeRequestDate
    case hourAndMinute
    case month
    case year
    
    var iso: String {
        switch self {
            case .longDateFormat: return "MMM dd, yyyy EEEE"
            case .searchDateFormat: return "dd MMM yyyy EEEE"
            case .calendarTextFormat: return "MMM dd, yyyy - EEE"
            case .monthAndDay: return "MMM dd, EEEE"
            case .justYear: return "yyyy"
            case .listDateFormat: return "dd MMM, EEEE"
            case .typeRequestDate: return "yyyy-MM-dd'T'HH:mm:ss"
            case .hourAndMinute: return "HH:mm"
            case .month: return "MM"
            case .year: return "yyyy"
        }
    }
}


final class DateTimeManager: DateTimeManagerProtocol {
    // Singleton instance of DateTimeManager
    private static var utilInstance: DateTimeManager?
    
    // Get the shared instance of DateTimeManager
    public class func shared() -> DateTimeManager {
        if utilInstance == nil {
            utilInstance = DateTimeManager()
        }
        return utilInstance!
    }
    
    // Private method to create and configure a date formatter
    private func getFormatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let locale = Locale.current.language.languageCode?.identifier ?? "tr-TR"
        formatter.locale = Locale(identifier: locale)
        return formatter
    }
    
    // Format a Date to a string using a specific date format
    func format(_ dateTimeFormat: UBDateTimeFormat, date: Date) -> String {
        let formattedDate = getFormatter(format: dateTimeFormat.iso).string(from: date)
        return formattedDate
    }
    
    // Convert a date string to a Date object using a specific date format
    func formatToDate(_ dateTimeFormat: UBDateTimeFormat, dateString: String) -> Date {
        let date = getFormatter(format: dateTimeFormat.iso).date(from: dateString)
        return date!
    }
    
    // Format a date string to a string using a specific date format
    func format(_ dateTimeFormat: UBDateTimeFormat, date: String) -> String {
        let dateFormat = formatToDate(.typeRequestDate, dateString: date)
        let formattedDate = getFormatter(format: dateTimeFormat.iso).string(from: dateFormat)
        return formattedDate
    }
    
    // Check if the first date is before the second date
    func isBeforeDate(d1: Date, d2: Date) -> Bool {
        return d1 < d2 ? true : false
    }
    
    // Check if the first date is after the second date
    func isAfterDate(d1: Date, d2: Date) -> Bool {
        return d1 > d2 ? true : false
    }
}
