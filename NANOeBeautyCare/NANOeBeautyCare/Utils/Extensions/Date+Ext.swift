//
//  Date+Ext.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

extension Date {
    func toTimestamp() -> Int? {
        return Int(self.timeIntervalSince1970)
    }
    
    static func fromTimestamp(_ timestamp: Double) -> Date {
        let date = Date(timeIntervalSince1970: timestamp)
        return date
    }
    
    func convertToLocalTime(fromTimeZone timeZoneAbbreviation: String) -> Date? {
        if let timeZone = TimeZone(abbreviation: timeZoneAbbreviation) {
            let targetOffset = TimeInterval(timeZone.secondsFromGMT(for: self))
            let localOffeset = TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self))
            
            return self.addingTimeInterval(targetOffset - localOffeset)
        }
        
        return nil
    }
    
    func convert(from initTimeZone: TimeZone, to targetTimeZone: TimeZone) -> Date {
        let delta = TimeInterval(initTimeZone.secondsFromGMT() - targetTimeZone.secondsFromGMT())
        return addingTimeInterval(delta)
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    func adding(second: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: second, to: self)!
    }
    func adding(hour: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hour, to: self)!
    }
}
