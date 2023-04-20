import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

final GlobalKey _cameraKey = GlobalKey();

class PhotoWaterMark extends StatefulWidget {
  _PhotoWaterMarkState createState() => _PhotoWaterMarkState();
}

class _PhotoWaterMarkState extends State<PhotoWaterMark>
    with WidgetsBindingObserver {
  XFile? _image;

  TakeStatus _takeStatus = TakeStatus.preparing;

  late CameraController _cameraController;

  bool _isCapturing = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App state: $state');
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
    super.didChangeAppLifecycleState(state);
  }

  void _initCamera() async {
    List<CameraDescription> _cameras;
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    await _cameraController.initialize();
    if (mounted) {
      setState(() {
        _takeStatus = TakeStatus.taking;
      });
    }
  }

  void _toggleFlash() {
    switch (_cameraController.value.flashMode) {
      case FlashMode.auto:
        _cameraController.setFlashMode(FlashMode.always);
        break;
      case FlashMode.off:
        _cameraController.setFlashMode(FlashMode.auto);
        break;
      case FlashMode.always:
      case FlashMode.torch:
        _cameraController.setFlashMode(FlashMode.off);
        break;
    }
  }

  void _takePicture() async {
    if (_cameraController.value.isTakingPicture) return;
    XFile _file = await _cameraController.takePicture();
    setState(() {
      _image = _file;
      _takeStatus = TakeStatus.confirm;
    });
  }

  void _cancel() {
    setState(() {
      _takeStatus = TakeStatus.preparing;
    });
    _cameraController.dispose();
    _initCamera();
  }

  void _confirm() async {
    if (_isCapturing) return;
    _isCapturing = true;
    try {
      RenderRepaintBoundary boundary = _cameraKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image _tempImage = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
          await _tempImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List imageBytes =
          byteData!.buffer.asUint8List(); // 图片数据， 可使用 Image.memory 加载显示
      String basePath = await findSavePath();
      File file = File('$basePath${DateTime.now().millisecondsSinceEpoch}.jpg');
      file.writeAsBytesSync(imageBytes);
      Navigator.of(context).pop(file);
    } catch (e) {
      print(e);
    }
    _isCapturing = false;
  }

  Future<String> findSavePath([String? basePath]) async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    if (basePath == null) return directory!.path;
    String _saveDir = p.join(directory!.path, basePath);
    Directory root = Directory(_saveDir);
    if (!root.existsSync()) {
      await root.create();
    }
    return _saveDir;
  }

  Widget _buildCameraArea() {
    Widget _area;
    if (_takeStatus == TakeStatus.confirm && _image != null) {
      _area = Image.file(
        File(_image!.path),
        fit: BoxFit.fitWidth,
      );
    } else if (_cameraController.value.isInitialized) {
      final double screenWidth = MediaQuery.of(context).size.width;
      _area = ClipRect(
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Container(
              width: screenWidth,
              height: screenWidth * _cameraController.value.aspectRatio,
              child: CameraPreview(_cameraController),
            ),
          ),
        ),
      );
    } else {
      _area = Container(color: Colors.black);
    }
    return Center(
      child: RepaintBoundary(
        key: _cameraKey,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: _area,
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateTime.now().toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop,
            icon: Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: _toggleFlash,
            icon: Icon(Icons.flash_auto),
          ),
        ],
      ),
    );
  }

  Widget _buildAction() {
    return Positioned(
      bottom: 50,
      child: _takeStatus == TakeStatus.confirm
          ? Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _cancel,
                    icon: Icon(Icons.close),
                  ),
                  IconButton(
                    onPressed: _confirm,
                    icon: Icon(Icons.confirmation_num),
                  ),
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: IconButton(
                onPressed: _takePicture,
                icon: Icon(
                  Icons.photo_camera,
                  size: 40,
                ),
              ),
            ),
    );
  }

  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildCameraArea(),
          _buildTopBar(),
          _buildAction(),
        ],
      ),
    );
  }
}

enum TakeStatus {
  preparing,
  taking,
  confirm,
  done,
}
