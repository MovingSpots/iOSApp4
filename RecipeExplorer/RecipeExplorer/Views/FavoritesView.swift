//
//  Favorites.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

//
//  FavoritesView.swift
//  RecipeExplorer
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: RecipeViewModel

    var body: some View {
        Group {
            if viewModel.favoriteRecipes.isEmpty {
                emptyFavoritesView
            } else {
                List(viewModel.favoriteRecipes) { recipe in
                    NavigationLink {
                        RecipeDetailView(
                            recipe: recipe,
                            viewModel: viewModel
                        )
                    } label: {
                        RecipeRowView(
                            recipe: recipe,
                            isFavorite: true
                        )
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Favourites")
        .toolbar {
            if !viewModel.favoriteRecipes.isEmpty {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear") {
                        viewModel.clearAllFavorites()
                    }
                }
            }
        }
    }

    private var emptyFavoritesView: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash")
                .font(.system(size: 55))
                .foregroundStyle(.secondary)

            Text("No Favourites Yet")
                .font(.title2.bold())

            Text(
                "Open a recipe and tap the heart button to add it here."
            )
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FavoritesView(viewModel: RecipeViewModel())
        }
    }
}
