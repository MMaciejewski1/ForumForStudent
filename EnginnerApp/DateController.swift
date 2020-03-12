//
//  DateController.swift
//  EnginnerApp
//
//  Created by majkel on 07.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import Foundation

func dateToTimestamp(date : Date)->Double {
    return round( date.timeIntervalSince1970 * 1000)
}
func timestampToDate(timestamp: Double)->Date {
    return NSDate(timeIntervalSince1970: timestamp / 1000.0) as Date
}
