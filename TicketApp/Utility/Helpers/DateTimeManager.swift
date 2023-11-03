//
//  DateTimeManager.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 2.11.2023.
//

import Foundation

protocol DateTimeManagerProtocol {
    func format(_ dateTimeFormat:UBDateTimeFormat, date:Date)-> String
    func format(_ dateTimeFormat:UBDateTimeFormat, date: String)-> String
    func formatToDate(_ dateTimeFormat: UBDateTimeFormat, dateString: String) -> Date
    func isBeforeDate(d1: Date, d2: Date) -> Bool
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

final class DateTimeManager : DateTimeManagerProtocol {
  
    private static var utilInstance: DateTimeManager?
    public class func shared() -> DateTimeManager {
        if utilInstance == nil {
            utilInstance = DateTimeManager()
        }
        return utilInstance!
    }
    
    private func getFormatter(format:String) -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let locale = Locale.current.language.languageCode?.identifier ?? "tr-TR"
        formatter.locale = Locale.init(identifier: locale)
        return formatter
    }
    
    func format(_ dateTimeFormat: UBDateTimeFormat, date: Date) -> String {
        let formattedDate = getFormatter(format: dateTimeFormat.iso).string(from: date)
        return formattedDate
    }
    
    func formatToDate(_ dateTimeFormat: UBDateTimeFormat, dateString: String) -> Date {
        let date = getFormatter(format: dateTimeFormat.iso).date(from: dateString)
        return date!
    }
    
    func format(_ dateTimeFormat: UBDateTimeFormat, date: String) -> String {
        let dateFormat = formatToDate(.typeRequestDate, dateString: date)
        let formattedDate = getFormatter(format: dateTimeFormat.iso).string(from: dateFormat)
        return formattedDate
    }
    
    func isBeforeDate(d1: Date, d2: Date) -> Bool {
        return d1 < d2 ? true : false
    }
    
    func isAfterDate(d1: Date, d2: Date) -> Bool {
        return d1 > d2 ? true : false
    }
    
}
