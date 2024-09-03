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
}
