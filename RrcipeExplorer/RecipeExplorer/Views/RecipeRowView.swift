//
//  RecipeRowView.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

import SwiftUI

// RecipeRowView displays one recipe inside the List.
struct RecipeRowView: View {
    
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 14) {
            
            // Recipe icon.
            Image(systemName: recipe.symbolName)
                .font(.title2)
                .foregroundStyle(.green)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(.green.opacity(0.12))
                )
                .accessibilityHidden(true)
            
            // Recipe name and supporting information.
            VStack(alignment: .leading, spacing: 5) {
                
                HStack {
                    Text(recipe.name)
                        .font(.headline)
                    
                    if recipe.isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .accessibilityLabel("Favourite recipe")
                    }
                }
                
                Text(recipe.category.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Label(
                    "\(recipe.preparationTime) minutes",
                    systemImage: "clock"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
                .accessibilityHidden(true)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    List {
        RecipeRowView(
            recipe: Recipe.sampleRecipes[0]
        )
    }
}
