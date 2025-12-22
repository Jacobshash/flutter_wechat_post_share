import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../const/constant.dart';
import '../widgets/Gallery.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  List<AssetEntity> photos = [];

  Widget _buildPhotosList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = (constraints.maxWidth - spacing * 2) / 3;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final value in photos) photoViewContainer(value, width),

            // 添加图片
            if (photos.length < maxAssets)
              gestureDetectorWithPhotoSelect(context, width),
          ],
        );
      },
    );
  }

  GestureDetector gestureDetectorWithPhotoSelect(
    BuildContext context,
    double width,
  ) {
    return GestureDetector(
      onTap: () async {
        final List<AssetEntity>? result = await AssetPicker.pickAssets(
          context,
          pickerConfig: AssetPickerConfig(
            selectedAssets: photos,
            maxAssets: maxAssets,
          ),
        );
        if(result==null) {
          return;
        }
        setState(() {
          photos = result;
        });
      },
      child: Container(
        color: Colors.grey.shade200,
        width: width,
        height: width,
        child: Icon(Icons.add, color: Colors.grey.shade500, size: 50),
      ),
    );
  }

  GestureDetector photoViewContainer(AssetEntity asset, double width) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return GalleryWidget(initialIndex: photos.indexOf(asset), items: photos);
        }));

      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: AssetEntityImage(
          asset,
          key: ValueKey(asset.id),
          // 添加key参数
          fit: BoxFit.cover,
          width: width,
          height: width,
          isOriginal: false,
        ),
      ),
    );
  }

  Widget _mainView() {
    return Column(children: [_buildPhotosList()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text('发布', style: TextStyle(color: Colors.white)),
      ),

      body: _mainView(),
    );
  }
}
