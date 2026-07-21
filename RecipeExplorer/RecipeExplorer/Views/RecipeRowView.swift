//
//  RecipeRowView.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

//
//  RecipeRowView.swift
//  RecipeExplorer
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    let isFavorite: Bool

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(.orange.opacity(0.15))

                Image(systemName: recipe.symbolName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.orange)
                    .padding(18)
            }
            .frame(width: 85, height: 85)

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(recipe.name)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Spacer()

                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .accessibilityLabel("Favourite")
                    }
                }

                Text(recipe.category.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 14) {
                    Label(
                        "\(recipe.cookingTime) min",
                        systemImage: "clock"
                    )

                    Label(
                        recipe.rating.formatted(
                            .number.precision(.fractionLength(1))
                        ),
                        systemImage: "star.fill"
                    )
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 5)
    }
}

struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRowView(
            recipe: SampleRecipes.all[0],
            isFavorite: true
        )
        .padding()
    }
}
