# CleanSnap AI

A powerful Flutter application for cleaning up your device storage by identifying and removing duplicate photos, blurry images, large videos, and other junk files.

## Features

✨ **Key Features:**
- 🔍 **Smart Duplicate Detection** - Finds and removes duplicate photos
- 📸 **AI-Powered Blur Detection** - Identifies blurry and low-quality images
- 📹 **Large File Manager** - Find and manage large video files
- 📋 **Screenshot Cleanup** - Remove accumulated screenshots
- 💾 **Free Up Storage** - Reclaim GB of space in minutes
- ⚡ **Fast Scanning** - Quick analysis of your entire photo library
- ✓ **Selective Deletion** - Choose what to delete with checkboxes
- 📊 **Detailed Reports** - See exactly what will be removed

## Getting Started

### Prerequisites
- Flutter SDK (>=2.19.0)
- Dart (>=2.19.0)
- Android SDK or Xcode for iOS

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/DivMitra/literate-carnival.git
   cd cleansnap_ai
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
cleansnap_ai/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── screens/
│   │   ├── home_screen.dart      # Main home screen with scan button
│   │   ├── results_screen.dart   # Results and cleanup selection
│   │   └── settings_screen.dart  # Settings page
│   ├── models/
│   │   └── file_model.dart       # FileItem data model
│   └── utils/
│       └── constants.dart        # App constants and colors
├── pubspec.yaml                  # Dependencies
└── README.md                     # This file
```

## How It Works

1. **Scan** - Tap "Start Scan" to analyze your device
2. **Review** - See all detected junk files organized by type
3. **Select** - Choose which items to delete (all selected by default)
4. **Clean** - Tap "Clean Selected Files" to remove them
5. **Done** - Enjoy your freed-up storage!

## Usage

### Home Screen
- View app features and benefits
- Start a new scan
- See scanning progress

### Results Screen
- View scan results in detail
- Select/deselect items to clean
- Select All / Deselect All buttons
- Confirm and execute cleanup

### Settings Screen (Coming Soon)
- Enable/disable notifications
- Auto-clean scheduling
- Privacy and terms

## Future Enhancements

- [ ] Real file system integration
- [ ] Machine learning for improved detection
- [ ] Background auto-cleaning
- [ ] Cloud backup before deletion
- [ ] Weekly cleanup reports
- [ ] Similar photos detection
- [ ] Old file detection
- [ ] Cache cleaning

## Technologies Used

- **Flutter** - UI Framework
- **Dart** - Programming Language
- **Material Design 3** - UI Design System

## Permissions Required

- Read external storage (for Android)
- Photo library access (for iOS)
- Storage management (for Android)

## Contributing

Contributions are welcome! Please feel free to submit pull requests.

## License

MIT License - feel free to use this project for personal or commercial purposes.

## Support

For issues or questions, please open an issue on GitHub.

---

**Made with ❤️ by DivMitra**
