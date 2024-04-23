import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iota/models/file_model.dart';
import 'package:iota/services/api_service.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _selectedFile;
  String? _uploadStatus;
  FileModel? _uploadedFile;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile != null) {
      setState(() {
        _uploadStatus = 'Uploading file...';
      });
      var uploadedFile = await ApiService.uploadFile(_selectedFile!);
      setState(() {
        _uploadedFile = uploadedFile;
        _uploadStatus = uploadedFile != null ? 'File uploaded successfully' : 'Failed to upload file';
      });
    } else {
      setState(() {
        _uploadStatus = 'Please select a file first';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 20),
            if (_selectedFile != null) Text('Selected File: ${_selectedFile!.path}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Upload File'),
            ),
            if (_uploadStatus != null) SizedBox(height: 20),
            if (_uploadStatus != null) Text(_uploadStatus!),
            if (_uploadedFile != null) SizedBox(height: 20),
            if (_uploadedFile != null) Text('File uploaded at: ${_uploadedFile!.url}'),
          ],
        ),
      ),
    );
  }
}
