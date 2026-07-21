//
//  SampleRecipes.swift
//  RecipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-20.
//

//
//  SampleRecipes.swift
//  RecipeExplorer
//

import Foundation

enum SampleRecipes {
    static let all: [Recipe] = [
        Recipe(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            name: "Vegetable Pasta",
            category: .dinner,
            cookingTime: 30,
            rating: 4.7,
            ingredients: [
                "Pasta",
                "Tomatoes",
                "Bell pepper",
                "Spinach",
                "Olive oil"
            ],
            instructions: [
                "Boil the pasta according to the package instructions.",
                "Heat olive oil and cook the vegetables.",
                "Add the cooked pasta to the vegetables.",
                "Mix well and serve while warm."
            ],
            symbolName: "fork.knife"
        ),

        Recipe(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            name: "Berry Oatmeal",
            category: .breakfast,
            cookingTime: 10,
            rating: 4.5,
            ingredients: [
                "Rolled oats",
                "Milk",
                "Mixed berries",
                "Maple syrup"
            ],
            instructions: [
                "Add oats and milk to a saucepan.",
                "Cook over medium heat until the oats become soft.",
                "Place the oatmeal in a bowl.",
                "Add berries and maple syrup."
            ],
            symbolName: "takeoutbag.and.cup.and.straw"
        ),

        Recipe(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            name: "Chickpea Salad",
            category: .lunch,
            cookingTime: 15,
            rating: 4.8,
            ingredients: [
                "Chickpeas",
                "Cucumber",
                "Tomatoes",
                "Red onion",
                "Lemon juice"
            ],
            instructions: [
                "Rinse and drain the chickpeas.",
                "Chop the cucumber, tomatoes and onion.",
                "Combine everything in a large bowl.",
                "Add lemon juice and mix well."
            ],
            symbolName: "leaf.fill"
        ),

        Recipe(
            id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
            name: "Banana Smoothie",
            category: .drinks,
            cookingTime: 5,
            rating: 4.4,
            ingredients: [
                "Banana",
                "Milk",
                "Yogurt",
                "Cinnamon"
            ],
            instructions: [
                "Place all ingredients in a blender.",
                "Blend until smooth.",
                "Pour into a glass and serve immediately."
            ],
            symbolName: "cup.and.saucer.fill"
        ),

        Recipe(
            id: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!,
            name: "Fruit Yogurt Bowl",
            category: .breakfast,
            cookingTime: 5,
            rating: 4.6,
            ingredients: [
                "Yogurt",
                "Banana",
                "Strawberries",
                "Granola"
            ],
            instructions: [
                "Add yogurt to a bowl.",
                "Slice the banana and strawberries.",
                "Place the fruit over the yogurt.",
                "Sprinkle granola on top."
            ],
            symbolName: "birthday.cake.fill"
        ),

        Recipe(
            id: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!,
            name: "Vegetable Soup",
            category: .dinner,
            cookingTime: 40,
            rating: 4.9,
            ingredients: [
                "Carrots",
                "Potatoes",
                "Celery",
                "Vegetable stock",
                "Black pepper"
            ],
            instructions: [
                "Wash and chop all vegetables.",
                "Bring the vegetable stock to a boil.",
                "Add the vegetables.",
                "Simmer until the vegetables become tender.",
                "Season and serve."
            ],
            symbolName: "frying.pan.fill"
        ),

        Recipe(
            id: UUID(uuidString: "77777777-7777-7777-7777-777777777777")!,
            name: "Apple Cinnamon Toast",
            category: .snack,
            cookingTime: 12,
            rating: 4.3,
            ingredients: [
                "Bread",
                "Apple",
                "Cinnamon",
                "Butter"
            ],
            instructions: [
                "Toast the bread.",
                "Slice the apple thinly.",
                "Place apple slices over the toast.",
                "Sprinkle cinnamon on top."
            ],
            symbolName: "carrot.fill"
        ),

        Recipe(
            id: UUID(uuidString: "88888888-8888-8888-8888-888888888888")!,
            name: "Chocolate Fruit Cup",
            category: .dessert,
            cookingTime: 20,
            rating: 4.7,
            ingredients: [
                "Strawberries",
                "Banana",
                "Dark chocolate"
            ],
            instructions: [
                "Cut the fruit into small pieces.",
                "Melt the dark chocolate.",
                "Pour the chocolate over the fruit.",
                "Cool briefly before serving."
            ],
            symbolName: "birthday.cake.fill"
        )
    ]
}
