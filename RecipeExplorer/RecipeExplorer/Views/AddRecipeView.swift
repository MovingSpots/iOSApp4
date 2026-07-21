//
//  AddRecipeView.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

//
//  AddRecipeView.swift
//  RecipeExplorer
//

import SwiftUI

struct AddRecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var category: RecipeCategory = .breakfast
    @State private var cookingTime = 15
    @State private var rating = 4.0
    @State private var ingredientsText = ""
    @State private var instructionsText = ""
    @State private var symbolName = "fork.knife"

    private var formIsValid: Bool {
        !name.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty &&
        !ingredientsText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty &&
        !instructionsText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                recipeInformationSection
                ingredientsSection
                instructionsSection
                symbolSection
            }
            .navigationTitle("Add Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveRecipe()
                    }
                    .disabled(!formIsValid)
                }
            }
        }
    }

    private var recipeInformationSection: some View {
        Section("Recipe Information") {
            TextField("Recipe name", text: $name)

            Picker("Category", selection: $category) {
                ForEach(
                    RecipeCategory.allCases.filter {
                        $0 != .all
                    }
                ) { categoryOption in
                    Text(categoryOption.rawValue)
                        .tag(categoryOption)
                }
            }

            Stepper(
                "Cooking time: \(cookingTime) minutes",
                value: $cookingTime,
                in: 5...240,
                step: 5
            )

            VStack(alignment: .leading) {
                Text(
                    "Rating: \(rating.formatted(.number.precision(.fractionLength(1))))"
                )

                Slider(
                    value: $rating,
                    in: 1...5,
                    step: 0.5
                )
            }
        }
    }

    private var ingredientsSection: some View {
        Section {
            TextEditor(text: $ingredientsText)
                .frame(minHeight: 110)
        } header: {
            Text("Ingredients")
        } footer: {
            Text("Enter one ingredient on each line.")
        }
    }

    private var instructionsSection: some View {
        Section {
            TextEditor(text: $instructionsText)
                .frame(minHeight: 130)
        } header: {
            Text("Instructions")
        } footer: {
            Text("Enter one instruction on each line.")
        }
    }

    private var symbolSection: some View {
        Section {
            TextField("SF Symbol name", text: $symbolName)

            HStack {
                Text("Preview")

                Spacer()

                Image(
                    systemName: symbolName.isEmpty
                        ? "fork.knife"
                        : symbolName
                )
                .font(.title)
                .foregroundStyle(.orange)
            }
        } header: {
            Text("Recipe Symbol")
        } footer: {
            Text(
                "Examples: fork.knife, leaf.fill, cup.and.saucer.fill"
            )
        }
    }

    private func saveRecipe() {
        let ingredients = ingredientsText
            .components(separatedBy: .newlines)
            .map {
                $0.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
            }
            .filter { !$0.isEmpty }

        let instructions = instructionsText
            .components(separatedBy: .newlines)
            .map {
                $0.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
            }
            .filter { !$0.isEmpty }

        let cleanedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanedSymbol = symbolName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let newRecipe = Recipe(
            id: UUID(),
            name: cleanedName,
            category: category,
            cookingTime: cookingTime,
            rating: rating,
            ingredients: ingredients,
            instructions: instructions,
            symbolName: cleanedSymbol.isEmpty
                ? "fork.knife"
                : cleanedSymbol
        )

        viewModel.addRecipe(newRecipe)
        dismiss()
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(viewModel: RecipeViewModel())
    }
}
