//
//  Recipe.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

//
//  Recipe.swift
//  RecipeExplorer
//

import Foundation

// Represents the categories available in the application.
enum RecipeCategory: String, CaseIterable, Identifiable, Codable {
    case all = "All"
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case dessert = "Dessert"
    case snack = "Snack"
    case drinks = "Drinks"

    var id: String {
        rawValue
    }
}

// Represents the available sorting choices.
enum RecipeSortOption: String, CaseIterable, Identifiable {
    case name = "Name"
    case cookingTime = "Cooking Time"
    case rating = "Rating"

    var id: String {
        rawValue
    }
}

// Represents the two supported screen layouts.
enum RecipeLayout {
    case list
    case grid
}

// Represents one recipe.
struct Recipe: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var category: RecipeCategory
    var cookingTime: Int
    var rating: Double
    var ingredients: [String]
    var instructions: [String]

    // This application uses SF Symbols, not asset-image names.
    var symbolName: String

    // Builds text used by ShareLink.
    var shareText: String {
        let ingredientList = ingredients.joined(separator: ", ")

        return """
        \(name)

        Category: \(category.rawValue)
        Cooking time: \(cookingTime) minutes
        Rating: \(rating.formatted(.number.precision(.fractionLength(1)))) out of 5

        Ingredients: \(ingredientList)
        """
    }
}
