//
//  RecipeCardView.swift
//  RecipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-20.
//

//
//  RecipeCardView.swift
//  RecipeExplorer
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    let isFavorite: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(.orange.opacity(0.15))

                Image(systemName: recipe.symbolName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.orange)
                    .padding(35)
            }
            .frame(height: 135)

            HStack(alignment: .top) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Spacer(minLength: 4)

                if isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .accessibilityLabel("Favourite")
                }
            }

            Text(recipe.category.rawValue)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Label(
                    "\(recipe.cookingTime) min",
                    systemImage: "clock"
                )

                Spacer()

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
        .padding(10)
        .background(
            .thinMaterial,
            in: RoundedRectangle(cornerRadius: 16)
        )
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(
            recipe: SampleRecipes.all[0],
            isFavorite: true
        )
        .frame(width: 190)
        .padding()
    }
}
