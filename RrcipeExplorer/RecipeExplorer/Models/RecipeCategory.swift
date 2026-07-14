//
//  RecipeCategory.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

import Foundation

// RecipeCategory represents the different groups of recipes
// available in the application.
//
// CaseIterable allows us to access all categories using:
// RecipeCategory.allCases
//
// Identifiable allows each category to be used safely
// inside SwiftUI controls such as Picker and ForEach.
enum RecipeCategory: String, CaseIterable, Identifiable {
    
    case all = "All"
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
    
    // SwiftUI requires a stable identifier when displaying
    // a collection of category values.
    var id: String {
        rawValue
    }
    
    // Each category receives an SF Symbol.
    // SF Symbols are built into Apple platforms, so we do
    // not need to download separate image files.
    var iconName: String {
        switch self {
        case .all:
            return "square.grid.2x2"
        case .breakfast:
            return "sunrise.fill"
        case .lunch:
            return "fork.knife"
        case .dinner:
            return "moon.stars.fill"
        case .snack:
            return "takeoutbag.and.cup.and.straw.fill"
        }
    }
}
