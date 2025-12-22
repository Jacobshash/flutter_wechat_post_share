import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class GalleryWidget extends StatefulWidget {
  final int initialIndex;
  final List<AssetEntity> items;

  const GalleryWidget({
    super.key,
    required this.initialIndex,
    required this.items,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {

  Widget _buildImageView() {
    return ExtendedImageGesturePageView.builder(
      itemCount: widget.items.length,
      controller: ExtendedPageController(
        initialPage: widget.initialIndex,
      ),
      itemBuilder: (BuildContext context, int index) {
        final AssetEntity item = widget.items[index];
        Widget image =  ExtendedImage(
          image: AssetEntityImageProvider(item, isOriginal: true),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: ((state){
              return GestureConfig(
                minScale: 0.9,
                animationMinScale: 0.7,
                animationMaxScale: 3.5,
                maxScale: 3.0,
                speed: 1.0,
                inertialSpeed: 100.0,
                initialScale: 1.0,
                inPageView: true,
              );
          }),
        );

        return image;
      },
    );
  }

  Widget _mainView(){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        Navigator.pop(context);
      },
      child: Scaffold(

        body: Container(
          decoration: BoxDecoration(
            color: Colors.black
          ),
          child: _buildImageView(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }
}
