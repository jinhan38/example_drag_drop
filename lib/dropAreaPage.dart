import 'package:example_drag_drop/DataModel.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class DropAreaPage extends StatefulWidget {
  const DropAreaPage({Key? key}) : super(key: key);

  @override
  State<DropAreaPage> createState() => _DropAreaPageState();
}

class _DropAreaPageState extends State<DropAreaPage> {
  late DropzoneViewController controller;
  DataModel? dropFile;
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          dropBox(),
          Expanded(child: image(dropFile)),
        ],
      ),
    );
  }

  Widget dropBox() {
    return Container(
      height: 300,
      color: highlight ? Colors.purple : Colors.blue,
      child: Stack(
        children: [
          DropzoneView(
            onCreated: (c) => controller = c,
            onDrop: uploadFile,
            onHover: () {
              setState(() {
                highlight = true;
              });
            },
            onLeave: () {
              setState(() {
                highlight = false;
              });
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_upload,
                  size: 50,
                  color: Colors.white,
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      final events = await controller.pickFiles();
                      if (events.isEmpty) return;
                      uploadFile(events.first);
                    },
                    icon: const Icon(Icons.search),
                    label: const Text("파일 선택")),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget image(DataModel? data) {
    if (data == null) return const Text("노데이터");
    if (!data.checkImage) {
      return const Text("이미지가 아닙니다.");
    }
    return Image.network(
      data.url,
      fit: BoxFit.fitHeight,
    );
  }

  Future uploadFile(dynamic events) async {
    final name = events.name;
    final mime = await controller.getFileMIME(events);
    final bytes = await controller.getFileSize(events);
    final url = await controller.createFileUrl(events);
    setState(() {
      dropFile = DataModel(name: name, mime: mime, bytes: bytes, url: url);
      highlight = false;
    });
  }
}
