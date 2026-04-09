# Tetris Flutter

A classic Tetris game built with Flutter following SOLID principles and DRY methodology.

## Features

- 🎮 Classic Tetris gameplay
- 📱 Touch controls (swipe to move, tap to rotate, swipe down for fast drop)
- 🎯 On-screen buttons for precise controls
- 📊 Score tracking and level progression
- 🎨 Color-coded tetrominoes
- ⏸️ Pause/Resume functionality
- 🔄 Next piece preview
- 📈 Increasing difficulty per level
- 🤖 Automated APK builds via GitHub Actions

## Architecture

### Project Structure

```
lib/
├── controllers/          # BLoC pattern for state management
│   ├── game_bloc.dart    # Main game logic
│   ├── game_events.dart  # Game events
│   └── game_state.dart   # Game state
├── models/              # Game models
│   ├── board.dart       # Game board logic
│   └── tetromino.dart   # Tetromino pieces
├── utils/               # Utilities and constants
│   └── constants.dart   # Game constants
├── views/               # Screen layouts
│   ├── game_screen.dart # Main game screen
│   └── menu_screen.dart # Menu screen
├── widgets/             # Reusable UI components
│   ├── game_board.dart  # Game board rendering
│   ├── game_controls.dart # Control buttons
│   ├── next_piece_preview.dart # Next piece display
│   └── score_display.dart # Score display
└── main.dart           # App entry point
```

### State Management

Uses **BLoC (Business Logic Component)** pattern with `flutter_bloc` package:
- **Events**: `GameStarted`, `GamePaused`, `TetrominoMoved`, `TetrominoRotated`, `TetrominoDropped`, etc.
- **State**: Immutable `GameState` with score, level, lines, board, and current/next tetrominoes

### Game Logic

- **Collision Detection**: Validates positions before moves/rotations
- **Wall Kicks**: Attempts to adjust position if rotation hits wall
- **Line Clearing**: Detects and clears completed lines
- **Scoring**: Classic scoring system (single=100, double=300, triple=500, tetris=800) × level
- **Level Progression**: Every 10 lines clears increases level and speed

## Getting Started

### Prerequisites

- Flutter SDK (3.19.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android/iOS development setup

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd tetris_flutter

# Get dependencies
flutter pub get

# Run the app
flutter run
```

### Building APK

```bash
flutter build apk --release
```

The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`

## Controls

### Touch Gestures
- **Swipe Left/Right**: Move piece horizontally
- **Tap**: Rotate piece
- **Swipe Down**: Fast drop

### On-Screen Buttons
- **← →**: Move left/right
- **↻**: Rotate
- **↓**: Drop immediately
- **⏸**: Pause/Resume game

## CI/CD

This project uses GitHub Actions to automatically build the APK:

1. On every push/PR to main branches
2. On version tags (creates a release)

### Creating a Release

```bash
# Tag a version
git tag v1.0.0
git push origin v1.0.0
```

The workflow will automatically:
- Set up Flutter environment
- Install dependencies
- Run analysis and tests
- Build release APK
- Create a GitHub Release with the APK artifact

## Scoring System

| Lines Cleared | Base Score |
|---------------|------------|
| 1             | 100        |
| 2             | 300        |
| 3             | 500        |
| 4 (Tetris)    | 800        |

Final score = Base Score × Current Level

## Tetromino Colors

| Piece | Color    |
|-------|----------|
| I     | Cyan     |
| O     | Yellow   |
| T     | Purple   |
| S     | Green    |
| Z     | Red      |
| J     | Blue     |
| L     | Orange   |

## Dependencies

- **flutter_bloc**: ^8.1.3 - State management
- **equatable**: ^2.0.5 - Value equality for models

## Development in Termux

This project is designed to be developed in Termux environment:
- No need for `flutter doctor` or diagnostic tools
- Use `vim` or `nano` for editing
- GitHub Actions handles APK compilation
- Minimal local tooling required

## License

MIT License

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request
