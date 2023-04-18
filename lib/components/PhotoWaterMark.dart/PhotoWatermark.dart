import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final GlobalKey _cameraKey = GlobalKey();

class PhotoWaterMark extends StatefulWidget {
  _PhotoWaterMarkState createState() => _PhotoWaterMarkState();
}

class _PhotoWaterMarkState extends State<PhotoWaterMark>
    with WidgetsBindingObserver {
  XFile? _image;

  TakeStatus _takeStatus = TakeStatus.preparing;
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;

  @override
  void initState() async {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
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
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    }
    super.didChangeAppLifecycleState(state);
  }

  void _takePhoto() async {
    if (_cameraController == null || _cameraController.value.isTakingPicture)
      return;
    XFile _file = await _cameraController.takePicture();
    setState(() {
      _image = _file;
      _takeStatus = TakeStatus.confirm;
    });
  }

  void _confirm() async {
    try {
      RenderRepaintBoundary boundary = _cameraKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image _tempImage = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
          await _tempImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List imageBytes = byteData!.buffer.asUint8List();
      // String basePath = await findSavePath()
    } catch (e) {
      print(e);
    }
  }

  Widget _buildCameraArea() {
    Widget _area;
    if (_takeStatus == TakeStatus.confirm && _image != null) {
      _area = Image.file(
        File(_image!.path),
        fit: BoxFit.fitWidth,
      );
    } else if (_cameraController != null &&
        _cameraController.value.isInitialized) {
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

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watermark'),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: _takePhoto,
              child: Icon(Icons.photo),
            ),
            _image == null ? Container() : Image.file(File(_image!.path)),
          ],
        ),
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
