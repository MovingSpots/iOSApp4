# RecipeXplorer — iOSApp4

RecipeXplorer is a SwiftUI recipe-browsing application created for the MWD3A iOS Development course. It began as a progressive prototype in Assignment 7 and was expanded in Assignment 8 with six additional SwiftUI features.

## Assignment 8 — Six New Features

1. **Searchable recipe collection** — A searchable modifier filters recipes by name, category, and ingredients as the user types.
2. **Category filtering** — A horizontally scrolling set of category buttons lets the user display all recipes or one category.
3. **Recipe sorting** — A toolbar menu sorts the visible recipes alphabetically, by cooking time, or by rating.
4. **Persistent favourites** — Users can add or remove favourites. Favourite recipe IDs are saved with `@AppStorage`, so they remain available after the app restarts.
5. **List and grid layouts** — A toolbar button switches between `List` and `LazyVGrid`, with animation to make the change easier to follow.
6. **System sharing** — `ShareLink` opens the iOS share sheet so a recipe summary can be shared through Messages, Mail, Notes, and other supported apps.

## SwiftUI Concepts Used

* `NavigationStack` and `NavigationLink`
* `List`, `ScrollView`, and `LazyVGrid`
* `searchable(text:prompt:)`
* `Menu` and `Picker`
* `@State`, `@AppStorage`, and computed properties
* A custom empty-results view
* `ShareLink`
* `withAnimation`
* Reusable views and model types

## Requirements

* macOS with Xcode 15 or later
* iOS 16.0 or later deployment target
* Swift 5.9 or later
* No third-party packages are required

## Project Structure

```text
RecipeXplorer/
├── RecipeXplorerApp.swift
├── Models/
│   └── Recipe.swift
├── Data/
│   └── SampleRecipes.swift
├── Views/
│   ├── ContentView.swift
│   ├── RecipeCardView.swift
│   └── RecipeDetailView.swift
└── Assets.xcassets/
AIReflection.md
README.md
```

## Running the App

1. Clone the repository.
2. Open `RecipeXplorer.xcodeproj` in Xcode.
3. Select an iPhone simulator, such as iPhone 16.
4. Press **Command-B** to build.
5. Press **Command-R** to run.
6. Test searching, category filters, each sort order, favourites after relaunching, list/grid switching, and sharing.

## Testing Completed

* Confirmed the project builds without errors.
* Confirmed search is case-insensitive and searches ingredients.
* Confirmed category filters and sorting work together.
* Confirmed the empty-results message appears when no recipe matches.
* Confirmed favourites remain selected after closing and reopening the app.
* Confirmed both list and grid layouts navigate to recipe details.
* Confirmed `ShareLink` opens the simulator share sheet.

## Author

Selvaraj Thyagarajan
MWD3A — iOS Development, Assignment 8


