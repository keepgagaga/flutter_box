import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box/utils/RandomColor.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:path/path.dart' as path;

class Archive extends StatefulWidget {
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  File? _file;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _uploadFile() async {
    FilePickerResult? _result = await FilePicker.platform.pickFiles();

    if (_result != null) {
      if (!_result.files.single.path!.endsWith('.zip')) {
        SmartDialog.showToast('请选择zip文件');
        return;
      }
      _file = File(_result.files.single.path!);
      setState(() {});
    } else {
      print('user cancel');
    }
  }

  void _archive() async {
    final _bytes = _file!.readAsBytesSync();
    final _archiveData = ZipDecoder().decodeBytes(_bytes);

    for (final file in _archiveData) {
      final fileName = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        File(path.dirname(_file!.path) + '/' + fileName)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory('out/' + fileName).create(recursive: true);
      }
    }

    Directory _dir = Directory(path.dirname(_file!.path) + '/__MACOSX/');
    _dir.delete(recursive: true);
    SmartDialog.showToast('解压成功');
  }

  Widget _buildUploadButton() {
    return Container(
      child: TextButton(
        onPressed: _uploadFile,
        child: Text('Upload'),
      ),
    );
  }

  Widget _buildFile() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_file!.path.split('/').last.toString()),
          TextButton(
            onPressed: _archive,
            child: Text('解压缩'),
          ),
        ],
      ),
    );
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('decompress'),
      ),
      body: Center(
        child: _file != null ? _buildFile() : _buildUploadButton(),
      ),
    );
  }
}
