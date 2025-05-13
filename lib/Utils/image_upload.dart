import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHandler {
  Future<File?> compress(imagePath) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    log("Attempting to compress image...");

    final XFile? compressedImage =
        await FlutterImageCompress.compressAndGetFile(imagePath, targetPath,
            quality: 80,
            // minWidth: 500,
            // minHeight: 500,
            format: CompressFormat.jpeg);

    if (compressedImage != null) {
      log("Image compressed successfully. New size: ${File(compressedImage.path).lengthSync()} bytes");
      return File(compressedImage.path);
    } else {
      log("Image compression failed.");
      return null;
    }
  }

  Future<XFile?> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    try {
      final source = await showModalBottomSheet(
          context: context,
          builder: (context) {
            return SafeArea(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Divider(
                    color: Colors.grey.shade800,
                    thickness: 3,
                    endIndent: 100,
                    indent: 100,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Choose from library'),
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('Take Photo'),
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ));
          });

        if (source == null) return null;
        return await picker.pickImage(source: source);

    } catch (e) {
      log("Error picking image: $e");
      return null;
    }
  }
}
