# AI Usage and Reflection — Assignment 8

## 1. How Did You Use AI in This Assignment?

I used AI mainly as a learning assistant and coding reference while extending my RecipeXplorer application. AI helped me divide the assignment into smaller features, suggested SwiftUI patterns, explained unfamiliar code, and helped identify possible compiler errors. I did not simply accept everything without checking it. I compared the suggestions with my existing Assignment 7 code and adapted names, models, and views to fit my project.

One prompt I used was: “Show me how to filter a SwiftUI recipe array by search text and category, and then sort the filtered results.” The response helped me understand that filtering and sorting could be placed in one computed property instead of changing the original recipe array. I changed the sample suggestion so it searched the recipe name, category, and ingredients used by my own `Recipe` model.

Another example was persistent favourites. AI first suggested storing an array directly with `@AppStorage`, but `@AppStorage` does not directly store an array of UUID values. I used the simpler approach of storing recipe ID strings as one comma-separated `String`, and added helper methods to read, add, and remove IDs.

Some concepts, especially `ShareLink`, `LazyVGrid`, and creating an empty-results state, had not been used much in my earlier class work. I studied the explanations, used Xcode autocomplete and Quick Help, checked the required iOS version, and tested each feature separately in the simulator before combining them.

## 2. How Did You Understand, Verify, and Adapt the Code?

I verified the code by building frequently with **Command-B** and running it in an iPhone simulator with **Command-R**. I tested one feature at a time rather than adding all six features at once. I also traced the `displayedRecipes` computed property using different combinations of search text, category, and sort selection to make sure the original recipe data was not accidentally changed.

I tested favourites by selecting a heart, stopping the app, launching it again, and confirming that the selection remained. I tested the empty state by entering a search word that matched no recipe. I tested sharing by opening a recipe detail and checking that the iOS share sheet appeared.

One important improvement I made was to use a stable recipe `id` for favourites instead of a recipe’s array position. Array positions can change after sorting, but stable IDs continue to identify the correct recipe. I also added an “All” category and an empty-results view, because filtering without feedback could make the user think the application had stopped working.

I adapted the visual design by making `RecipeCardView` reusable in both list and grid layouts. This reduced duplicate code and made future design changes easier. I also added accessibility labels to icon-only buttons so VoiceOver users can understand their purpose.

## 3. What Did You Learn or Get Better At Through This Work?

I improved my understanding of how SwiftUI state controls the user interface. I now understand more clearly that `@State` stores temporary screen choices, such as the selected category and layout, while `@AppStorage` is useful when a small value must remain after the application closes.

I also became more comfortable combining multiple operations in a computed property. The displayed recipes are produced by applying search, category filtering, and sorting in a clear order. This helped me understand how conditionals, collection methods such as `filter` and `sorted`, and SwiftUI views work together.

What went well was implementing and testing the features in small steps. Reusable views also kept the code easier to read. The more difficult part was adapting generated examples to the exact properties in my own `Recipe` model and handling persistence correctly. Some suggestions produced errors when a property name or iOS version did not match my project. Reading the error message, checking the target version, and testing each change helped me solve those problems. Overall, I became more confident in debugging, reading Swift code, and deciding when an AI suggestion needs to be changed rather than copied.

