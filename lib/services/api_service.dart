import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:iota/models/file_model.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  static const String baseUrl = 'https://agile-anchorage-08994-090a73ed1b31.herokuapp.com';

  static Future<FileModel?> uploadFile(File file) async {
    var url = '$baseUrl/upload';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var data = jsonDecode(responseData);
        return FileModel.fromJson(data);
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
    return null;
  }

  static Future<File> downloadFile(String txHash) async {
    var url = '$baseUrl/download/$txHash';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;
        var dir = await getApplicationDocumentsDirectory();
        var file = File('${dir.path}/downloaded_file');
        await file.writeAsBytes(bytes);
        return file;
      } else {
        print('Failed to download file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
    throw Exception('Failed to download file');
  }
}