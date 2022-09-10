class DataModel {
  final String name;
  final String mime;
  final int bytes;
  final String url;

  DataModel({
    required this.name,
    required this.mime,
    required this.bytes,
    required this.url,
  });

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb > 1
        ? "${mb.toStringAsFixed(2)} MB"
        : "${kb.toStringAsFixed(2)} KB";
  }

  bool get checkImage {
    if(mime.contains("png")){
      return true;
    }
    if(mime.contains("jpg")){
      return true;
    }
    if(mime.contains("jpeg")){
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return 'DataModel{name: $name, mime: $mime, bytes: $bytes, url: $url}';
  }
}
