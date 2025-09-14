# DrillDraw

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0.0+-blue.svg)](https://dart.dev)
[![Status: PoC](https://img.shields.io/badge/Status-Proof%20of%20Concept-orange.svg)](https://github.com/damian-kanak/drilldraw)
[![Platform](https://img.shields.io/badge/Platform-Web%20%7C%20iOS%20%7C%20Android%20%7C%20macOS-lightgrey.svg)](https://flutter.dev)

A Flutter application for interactive diagram creation with drill-down capabilities.

> **Note**: CI/CD badges will be added once GitHub Actions workflows are implemented (see [Issue #79](https://github.com/damian-kanak/drilldraw/issues/79))

## 🚀 Live Demo

**Try it now:** [https://damian-kanak.github.io/drilldraw/](https://damian-kanak.github.io/drilldraw/)

## 📸 Screenshots

*Screenshots will be added once the core features are implemented*

<!-- 
### Canvas View
![Canvas View](docs/screenshots/canvas-view.png)

### Node Creation
![Node Creation](docs/screenshots/node-creation.gif)

### Drill-Down Navigation
![Drill-Down](docs/screenshots/drill-down.gif)
-->

## ✨ Features

- 🎨 **Interactive Canvas** - Tap to place nodes and create connections
- 🔍 **Drill-Down Navigation** - Navigate through hierarchical diagrams
- 🎯 **Node Management** - Create, edit, and delete diagram nodes
- 🔗 **Edge Creation** - Connect nodes with visual edges
- 📱 **Cross-Platform** - Works on iOS, Android, Web, and macOS
- 🎨 **Material Design 3** - Modern, accessible UI
- 🌐 **Web-First** - Optimized for web diagram editing

## Getting Started

### Prerequisites

- Flutter SDK (version 3.9.2 or higher)
- Dart SDK
- A device or emulator to run the app

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/damian-kanak/drilldraw.git
   cd drilldraw
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## 🎮 Usage

### Basic Operations
- **Tap** on the canvas to create new nodes
- **Drag** nodes to reposition them
- **Connect** nodes by dragging from one to another
- **Double-tap** a node to drill down into its details
- **Use gestures** to pan and zoom the canvas

### Navigation
- **Breadcrumbs** show your current location in the hierarchy
- **Back button** returns to the parent level
- **Overview mode** shows the entire diagram structure

*Detailed usage instructions will be added as features are implemented*

## 📁 Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data models and entities
├── views/                    # UI components and screens
├── controllers/              # Business logic and state management
├── services/                 # External services and APIs
└── utils/                    # Utilities and helpers

test/
├── unit/                     # Unit tests
├── widget/                   # Widget tests
└── integration/              # Integration tests

docs/
├── architecture/             # Architecture documentation
└── screenshots/              # Screenshots and demos
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Quick Start for Contributors
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes and add tests
4. Follow our [commit conventions](CONTRIBUTING.md#commit-guidelines)
5. Submit a pull request

### Development Status
- 🚧 **PoC Phase** - Core canvas and drill-down functionality
- 📋 **Milestone 0** - Basic diagram editing capabilities
- 🎯 **Milestone 1** - Full diagram editor (MVP)
- 🔮 **Future** - Mermaid integration, advanced features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Live Demo**: [https://damian-kanak.github.io/drilldraw/](https://damian-kanak.github.io/drilldraw/)
- **Issues**: [GitHub Issues](https://github.com/damian-kanak/drilldraw/issues)
- **Discussions**: [GitHub Discussions](https://github.com/damian-kanak/drilldraw/discussions)
- **Documentation**: [Project Docs](docs/)
