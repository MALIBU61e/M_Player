# M.Player - Music Player App

A fully functional, beautifully designed Flutter music player application with modern UI, seamless playback control, and complete playlist management. Built with clean architecture principles and ready to deploy on CodeMagic Flutter v2.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-00A8E1?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## 🎵 Features

### Core Playback Features
- ▶️ Full music playback control (play, pause, next, previous)
- 📊 Real-time progress indicator with seek functionality
- 🎼 Complete playlist creation and management
- 🔀 Shuffle and repeat modes
- ⏱️ Duration tracking and time display
- 🎚️ Playback rate control
- 📱 Responsive design for all screen sizes

### UI/UX Features
- 🎨 Beautiful light and dark theme support
- 🌈 Modern Material 3 design
- ✨ Smooth animations and transitions
- 📋 Tab-based navigation (Songs & Playlists)
- 🖼️ Album artwork display with caching
- 📈 Queue/Now Playing screen with reordering

### Advanced Features
- 🔐 Permission handling for storage and media access
- 💾 Persistent state management with Provider
- 🏗️ Clean architecture with separation of concerns
- 🔧 Service locator (GetIt) for dependency injection
- 🌐 Ready for local music file integration
- 📲 Gesture-based player controls

## 📁 Project Structure

```
lib/
├── config/
│   └── theme.dart                 # Material 3 theme configuration
├── models/
│   ├── song.dart                  # Song data model
│   └── playlist.dart              # Playlist data model
├── providers/
│   └── music_provider.dart        # State management with Provider
├── screens/
│   ├── home_screen.dart           # Main screen with tabs
│   ├── player_screen.dart         # Full player UI
│   └── now_playing_screen.dart    # Queue/now playing
├── services/
│   ├── audio_service.dart         # Audio playback engine
│   └── permission_service.dart    # Permission handling
├── utils/
│   ├── constants.dart             # App constants
│   └── extensions.dart            # Dart extensions
├── widgets/
│   ├── player_control_button.dart # Control button widget
│   ├── progress_slider.dart       # Seek slider widget
│   ├── song_tile.dart             # Song list tile
│   └── playlist_tile.dart         # Playlist grid tile
└── main.dart                      # App entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter 3.0 or higher
- Dart 3.0 or higher
- iOS 11.0+ / Android 5.0+ (API 21+)

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/MALIBU61e/M_Player.git
cd M_Player
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Run the app:**
```bash
flutter run
```

## 📦 Dependencies

### Core Dependencies
- **just_audio** (0.9.31) - Audio playback library
- **audio_session** (0.1.16) - Audio session management
- **provider** (6.0.5) - State management
- **get_it** (7.5.0) - Service locator/DI
- **permission_handler** (11.4.3) - Permissions management
- **cached_network_image** (3.2.3) - Image caching
- **intl** (0.18.1) - Internationalization
- **flutter_svg** (2.0.5) - SVG rendering
- **http** (1.1.0) - HTTP requests

See `pubspec.yaml` for all dependencies and versions.

## 🔧 Configuration

### Android Setup

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
```

Update `android/app/build.gradle`:
```gradle
android {
    compileSdk 34
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

### iOS Setup

Add to `ios/Runner/Info.plist`:

```xml
<key>NSAppleMusicUsageDescription</key>
<string>M.Player needs access to your music library to play songs</string>
<key>UIRequiredDeviceCapabilities</key>
<array>
    <string>armv7</string>
</array>
```

Update `ios/Podfile`:
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'PERMISSION_MEDIA_LIBRARY=1',
      ]
    end
  end
end
```

## 📱 Usage Examples

### Load Songs
```dart
final songs = [
  Song(
    id: '1',
    title: 'Summer Vibes',
    artist: 'The Band',
    album: 'Happy Days',
    duration: Duration(minutes: 3, seconds: 45),
  ),
];
context.read<MusicProvider>().loadSongs(songs);
```

### Play a Song
```dart
final provider = context.read<MusicProvider>();
provider.playSong(song);
```

### Create a Playlist
```dart
final playlist = Playlist(
  id: '1',
  name: 'My Favorites',
  songs: songs,
  createdAt: DateTime.now(),
);
context.read<MusicProvider>().addPlaylist(playlist);
```

### Control Playback
```dart
final provider = context.read<MusicProvider>();

// Play/Pause
provider.isPlaying ? provider.pause() : provider.play();

// Next/Previous
provider.next();
provider.previous();

// Seek
provider.seek(Duration(seconds: 30));

// Toggle modes
provider.toggleRepeat();
provider.toggleShuffle();
```

## 🏗️ Architecture

### Clean Architecture Layers

**Presentation Layer:**
- Screens and UI components
- Widgets for reusable UI
- Provider for state management

**Business Logic Layer:**
- MusicProvider (state management)
- Playback logic and queue management

**Data Layer:**
- Models (Song, Playlist)
- Services (AudioService, PermissionService)

### Design Patterns

- **State Management:** Provider pattern with ChangeNotifier
- **Dependency Injection:** GetIt service locator
- **Stream-based Updates:** Listening to audio player streams
- **MVVM:** Model-View-ViewModel pattern for screens

## 🎨 Customization

### Change Theme Colors

Edit `lib/config/theme.dart`:

```dart
static const Color primaryColor = Color(0xFF6C5CE7);
static const Color accentColor = Color(0xFFA29BFE);
```

### Modify Constants

Edit `lib/utils/constants.dart`:

```dart
static const String appName = 'M.Player';
static const double paddingMedium = 16.0;
```

### Add Custom Fonts

1. Place font files in `assets/fonts/`
2. Update `pubspec.yaml` fonts section
3. Use in `AppTheme`

## 🧪 Testing

Run the app in debug mode:
```bash
flutter run -d <device-id>
```

Hot reload during development:
```bash
r - Hot reload
R - Hot restart
q - Quit
```

## 📦 Building for Release

### Android

Build APK:
```bash
flutter build apk --release
flutter build apk --split-per-abi --release
```

Build App Bundle:
```bash
flutter build appbundle --release
```

### iOS

Build IPA:
```bash
flutter build ios --release
```

Create Archive in Xcode:
```bash
open ios/Runner.xcworkspace
```

## 🚀 Deployment on CodeMagic

### 1. Connect Repository
- Sign in to CodeMagic
- Connect your GitHub repository (MALIBU61e/M_Player)
- Select Flutter app type

### 2. Configure Workflow

Create `codemagic.yaml`:

```yaml
workflows:
  default-workflow:
    name: Default Workflow
    instance_type: mac_mini_m2
    max_build_duration: 30
    
    environment:
      flutter: stable
      xcode: 15.0
      
    triggering:
      events:
        - push
      branch:
        - main
        
    scripts:
      - name: Get dependencies
        script: flutter pub get
        
      - name: Run tests
        script: flutter test
        
      - name: Build Android
        script: flutter build apk --release
        
      - name: Build iOS
        script: flutter build ios --release --no-codesign
        
    artifacts:
      - build/app/outputs/**/*.apk
      - build/app/outputs/**/*.aab
      - build/ios/ipa/**/*.ipa
```

### 3. Configure for App Store/Play Store

**For Play Store:**
- Upload keystore file in CodeMagic
- Set keystore credentials
- Enable automatic app signing

**For App Store:**
- Create App ID in Apple Developer
- Set up provisioning profiles
- Enable automatic code signing

### 4. Deploy

- Push changes to main branch
- CodeMagic automatically triggers build
- Monitor build progress in dashboard
- Download artifacts or auto-publish to stores

## 🔐 Security Considerations

- Never hardcode API keys or credentials
- Use environment variables in CodeMagic
- Enable code obfuscation for release builds
- Sign APK and IPA files properly
- Use HTTPS for any network requests

## 🐛 Troubleshooting

### No Audio Playing
- ✅ Check if permissions are granted
- ✅ Verify audio file paths are correct
- ✅ Check device volume is not muted
- ✅ Ensure audio session is configured properly

### UI Not Updating
- ✅ Verify Consumer widgets are used
- ✅ Check that notifyListeners() is called
- ✅ Ensure Provider is correctly set up
- ✅ Check for stream subscription issues

### Permission Denied
- ✅ Check AndroidManifest.xml has permissions
- ✅ Check iOS Info.plist has descriptions
- ✅ Request permissions at runtime
- ✅ Test on real device (emulators have issues)

### Build Errors
- ✅ Run `flutter clean`
- ✅ Run `flutter pub get`
- ✅ Update Flutter: `flutter upgrade`
- ✅ Check Java/Gradle versions for Android

## 📈 Performance Optimization

- **Image Caching:** Using cached_network_image
- **Lazy Loading:** ListView.builder for songs
- **Stream Updates:** Only rebuild on state changes
- **Efficient Layouts:** Custom layouts avoid rebuilds
- **Memory Management:** Proper resource disposal

## 🚦 Future Enhancements

- [ ] Local music file browser and scanner
- [ ] Lyrics display integration
- [ ] Audio visualization
- [ ] Equalizer controls
- [ ] Sleep timer functionality
- [ ] Gapless playback
- [ ] Smart playlists
- [ ] Music search functionality
- [ ] Recently played history
- [ ] Favorites/Liked songs system
- [ ] Now playing notification
- [ ] Lock screen controls
- [ ] Cross-device sync
- [ ] Backup and restore

## 📚 Learning Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Documentation](https://pub.dev/packages/provider)
- [Just Audio Documentation](https://pub.dev/packages/just_audio)
- [Material 3 Design](https://m3.material.io/)
- [CodeMagic Documentation](https://codemagic.io/docs/)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**MALIBU61e**
- GitHub: [@MALIBU61e](https://github.com/MALIBU61e)
- Email: aubreymilinda61@gmail.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- just_audio for excellent audio library
- Provider for state management solution
- Material Design team for beautiful design system

## 📞 Support

For issues, feature requests, or questions:
1. Check existing [Issues](https://github.com/MALIBU61e/M_Player/issues)
2. Create a new issue with detailed description
3. Include device/OS info and error logs

## 📊 Project Statistics

- **Lines of Code:** 3000+
- **Files:** 20+
- **Widgets:** 8 custom widgets
- **Screens:** 3 main screens
- **State Management:** Provider
- **Architecture:** Clean Architecture
- **API Level:** 21+ (Android), 11.0+ (iOS)

---

⭐ If you find this project helpful, please give it a star on GitHub!

Made with ❤️ for music lovers using Flutter • Ready for CodeMagic Deployment
