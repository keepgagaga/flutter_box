import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

final GlobalKey _cameraKey = GlobalKey();

class PhotoWaterMark extends StatefulWidget {
  final List<CameraDescription> cameras; // 直接传相机数组就行

  const PhotoWaterMark({super.key, required this.cameras});

  _PhotoWaterMarkState createState() => _PhotoWaterMarkState();
}

class _PhotoWaterMarkState extends State<PhotoWaterMark>
    with WidgetsBindingObserver {
  XFile? _image;
  TakeStatus _takeStatus = TakeStatus.preparing;
  late CameraController _cameraController;
  bool _isCapturing = false;
  DateTime _time = DateTime.now();
  late Timer _timer;
  String _cameraDirection = 'rear'; // rear front

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
    _timer.cancel();
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
    _timer = Timer.periodic(Duration(seconds: 1), _handTimeUpdate);

    _cameraController = CameraController(
      _cameraDirection == 'rear' ? widget.cameras[0] : widget.cameras[1],
      ResolutionPreset.high,
      enableAudio: false,
      // imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    final status = await Permission.camera.request();
    print(status);

    if (status.isGranted) {
      await _cameraController.initialize();

      _cameraController.setFlashMode(FlashMode.off);
      if (mounted) {
        setState(() {
          _takeStatus = TakeStatus.taking;
        });
      }
    } else if (status.isPermanentlyDenied) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('无相机权限'),
            content: Text('请前往设置打开'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );
    } else if (status.isDenied) {
      await Permission.camera.request();
    }
  }

  void _handTimeUpdate(t) {
    if (mounted) {
      setState(() {
        _time = DateTime.now();
      });
    }
  }

  void _toggleFlash() {
    print(_cameraController.value.flashMode);
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

  void _flipCamera() {
    setState(() {
      _cameraDirection = _cameraDirection == 'rear' ? 'front' : 'rear';
    });
    _initCamera();
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
      if (await Permission.storage.request().isGranted) {
        final saveResult = await ImageGallerySaver.saveImage(imageBytes);
        print(saveResult);
        if (saveResult['isSuccess']) {
          SmartDialog.showToast('Save Photo Success');
          await Future.delayed(Duration(seconds: 1));
          Navigator.of(context).pop();
        } else {
          SmartDialog.showToast('Save Photo Fail');
        }
      } else {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text('无权限'),
                content: Text('保存拍摄的照片需要此权限，是否跳转到设置页面？'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            });
      }
    } catch (e) {
      print(e);
    }
    _isCapturing = false;
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
                    '${_time.day}:${_time.hour}:${_time.minute}:${_time.second}',
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
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back),
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
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _cancel,
                    icon: Icon(Icons.close),
                  ),
                  IconButton(
                    onPressed: _confirm,
                    icon: Icon(Icons.save),
                  ),
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _toggleFlash,
                    icon: Icon(
                      _cameraController.value.flashMode == FlashMode.auto
                          ? Icons.flash_auto
                          : (_cameraController.value.flashMode ==
                                  FlashMode.always
                              ? Icons.flash_on
                              : Icons.flash_off),
                    ),
                  ),
                  IconButton(
                    onPressed: _takePicture,
                    icon: Icon(
                      Icons.photo_camera,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: _flipCamera,
                    icon: Icon(Icons.flip_camera_android),
                  ),
                ],
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
