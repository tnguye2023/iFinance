//
//  Theme.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/14/22.
//

import Foundation
import SwiftUI

enum Theme: String {
    case coral
    case darkBlue
    case lightBlue
    case lightPurple
    case purple
    case yellow

    
    var accentColor: Color {
        switch self {
        case .yellow, .lightBlue: return .black
        case .coral, .darkBlue, .lightPurple, .purple: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
}
