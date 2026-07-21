//
//  ContentView.swift
//  RrcipeExplorer
//
//  Created by SELVARAJ THYAGARAJAN on 2026-07-13.
//

//
//  ContentView.swift
//  RecipeExplorer
//

import SwiftUI

struct ContentView: View {
    // Creates and owns the single main ViewModel instance.
    @StateObject private var viewModel = RecipeViewModel()

    @State private var layout: RecipeLayout = .list
    @State private var showingAddRecipe = false

    private let gridColumns = [
        GridItem(
            .adaptive(minimum: 160),
            spacing: 12
        )
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                categorySelector

                if viewModel.displayedRecipes.isEmpty {
                    emptyResultsView
                } else {
                    recipeCollection
                }
            }
            .navigationTitle("RecipeExplorer")
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search recipes or ingredients"
            )
            .toolbar {
                leadingToolbarItems
                trailingToolbarItems
            }
            .sheet(isPresented: $showingAddRecipe) {
                AddRecipeView(viewModel: viewModel)
            }
        }
    }

    // Feature 2: Category filtering.
    private var categorySelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(RecipeCategory.allCases) { category in
                    Button {
                        withAnimation {
                            viewModel.selectedCategory = category
                        }
                    } label: {
                        Text(category.rawValue)
                            .font(.subheadline.weight(.semibold))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .foregroundStyle(
                                viewModel.selectedCategory == category
                                    ? .white
                                    : .primary
                            )
                            .background(
                                viewModel.selectedCategory == category
                                    ? Color.orange
                                    : Color.secondary.opacity(0.15)
                            )
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }

    @ViewBuilder
    private var recipeCollection: some View {
        // Feature 5: List and grid layouts.
        if layout == .list {
            recipeList
        } else {
            recipeGrid
        }
    }

    private var recipeList: some View {
        List(viewModel.displayedRecipes) { recipe in
            recipeNavigationLink(recipe)
        }
        .listStyle(.plain)
    }

    private var recipeGrid: some View {
        ScrollView {
            LazyVGrid(
                columns: gridColumns,
                spacing: 12
            ) {
                ForEach(viewModel.displayedRecipes) { recipe in
                    recipeGridNavigationLink(recipe)
                }
            }
            .padding()
        }
    }

    private func recipeNavigationLink(
        _ recipe: Recipe
    ) -> some View {
        NavigationLink {
            RecipeDetailView(
                recipe: recipe,
                viewModel: viewModel
            )
        } label: {
            RecipeRowView(
                recipe: recipe,
                isFavorite: viewModel.isFavorite(recipe)
            )
        }
    }

    private func recipeGridNavigationLink(
        _ recipe: Recipe
    ) -> some View {
        NavigationLink {
            RecipeDetailView(
                recipe: recipe,
                viewModel: viewModel
            )
        } label: {
            RecipeCardView(
                recipe: recipe,
                isFavorite: viewModel.isFavorite(recipe)
            )
        }
        .buttonStyle(.plain)
    }

    private var emptyResultsView: some View {
        VStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundStyle(.secondary)

            Text("No Recipes Found")
                .font(.title2.bold())

            Text("Try another search word or category.")
                .foregroundStyle(.secondary)

            Button("Reset Filters") {
                viewModel.resetFilters()
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ToolbarContentBuilder
    private var leadingToolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            NavigationLink {
                FavoritesView(viewModel: viewModel)
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")

                    if viewModel.favoriteCount > 0 {
                        Text("\(viewModel.favoriteCount)")
                    }
                }
            }
            .accessibilityLabel("Open favourites")
        }
    }

    @ToolbarContentBuilder
    private var trailingToolbarItems: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            // Feature 3: Sorting menu.
            Menu {
                Picker(
                    "Sort Recipes",
                    selection: $viewModel.selectedSortOption
                ) {
                    ForEach(RecipeSortOption.allCases) { option in
                        Text(option.rawValue)
                            .tag(option)
                    }
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down")
            }
            .accessibilityLabel("Sort recipes")

            // Feature 5: Layout switch.
            Button {
                withAnimation(.easeInOut) {
                    layout = layout == .list
                        ? .grid
                        : .list
                }
            } label: {
                Image(
                    systemName: layout == .list
                        ? "square.grid.2x2"
                        : "list.bullet"
                )
            }
            .accessibilityLabel(
                layout == .list
                    ? "Show grid"
                    : "Show list"
            )

            Button {
                showingAddRecipe = true
            } label: {
                Image(systemName: "plus")
            }
            .accessibilityLabel("Add recipe")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
