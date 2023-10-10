//
//  FilterOptions.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import Foundation
enum FilterOptions: String, CaseIterable, Identifiable {
    case releasedThisWeek
    case releasedLastWeek
    case releasingNextWeek
    case releaseThisMonth
 
    var id: Self { return self }

    var title: String {
        switch self {
            case .releasedThisWeek:
                return "Released this week"
            case .releasedLastWeek:
                return "Released last week"
            case .releasingNextWeek:
               return "Releasing next week"
        case .releaseThisMonth:
            return "Release this month"
        }
    }
}
