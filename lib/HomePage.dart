// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _HomePageState();
}

class _HomePageState extends State<Home_Page> {
  List<dynamic> listImagePath = <dynamic>[];
  Future? _futureGetPath;

  @override
  void initState() {
    _getPermission();
    super.initState();
    _futureGetPath = getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.image_outlined),
        title: const Center(child: Text("Pictures Permission", textAlign: TextAlign.center)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1010,
              child: GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 11,
                mainAxisSpacing: 11,
                crossAxisCount: 1,
                children: _getListImg(listImagePath),
              ),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: _futureGetPath,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var dir = Directory(snapshot.data);
                  if (true) _fetchFiles(dir);
                    return Text(snapshot.data);
                } else {
                    return const Text("PICTURES FOLDER EMPTY");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _getPermission() async {
    await Permission.storage.request().isGranted;
    setState(() {
      }
    );
  }

  Future<String> getImage() {
    return ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_PICTURES);
  }

  _fetchFiles(Directory dir) {
    List<dynamic> listImage = [];
    dir.list().forEach((element) {
      RegExp regExp = RegExp(
          "(gif|jpe?g|png|webp|bmp)", caseSensitive: false);
      if (regExp.hasMatch('$element')) listImage.add(element);
        setState(() {
          listImagePath = listImage;
          }
        );
      }
    );
  }

  List<Widget> _getListImg(List<dynamic> listImagePath) {
    List<Widget> listImages = [];
    for (var imagePath in listImagePath) {
      listImages.add(
        Container(
          padding: const EdgeInsets.all(8),
          child: Image.file(imagePath, fit: BoxFit.cover),
        ),
      );
    }
    return listImages;
  }
}

