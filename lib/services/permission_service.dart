import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PermissionService {
  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      return await _requestAndroidPermissions();
    } else if (Platform.isIOS) {
      return await _requestIOSPermissions();
    }
    return true;
  }

  Future<bool> _requestAndroidPermissions() async {
    final permissions = [
      Permission.storage,
      Permission.mediaLibrary,
    ];

    final statuses = await permissions.request();

    return statuses[Permission.storage]?.isGranted ?? false ||
        statuses[Permission.mediaLibrary]?.isGranted ?? false;
  }

  Future<bool> _requestIOSPermissions() async {
    final permission = Permission.mediaLibrary;
    final status = await permission.request();
    return status.isGranted;
  }

  Future<bool> hasStoragePermission() async {
    if (Platform.isAndroid) {
      final storageStatus = await Permission.storage.status;
      final mediaStatus = await Permission.mediaLibrary.status;
      return storageStatus.isGranted || mediaStatus.isGranted;
    } else if (Platform.isIOS) {
      final mediaStatus = await Permission.mediaLibrary.status;
      return mediaStatus.isGranted;
    }
    return true;
  }
}
