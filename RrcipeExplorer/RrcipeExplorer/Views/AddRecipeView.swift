//
//  AddRecipeView.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

import SwiftUI

// AddRecipeView is displayed as a modal sheet.
// It allows the user to enter a new recipe.
struct AddRecipeView: View {
    
    @ObservedObject var viewModel: RecipeViewModel
    
    // dismiss closes the current sheet.
    @Environment(\.dismiss) private var dismiss
    
    // Form input values.
    @State private var name = ""
    @State private var selectedCategory: RecipeCategory = .breakfast
    @State private var ingredientsText = ""
    @State private var instructions = ""
    @State private var preparationTime = 15
    
    // Controls the validation alert.
    @State private var showValidationAlert = false
    
    // The "All" category should not be used when creating
    // a recipe, so it is removed from the available choices.
    private var availableCategories: [RecipeCategory] {
        RecipeCategory.allCases.filter { $0 != .all }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Basic Information") {
                    TextField("Recipe name", text: $name)
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(availableCategories) { category in
                            Label(
                                category.rawValue,
                                systemImage: category.iconName
                            )
                            .tag(category)
                        }
                    }
                    
                    Stepper(
                        "Preparation time: \(preparationTime) minutes",
                        value: $preparationTime,
                        in: 5...180,
                        step: 5
                    )
                }
                
                Section {
                    TextEditor(text: $ingredientsText)
                        .frame(minHeight: 120)
                } header: {
                    Text("Ingredients")
                } footer: {
                    Text("Enter one ingredient on each line.")
                }
                
                Section("Instructions") {
                    TextEditor(text: $instructions)
                        .frame(minHeight: 160)
                }
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
                    .fontWeight(.semibold)
                }
            }
            .alert(
                "Missing Information",
                isPresented: $showValidationAlert
            ) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(
                    "Please enter the recipe name, at least one ingredient and the instructions."
                )
            }
        }
    }
    
    // Validates the form and creates the recipe.
    private func saveRecipe() {
        
        let cleanedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        let cleanedInstructions = instructions.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        // Convert multiline ingredient text into an array.
        let ingredients = ingredientsText
            .components(separatedBy: .newlines)
            .map {
                $0.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .filter {
                !$0.isEmpty
            }
        
        guard
            !cleanedName.isEmpty,
            !ingredients.isEmpty,
            !cleanedInstructions.isEmpty
        else {
            showValidationAlert = true
            return
        }
        
        let newRecipe = Recipe(
            name: cleanedName,
            category: selectedCategory,
            ingredients: ingredients,
            instructions: cleanedInstructions,
            preparationTime: preparationTime,
            symbolName: selectedCategory.iconName
        )
        
        viewModel.addRecipe(newRecipe)
        
        // Close the sheet after successfully saving.
        dismiss()
    }
}

#Preview {
    AddRecipeView(
        viewModel: RecipeViewModel()
    )
}
