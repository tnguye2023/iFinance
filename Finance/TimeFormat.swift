//
//  TimeFormat.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/13/22.
//

import Foundation

func timeSince(date: Date) -> String {
    let mins = Int(-date.timeIntervalSinceNow)/60
    let hrs = mins/60
    let days = hrs/24
    
    if mins < 120 {
        return "\(mins) minutes ago"
    } else if mins >= 120 && hrs < 48 {
        return "\(hrs) hours ago"
    } else {
        return "\(days) days ago"
    }
}
