import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scrollingImagesProvider = Provider<List<String>>((ref) {
  return [
    'https://i.scdn.co/image/ab6761610000e5ebf37e3036f0b56288385243a5',
    'https://i1.sndcdn.com/artworks-000525815001-4e79a3-t500x500.jpg',
    'https://i1.sndcdn.com/artworks-000084016423-vd98se-t500x500.jpg',
    'https://i1.sndcdn.com/artworks-000150715115-hvkw9l-t500x500.jpg',
    'https://i1.sndcdn.com/artworks-pCy76QHC9A8vWMpr-vrLyjA-t500x500.jpg',
    'https://i1.sndcdn.com/artworks-SgLAoHvOAVwg-0-t500x500.jpg',
    'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/9a/be/dc/9abedc75-a7ae-ae8d-a9ff-543299ec514c/199800525926.jpg/800x800cc.jpg',
    'https://i1.sndcdn.com/artworks-UmbSrEmlL8ry-0-t500x500.jpg',
  ];
});

ImageProvider getOptimizedImageProvider(String url) {
  return ResizeImage(
    CachedNetworkImageProvider(url),
    width: 256,
    allowUpscaling: true,
  );
}

final imagesPreloadedProvider = NotifierProvider<ImagesPreloadedNotifier, bool>(
  ImagesPreloadedNotifier.new,
);

class ImagesPreloadedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> preloadImages(BuildContext context) async {
    if (state) return;
    final images = ref.read(scrollingImagesProvider);

    try {
      await Future.wait(
        images.map((url) {
          return precacheImage(getOptimizedImageProvider(url), context);
        }),
      );
    } catch (e) {
      debugPrint('Error preloading images: $e');
    }
    state = true;
  }
}
