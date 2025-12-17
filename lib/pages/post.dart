import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  _mainView() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final List<AssetEntity>? result = await AssetPicker.pickAssets(
              context,
            );
            print(result?.length);
          },
          child: Text('选择图片'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Container(
          child: Text('发布', style: TextStyle(color: Colors.white)),
        ),
      ),

      body: _mainView(),
    );
  }
}
