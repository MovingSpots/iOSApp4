# iOSApp4 – Recipe Explorer

Recipe Explorer is a progressive SwiftUI prototype created for Assignment 7
of the MWD3A iOS Development course at triOS College.

## App Theme

The application helps users browse, search, filter and manage a collection
of healthy recipes. Users can view recipe details, add new recipes, mark
recipes as favourites and delete recipes.

## Six SwiftUI Features

### 1. NavigationStack and NavigationLink

NavigationStack manages navigation between the recipe list, recipe detail
screen and favourites screen. NavigationLink opens the selected recipe.

### 2. Searchable Interface

The searchable modifier allows users to search recipes by recipe name,
category or ingredient.

### 3. Segmented Picker

A segmented Picker filters recipes into All, Breakfast, Lunch, Dinner
and Snack categories.

### 4. Modal Sheet

The Add Recipe form is presented using the sheet modifier. Users can enter
a recipe name, category, ingredients, preparation time and instructions.

### 5. Swipe Actions

Users can swipe a recipe row to mark it as a favourite or delete it.

### 6. Context Menu

Users can press and hold a recipe row to display favourite and delete
actions in a context menu.

## Additional Features

- ObservableObject ViewModel
- Form validation
- Confirmation alert before deletion
- Favourite recipes screen
- Reusable recipe row component
- Empty search result screen
- SF Symbols
- Accessibility labels
- Xcode previews

## Technology

- Swift
- SwiftUI
- Xcode
- Git
- GitHub

## Project Structure

```text
RecipeExplorer
├── Models
│   ├── Recipe.swift
│   └── RecipeCategory.swift
├── ViewModels
│   └── RecipeViewModel.swift
├── Views
│   ├── ContentView.swift
│   ├── RecipeRowView.swift
│   ├── RecipeDetailView.swift
│   ├── AddRecipeView.swift
│   └── FavoritesView.swift
└── RecipeExplorerApp.swift
