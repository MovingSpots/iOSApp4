//
//  RecipeDetailView.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

//
//  RecipeDetailView.swift
//  RecipeExplorer
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    @ObservedObject var viewModel: RecipeViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                recipeHeader
                recipeInformation
                ingredientsSection
                instructionsSection
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.toggleFavorite(recipe)
                } label: {
                    Image(
                        systemName: viewModel.isFavorite(recipe)
                            ? "heart.fill"
                            : "heart"
                    )
                }
                .foregroundStyle(
                    viewModel.isFavorite(recipe)
                        ? .red
                        : .primary
                )
                .accessibilityLabel(
                    viewModel.isFavorite(recipe)
                        ? "Remove from favourites"
                        : "Add to favourites"
                )

                // Feature 6: System sharing.
                ShareLink(
                    item: recipe.shareText,
                    subject: Text(recipe.name)
                ) {
                    Image(systemName: "square.and.arrow.up")
                }
                .accessibilityLabel("Share recipe")
            }
        }
    }

    private var recipeHeader: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.orange.opacity(0.15))

            Image(systemName: recipe.symbolName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
                .padding(65)
        }
        .frame(height: 250)
    }

    private var recipeInformation: some View {
        HStack {
            Label(
                "\(recipe.cookingTime) minutes",
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
        .foregroundStyle(.secondary)
    }

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredients")
                .font(.title2.bold())

            ForEach(recipe.ingredients, id: \.self) { ingredient in
                Label(
                    ingredient,
                    systemImage: "checkmark.circle.fill"
                )
                .foregroundStyle(.primary, .green)
            }
        }
    }

    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Instructions")
                .font(.title2.bold())

            ForEach(
                Array(recipe.instructions.enumerated()),
                id: \.offset
            ) { index, instruction in
                HStack(alignment: .top, spacing: 12) {
                    Text("\(index + 1)")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 30, height: 30)
                        .background(.orange)
                        .clipShape(Circle())

                    Text(instruction)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                }
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecipeDetailView(
                recipe: SampleRecipes.all[0],
                viewModel: RecipeViewModel()
            )
        }
    }
}
