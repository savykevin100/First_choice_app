import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'app_bar.dart';

class HeroExample extends StatelessWidget {
  static String id="Hero";
  @override
  Widget build(BuildContext context) {
    return ExampleAppBarLayout(
      title: "Hero",
      showGoBack: true,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HeroPhotoViewRouteWrapper(
                  imageProvider: AssetImage("assets/images/logo.png"),
                ),
              ),
            );
          },
          child: Container(
            child: Hero(
              tag: "customBackground",
              child: Image.asset("assets/images/logo.png", width: 150.0),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    this.imageProvider,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        loadingBuilder: loadingBuilder,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
        heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
      ),
    );
  }
}