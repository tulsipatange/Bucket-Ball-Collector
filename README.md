# Exercise 3: Bucket Ball Collector Game
## Project Overview

This document provides a comprehensive guide to configuring and running the Bucket Ball Colletor game, a beginner-friendly Flutter game.

## Code Structure
```bash
Bucket-Ball-Collector/
│
├── main.dart                    # App entry point
├── models/
│   ├── ball.dart                # Ball data model
│   └── game_state.dart          # Game state management
├── services/
│   └── game_logic.dart          # Core game logic
├── widgets/
│   ├── game_ui.dart             # UI components
│   ├── game_objects.dart        # Game visual elements
│   └── dialog_helper.dart       # Dialog utilities
├── constants/
│   └── game_constants.dart      # Configuration constants
└── screens/
│   └── game_screen.dart         # Main game screen
├── pubspec.yaml                 # Flutter dependencies
└── README.md                    # Project documentation
```
The project follows a simplified structure with all code contained in thier own namespace for easy readability.

Follow the steps below to clone and run the app locally.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>= 3.x.x)
- [Git](https://git-scm.com/)
- A code editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)
- Xcode (for macOS/iOS builds)
- Android SDK (bundled with Android Studio)

To verify Flutter is installed:

```bash
flutter doctor
```

### Setup Instructions

1. Clone the Repository

```bash
git clone https://github.com/tulsipatange/Bucket-Ball-Collector.git
cd Bucket-Ball-Collector
```

2. Install Dependencies

```bash
flutter pub get
```

### Run the App

#### Run on Android

Make sure an emulator is running or a device is connected.

```bash
flutter run
```

#### Run on iOS (Requires macOS with Xcode installed.)

Make sure an iOS emulator is running or a iOS device is connected.

```bash
flutter run -d ios
```

#### Run on Web

```bash
flutter run -d web
```
### Build release apk
```bash
flutter build apk --release
```
