//
//  RecipeViewModel.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

//
//  

import Foundation
import SwiftUI
import Combine

// @MainActor ensures that all changes affecting the user interface
// are performed safely on the main thread.
@MainActor
final class RecipeViewModel: ObservableObject {

    // SwiftUI refreshes the observing views whenever recipes changes.
    @Published var recipes: [Recipe]

    // Stores text entered in the search field.
    @Published var searchText: String = ""

    // Stores the category selected in the segmented Picker.
    @Published var selectedCategory: RecipeCategory = .all

    // Using an optional parameter prevents the Swift 6
    // main-actor warning caused by using sampleRecipes
    // directly as a default argument.
    init(recipes: [Recipe]? = nil) {
        self.recipes = recipes ?? Recipe.sampleRecipes
    }

    // Returns recipes that match both the selected category
    // and the search text.
    var filteredRecipes: [Recipe] {

        recipes.filter { recipe in

            // Show all categories when .all is selected.
            let matchesCategory =
                selectedCategory == .all ||
                recipe.category == selectedCategory

            // Remove unnecessary spaces from the search text.
            let cleanedSearchText = searchText.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

            let matchesSearch: Bool

            // When the search bar is empty, every recipe
            // passes the search condition.
            if cleanedSearchText.isEmpty {
                matchesSearch = true
            } else {

                // Combine all ingredients into one searchable string.
                let ingredientText = recipe.ingredients.joined(
                    separator: " "
                )

                matchesSearch =
                    recipe.name.localizedCaseInsensitiveContains(
                        cleanedSearchText
                    ) ||
                    recipe.category.rawValue.localizedCaseInsensitiveContains(
                        cleanedSearchText
                    ) ||
                    ingredientText.localizedCaseInsensitiveContains(
                        cleanedSearchText
                    )
            }

            return matchesCategory && matchesSearch
        }
    }

    // Returns only recipes marked as favourites.
    var favoriteRecipes: [Recipe] {
        recipes.filter { $0.isFavorite }
    }

    // Adds a new recipe at the beginning of the list.
    func addRecipe(_ recipe: Recipe) {
        recipes.insert(recipe, at: 0)
    }

    // Changes the favourite status of a selected recipe.
    func toggleFavorite(for recipe: Recipe) {

        guard let index = recipes.firstIndex(
            where: { $0.id == recipe.id }
        ) else {
            return
        }

        recipes[index].isFavorite.toggle()
    }

    // Deletes a specific recipe.
    func deleteRecipe(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }
    }

    // Deletes recipes using indexes supplied by a SwiftUI List.
    func deleteRecipes(at offsets: IndexSet) {

        // The indexes come from filteredRecipes.
        // First identify the actual recipes represented by those indexes.
        let recipesToDelete = offsets.map {
            filteredRecipes[$0]
        }

        // Delete the matching recipes from the main recipes collection.
        for recipe in recipesToDelete {
            deleteRecipe(recipe)
        }
    }
}
