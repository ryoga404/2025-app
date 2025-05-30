import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image; // 画像ファイルを保存するための変数
  double _scale = 1.0; // 画像のスケール（拡大・縮小の倍率）
  final FocusNode _focusNode = FocusNode(); // フォーカスノードを追加

  // 画像を選択するメソッド
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // 画像を選択したら表示する
      });
    }
  }

  // キーボードイベントを処理するメソッド
  void _handleKeyEvent(RawKeyEvent event) {
    // Ctrl + '+' で拡大
    if (event.logicalKey == LogicalKeyboardKey.equal && event.isControlPressed) {
      setState(() {
        _scale = (_scale + 0.1).clamp(0.5, 3.0); // 拡大
      });
    }
    // Ctrl + '-' で縮小
    if (event.logicalKey == LogicalKeyboardKey.minus && event.isControlPressed) {
      setState(() {
        _scale = (_scale - 0.1).clamp(0.5, 3.0); // 縮小
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,  // フォーカスノードを設定
        onKey: _handleKeyEvent,  // キーボードイベントを処理
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 画像選択ボタン
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('画像を選択'),
                ),
                SizedBox(height: 20),
                // 画像が選択された場合、画像を表示
                _image != null
                    ? InteractiveViewer(  // 拡大・縮小ができるようにする
                  panEnabled: true, // パン（移動）を有効にする
                  scaleEnabled: true, // スケール（拡大縮小）を有効にする
                  minScale: 0.1, // 最小スケール（縮小の限度）
                  maxScale: 15.0, // 最大スケール（拡大の限度）
                  child: Image.file(
                    _image!,  // 画像が選択されていれば表示
                    width: MediaQuery.of(context).size.width, // 画像の幅を画面の幅に合わせる
                    height: 300 * _scale, // スケールを掛け合わせて拡大・縮小
                    fit: BoxFit.contain, // 画像のアスペクト比を保ちながら表示
                  ),
                )
                    : Text('画像が選択されていません'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
