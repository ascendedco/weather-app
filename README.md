# Flutter Weather App
App demonstrating clean code principles in Flutter. The app uses a user's current location to fetch current weather, 
and a 5-day forecast for said location.

## Conventions
Standard Flutter / Dart conventions followed. Adherence to recommended Flutter / Dart conventions achieved by an IDE 
linting plugin.

## Architecture
A simplified form of Clean Architecture was used to build the application. The primary simplification made was to reduce 
the number of models required per layer. Conventional Clean Architecture advice is to have a model per layer (domain, 
data, presentation). 

In this implementation however, the main application business models are limited to the domain and repository (data) 
layers. This choice was made to reduce the amount of mapping required at each architectural boundary. This in turn 
reduces scope of potential errors, and results in a more maintainable codebase.

The application makes use of Dependency Inversion wherever plugins / third-party libraries are used. This safeguards
the application against changes in the underlying implementation of these libraries.

One more interesting approach in this application's architecture is to represent state management as an interface, and
to keep locus of control within the use case (domain) layer. This goes against conventional Flutter advice, which is 
to use a state management library (such as BLoC) to orchestrate business logic AND manage state. This choice enables
us to swap out our chosen state management library (Provider) for any other library, or even a custom implementation.

## General Considerations

### Error Handling
The application could have a much better error handling strategy. Currently, the app will simply display a snackbar 
should an exception be encountered. This is not ideal, as the user is not given any indication of what went wrong, or
how to fix it. A better approach would be to have error classes with user-friendly messages that both inform the user
and enables them to take some sort of corrective action.

### CI / CD
The application can be built and delivered using a CI / CD tool like GitHub Actions or CodeMagic.

## Libraries Used

The application makes use of the following dependencies:

- http (Dart team http library, used for making REST calls).
- location (Plugin to get current device location and handle related permissions).
- provider (State management library).
- get_it (Dependency injection library).
- intl (Dart team internationalization library, used for date formatting).
- flutter_lints (Flutter team linting library, used to enforce Flutter / Dart conventions).
- test (Dart team testing library, used for unit / widget testing).

## How to Run
Ensure that you have **Flutter 3.13.7** installed on your machine as per the 
[documentation](https://docs.flutter.dev/get-started/install). Clone the repository, and run 
`flutter pub get` to install the required dependencies. You can then run the application on a 
simulator or device by running `flutter run` or your IDE's built-in tooling.

## How to Run Tests
Ensure that you have **Flutter 3.13.7** installed on your machine as per the
[documentation](https://docs.flutter.dev/get-started/install). Clone the repository, and run
`flutter pub get` to install the required dependencies. You can then run the test suite by running 
`flutter test` from the repository root.