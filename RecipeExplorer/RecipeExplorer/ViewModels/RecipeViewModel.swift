//
//  RecipeViewModel.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

//
//  

//
//  RecipeViewModel.swift
//  RecipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

//
//  RecipeViewModel.swift
//  RecipeExplorer
//

import Foundation
import SwiftUI
import Combine

// All UI-related changes are performed on the main thread.
@MainActor
final class RecipeViewModel: ObservableObject {
    // MARK: - Published properties

    // Contains every recipe available during the current app session.
    @Published private(set) var recipes: [Recipe]

    // Text entered into the searchable field.
    @Published var searchText: String = ""

    // Category selected by the user.
    @Published var selectedCategory: RecipeCategory = .all

    // Sort method selected by the user.
    @Published var selectedSortOption: RecipeSortOption = .name

    // Contains UUID strings for recipes marked as favourites.
    @Published private(set) var favoriteIDs: Set<String> = []

    // MARK: - UserDefaults key

    private let favoriteStorageKey = "favoriteRecipeIDs"

    // MARK: - Initialization

    init(recipes: [Recipe] = SampleRecipes.all) {
        self.recipes = recipes
        loadFavorites()
    }

    // MARK: - Filtered and sorted recipes

    var displayedRecipes: [Recipe] {
        var results = recipes

        let cleanedSearch = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        // Feature 1: Search.
        if !cleanedSearch.isEmpty {
            results = results.filter { recipe in
                let nameMatches =
                    recipe.name.localizedCaseInsensitiveContains(
                        cleanedSearch
                    )

                let categoryMatches =
                    recipe.category.rawValue
                        .localizedCaseInsensitiveContains(cleanedSearch)

                let ingredientMatches =
                    recipe.ingredients.contains { ingredient in
                        ingredient.localizedCaseInsensitiveContains(
                            cleanedSearch
                        )
                    }

                return nameMatches ||
                    categoryMatches ||
                    ingredientMatches
            }
        }

        // Feature 2: Category filtering.
        if selectedCategory != .all {
            results = results.filter { recipe in
                recipe.category == selectedCategory
            }
        }

        // Feature 3: Sorting.
        switch selectedSortOption {
        case .name:
            results.sort { first, second in
                first.name.localizedCaseInsensitiveCompare(second.name)
                    == .orderedAscending
            }

        case .cookingTime:
            results.sort { first, second in
                first.cookingTime < second.cookingTime
            }

        case .rating:
            results.sort { first, second in
                first.rating > second.rating
            }
        }

        return results
    }

    var favoriteRecipes: [Recipe] {
        recipes.filter { recipe in
            isFavorite(recipe)
        }
    }

    var favoriteCount: Int {
        favoriteRecipes.count
    }

    // MARK: - Recipe management

    func addRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
    }

    func deleteRecipe(_ recipe: Recipe) {
        recipes.removeAll { storedRecipe in
            storedRecipe.id == recipe.id
        }

        favoriteIDs.remove(recipe.id.uuidString)
        saveFavorites()
    }

    // MARK: - Favourite management

    func isFavorite(_ recipe: Recipe) -> Bool {
        favoriteIDs.contains(recipe.id.uuidString)
    }

    func toggleFavorite(_ recipe: Recipe) {
        let recipeID = recipe.id.uuidString

        if favoriteIDs.contains(recipeID) {
            favoriteIDs.remove(recipeID)
        } else {
            favoriteIDs.insert(recipeID)
        }

        saveFavorites()
    }

    func clearAllFavorites() {
        favoriteIDs.removeAll()
        saveFavorites()
    }

    // MARK: - Filter management

    func resetFilters() {
        searchText = ""
        selectedCategory = .all
        selectedSortOption = .name
    }

    // MARK: - Persistence

    private func saveFavorites() {
        let storedIDs = Array(favoriteIDs)

        UserDefaults.standard.set(
            storedIDs,
            forKey: favoriteStorageKey
        )
    }

    private func loadFavorites() {
        let storedIDs = UserDefaults.standard.stringArray(
            forKey: favoriteStorageKey
        ) ?? []

        favoriteIDs = Set(storedIDs)
    }
}
