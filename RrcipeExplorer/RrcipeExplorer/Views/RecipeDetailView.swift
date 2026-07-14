//
//  RecipeDetailView.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

import SwiftUI

// RecipeDetailView displays the complete information
// for one selected recipe.
struct RecipeDetailView: View {
    
    // The ViewModel is observed so this screen updates
    // when the favourite status changes.
    @ObservedObject var viewModel: RecipeViewModel
    
    let recipe: Recipe
    
    // Obtain the newest version of the recipe from the
    // ViewModel. This keeps the favourite button updated.
    private var currentRecipe: Recipe {
        viewModel.recipes.first(
            where: { $0.id == recipe.id }
        ) ?? recipe
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Large header symbol.
                Image(systemName: currentRecipe.symbolName)
                    .font(.system(size: 70))
                    .foregroundStyle(.green)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 25)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green.opacity(0.12))
                    )
                
                // General recipe information.
                HStack {
                    Label(
                        currentRecipe.category.rawValue,
                        systemImage: currentRecipe.category.iconName
                    )
                    
                    Spacer()
                    
                    Label(
                        "\(currentRecipe.preparationTime) minutes",
                        systemImage: "clock.fill"
                    )
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                // Ingredients section.
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients")
                        .font(.title2.bold())
                    
                    ForEach(currentRecipe.ingredients, id: \.self) { ingredient in
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            
                            Text(ingredient)
                        }
                    }
                }
                
                Divider()
                
                // Instructions section.
                VStack(alignment: .leading, spacing: 12) {
                    Text("Instructions")
                        .font(.title2.bold())
                    
                    Text(currentRecipe.instructions)
                        .lineSpacing(5)
                }
            }
            .padding()
        }
        .navigationTitle(currentRecipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            // Favourite button placed in the navigation toolbar.
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.toggleFavorite(for: currentRecipe)
                } label: {
                    Image(
                        systemName: currentRecipe.isFavorite
                            ? "heart.fill"
                            : "heart"
                    )
                }
                .tint(.red)
                .accessibilityLabel(
                    currentRecipe.isFavorite
                        ? "Remove from favourites"
                        : "Add to favourites"
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(
            viewModel: RecipeViewModel(),
            recipe: Recipe.sampleRecipes[0]
        )
    }
}
