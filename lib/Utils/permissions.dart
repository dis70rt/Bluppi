import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

Future<bool> requestNotificationPermissionOnce() async {
  try {
    final status = await Permission.notification.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      return false;
    }

    final result = await Permission.notification.request();

    if (result.isDenied) {
      return false;
    } else if (result.isPermanentlyDenied) {
      return false;
    }

    return result.isGranted;
  } catch (e) {
    log('Error requesting notification permission: $e');
    return false;
  }
}

Future<bool> checkAndRequestAllPermissions(BuildContext context) async {
  try {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
    ].request();
    
    bool allGranted = true;
    
    statuses.forEach((permission, status) {
      if (!status.isGranted) {
        allGranted = false;
      }
    });
    
    if (!allGranted && context.mounted) {
      // Show dialog informing user about missing permissions
      showPermissionDialog(context);
    }
    
    return allGranted;
  } catch (e) {
    log('Error requesting permissions: $e');
    return false;
  }
}

void showPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Permissions Required'),
      content: const Text(
          'This app requires certain permissions to function properly. '
          'Please grant the permissions in the app settings.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            openAppSettings();
          },
          child: const Text('Open Settings'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}