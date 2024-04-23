class FileModel {
  final String name;
  final String url;

  FileModel({required this.name, required this.url});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      name: json['name'],
      url: json['url'],
    );
  }
}
