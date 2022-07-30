<!-- ABOUT THE PROJECT -->
## About The Project

This is a basic Flutter app which display pets available for adoption. This project use Bloc and Cubits for state management.

### Built With

* [Flutter](https://flutter.dev)

### Live Demo

🔗 [Pet Adoption App](https://pet-adoption-44d4a.web.app/#/)


### Setup

1. Clone the github repo
   ```sh
   git clone https://github.com/romit5797/PetAdoption.git
   ```
2. Install packages
   ```sh
   cd flutter pub get
   ```
3. Run the app
   ```sh
   flutter run
    ```

## Features

- Basic state managment using Bloc Pattern
- Search and categorize Pets
- Supports dark theme
- Basic unit and widget test
- View adoption history

## Project structure

```sh
.
├── pubspec.yaml
├── fonts
├── assets
├── android
├── ios
├── lib
│   ├── bloc
│   │   ├── categoryCubit.dart
│   │   ├── paginationCubit.dart
│   │   ├── petCubit.dart
│   │   └── petState.dart
│   ├── data
│   │   └── petData.dart
│   ├── models
│   │   ├── petModel.dart
│   │   └── petModel.g.dart
│   ├── presentation
│   │   ├── details
│   │   │   ├── detailScreen.dart
│   │   │   └── imageScreen.dart
│   │   ├── history
│   │   │   └── historyScreen.dart
│   │   ├── home
│   │   │   ├── homeScreen.dart
│   │   │   └── searchScreen.dart
│   │   ├── ui
│   │   │   └── petView.dart
│   ├── utils
│   │   ├── staticMethods.dart
│   │   └── hiveHandler.dart
│   ├── main.dart
└── └── theme.dart
```




