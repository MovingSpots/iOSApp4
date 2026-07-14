//
//  Favorites.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

import SwiftUI

// FavoritesView displays only recipes whose
// isFavorite property is true.
struct FavoritesView: View {
    
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        Group {
            if viewModel.favoriteRecipes.isEmpty {
                ContentUnavailableView(
                    "No Favourites",
                    systemImage: "heart.slash",
                    description: Text(
                        "Swipe a recipe or use the heart button to add it to your favourites."
                    )
                )
            } else {
                List(viewModel.favoriteRecipes) { recipe in
                    NavigationLink {
                        RecipeDetailView(
                            viewModel: viewModel,
                            recipe: recipe
                        )
                    } label: {
                        RecipeRowView(recipe: recipe)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            viewModel.toggleFavorite(for: recipe)
                        } label: {
                            Label(
                                "Unfavourite",
                                systemImage: "heart.slash"
                            )
                        }
                        .tint(.orange)
                    }
                }
            }
        }
        .navigationTitle("Favourites")
    }
}

#Preview {
    NavigationStack {
        FavoritesView(
            viewModel: RecipeViewModel()
        )
    }
}
