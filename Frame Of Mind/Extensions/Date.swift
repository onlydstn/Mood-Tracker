//
//  Date.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 03.09.24.
//

import Foundation

extension Date {
    var dayString: String {
        self.formatted(.dateTime.day())
    }
    
    func setTime(hour: Int, minute: Int) -> Date {
            if let date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self) {
                return date
            } else {
                return self
            }
        }
}
