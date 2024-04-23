import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iota/services/api_service.dart';

class FileDownloadScreen extends StatefulWidget {
  @override
  _FileDownloadScreenState createState() => _FileDownloadScreenState();
}

class _FileDownloadScreenState extends State<FileDownloadScreen> {
  String _txHash = '';
  String? _downloadStatus;
  File? _downloadedFile;

  Future<void> _downloadFile() async {
    if (_txHash.isNotEmpty) {
      setState(() {
        _downloadStatus = 'Downloading file...';
      });
      try {
        var file = await ApiService.downloadFile(_txHash);
        setState(() {
          _downloadedFile = file;
          _downloadStatus = 'File downloaded successfully';
        });
      } catch (e) {
        setState(() {
          _downloadStatus = 'Failed to download file';
        });
      }
    } else {
      setState(() {
        _downloadStatus = 'Please enter a transaction hash';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Download'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Transaction Hash'),
              onChanged: (value) => _txHash = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _downloadFile,
              child: Text('Download File'),
            ),
            if (_downloadStatus != null) SizedBox(height: 20),
            if (_downloadStatus != null) Text(_downloadStatus!),
            if (_downloadedFile != null) SizedBox(height: 20),
            if (_downloadedFile != null) Text('File downloaded at: ${_downloadedFile!.path}'),
          ],
        ),
      ),
    );
  }
}
