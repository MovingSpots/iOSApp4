//
//  ContentView.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

import SwiftUI

struct ContentView: View {
    
    // StateObject creates and owns one ViewModel instance
    // for the lifetime of this screen.
    @StateObject private var viewModel = RecipeViewModel()
    
    // Controls whether the Add Recipe sheet is visible.
    @State private var showAddRecipeSheet = false
    
    // Stores the recipe that the user selected for deletion.
    @State private var recipePendingDeletion: Recipe?
    
    // Controls the delete confirmation alert.
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // FEATURE 3:
                // Segmented Picker used to filter categories.
                categoryPicker
                
                // Display either an empty state or the recipe List.
                if viewModel.filteredRecipes.isEmpty {
                    emptyResultsView
                } else {
                    recipeList
                }
            }
            .navigationTitle("Recipe Explorer")
            
            // FEATURE 2:
            // Search bar connected to searchText in the ViewModel.
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search recipes or ingredients"
            )
            
            .toolbar {
                
                // Navigate to the favourites screen.
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        FavoritesView(viewModel: viewModel)
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    .tint(.red)
                    .accessibilityLabel("View favourite recipes")
                }
                
                // Open the Add Recipe sheet.
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddRecipeSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add a new recipe")
                }
            }
            
            // FEATURE 4:
            // Display AddRecipeView as a modal sheet.
            .sheet(isPresented: $showAddRecipeSheet) {
                AddRecipeView(viewModel: viewModel)
            }
            
            // Ask for confirmation before deleting a recipe.
            .alert(
                "Delete Recipe?",
                isPresented: $showDeleteConfirmation,
                presenting: recipePendingDeletion
            ) { recipe in
                
                Button("Cancel", role: .cancel) {
                    recipePendingDeletion = nil
                }
                
                Button("Delete", role: .destructive) {
                    viewModel.deleteRecipe(recipe)
                    recipePendingDeletion = nil
                }
                
            } message: { recipe in
                Text(
                    "Are you sure you want to delete \(recipe.name)?"
                )
            }
        }
    }
    
    // MARK: - Category Picker
    
    private var categoryPicker: some View {
        Picker(
            "Recipe Category",
            selection: $viewModel.selectedCategory
        ) {
            ForEach(RecipeCategory.allCases) { category in
                Text(category.rawValue)
                    .tag(category)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    // MARK: - Recipe List
    
    private var recipeList: some View {
        List {
            ForEach(viewModel.filteredRecipes) { recipe in
                
                // FEATURE 1:
                // NavigationLink opens RecipeDetailView.
                NavigationLink {
                    RecipeDetailView(
                        viewModel: viewModel,
                        recipe: recipe
                    )
                } label: {
                    RecipeRowView(recipe: recipe)
                }
                
                // FEATURE 5:
                // Swipe from right to left to delete.
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        prepareToDelete(recipe)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                
                // Swipe from left to right to favourite.
                .swipeActions(edge: .leading) {
                    Button {
                        viewModel.toggleFavorite(for: recipe)
                    } label: {
                        Label(
                            recipe.isFavorite
                                ? "Unfavourite"
                                : "Favourite",
                            systemImage: recipe.isFavorite
                                ? "heart.slash"
                                : "heart"
                        )
                    }
                    .tint(recipe.isFavorite ? .orange : .pink)
                }
                
                // FEATURE 6:
                // Long-press a recipe to open a context menu.
                .contextMenu {
                    
                    Button {
                        viewModel.toggleFavorite(for: recipe)
                    } label: {
                        Label(
                            recipe.isFavorite
                                ? "Remove from Favourites"
                                : "Add to Favourites",
                            systemImage: recipe.isFavorite
                                ? "heart.slash"
                                : "heart"
                        )
                    }
                    
                    Button(role: .destructive) {
                        prepareToDelete(recipe)
                    } label: {
                        Label("Delete Recipe", systemImage: "trash")
                    }
                }
            }
            
            // This also supports standard List deletion
            // when Edit mode is used.
            .onDelete(perform: viewModel.deleteRecipes)
        }
        .listStyle(.plain)
    }
    
    // MARK: - Empty Search Result
    
    private var emptyResultsView: some View {
        ContentUnavailableView(
            "No Recipes Found",
            systemImage: "magnifyingglass",
            description: Text(
                "Try another search word or select a different category."
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Helper Function
    
    private func prepareToDelete(_ recipe: Recipe) {
        recipePendingDeletion = recipe
        showDeleteConfirmation = true
    }
}

#Preview {
    ContentView()
}
