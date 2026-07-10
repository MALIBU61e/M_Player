import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'config/theme.dart';
import 'providers/music_provider.dart';
import 'screens/home_screen.dart';
import 'services/audio_service.dart';
import 'services/permission_service.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  getIt.registerSingleton<AudioService>(AudioService());
  getIt.registerSingleton<PermissionService>(PermissionService());
  
  // Request permissions
  await getIt<PermissionService>().requestPermissions();
  
  runApp(const MPlayer());
}

class MPlayer extends StatelessWidget {
  const MPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MusicProvider(getIt<AudioService>()),
        ),
      ],
      child: MaterialApp(
        title: 'M.Player',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
