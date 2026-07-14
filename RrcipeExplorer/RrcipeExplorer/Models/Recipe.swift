//
//  Recipe.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

import Foundation

// Recipe is the main data model of the application.
//
// Identifiable:
// Allows each recipe to be displayed in a SwiftUI List.
//
// Hashable:
// Allows Recipe values to work with SwiftUI navigation
// and collection operations.
struct Recipe: Identifiable, Hashable {
    
    // UUID creates a unique identifier for every recipe.
    let id: UUID
    
    // Main recipe information.
    var name: String
    var category: RecipeCategory
    var ingredients: [String]
    var instructions: String
    var preparationTime: Int
    var symbolName: String
    var isFavorite: Bool
    
    // Custom initializer with convenient default values.
    init(
        id: UUID = UUID(),
        name: String,
        category: RecipeCategory,
        ingredients: [String],
        instructions: String,
        preparationTime: Int,
        symbolName: String = "fork.knife.circle.fill",
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.ingredients = ingredients
        self.instructions = instructions
        self.preparationTime = preparationTime
        self.symbolName = symbolName
        self.isFavorite = isFavorite
    }
}

// Sample data is useful for:
// 1. Testing the application.
// 2. Displaying Xcode previews.
// 3. Demonstrating the app to the instructor.
extension Recipe {
    
    static let sampleRecipes: [Recipe] = [
        
        Recipe(
            name: "Vegetable Omelette",
            category: .breakfast,
            ingredients: [
                "2 eggs",
                "1/4 cup chopped onion",
                "1/4 cup chopped bell pepper",
                "Salt",
                "Black pepper"
            ],
            instructions:
                """
                Beat the eggs in a bowl. Add the chopped vegetables, salt and pepper. Pour the mixture into a heated pan and cook both sides until firm.
                """,
            preparationTime: 15,
            symbolName: "sunrise.fill",
            isFavorite: true
        ),
        
        Recipe(
            name: "Chickpea Salad",
            category: .lunch,
            ingredients: [
                "1 cup cooked chickpeas",
                "1 tomato",
                "1 cucumber",
                "Lemon juice",
                "Salt"
            ],
            instructions:
                """
                Combine the chickpeas, chopped tomato and cucumber in a bowl. Add lemon juice and salt. Mix well and serve fresh.
                """,
            preparationTime: 10,
            symbolName: "leaf.fill"
        ),
        
        Recipe(
            name: "Vegetable Pasta",
            category: .dinner,
            ingredients: [
                "2 cups cooked pasta",
                "1 cup mixed vegetables",
                "1/2 cup tomato sauce",
                "Italian seasoning",
                "Salt"
            ],
            instructions:
                """
                Cook the vegetables until tender. Add tomato sauce and seasoning. Mix in the cooked pasta and simmer for five minutes.
                """,
            preparationTime: 30,
            symbolName: "fork.knife"
        ),
        
        Recipe(
            name: "Fruit Yogurt Bowl",
            category: .snack,
            ingredients: [
                "1 cup yogurt",
                "1 banana",
                "1/2 cup berries",
                "1 tablespoon honey"
            ],
            instructions:
                """
                Add yogurt to a bowl. Top it with sliced banana and berries. Drizzle honey over the fruit before serving.
                """,
            preparationTime: 5,
            symbolName: "takeoutbag.and.cup.and.straw.fill"
        ),
        
        Recipe(
            name: "Avocado Toast",
            category: .breakfast,
            ingredients: [
                "2 slices whole-grain bread",
                "1 ripe avocado",
                "Lemon juice",
                "Salt",
                "Black pepper"
            ],
            instructions:
                """
                Toast the bread. Mash the avocado with lemon juice, salt and pepper. Spread the avocado mixture over the toast.
                """,
            preparationTime: 10,
            symbolName: "leaf.circle.fill"
        ),
        
        Recipe(
            name: "Vegetable Soup",
            category: .dinner,
            ingredients: [
                "1 carrot",
                "1 potato",
                "1 cup green beans",
                "4 cups vegetable broth",
                "Salt and pepper"
            ],
            instructions:
                """
                Chop all vegetables. Add them to a pot with vegetable broth. Bring to a boil and simmer until the vegetables become tender.
                """,
            preparationTime: 40,
            symbolName: "cup.and.saucer.fill",
            isFavorite: true
        )
    ]
}
