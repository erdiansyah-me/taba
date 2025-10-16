import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final _imagePicker = ImagePicker();
  late Future<File> _imageFile;
  Future<void> getProfileImage(bool isPickedFromGallery) async {
    try {
      XFile? pickedImage;
      if (isPickedFromGallery) {
        pickedImage = await _imagePicker.pickImage(
            source: ImageSource.gallery, maxWidth: 1200, maxHeight: 1200);
      } else {
        pickedImage = await _imagePicker.pickImage(
            source: ImageSource.camera, maxWidth: 1200, maxHeight: 1200);
      }
      _imageFile = Future.value(File(pickedImage!.path));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal Memuat Gambar, Coba Lagi!')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        children: [
          FutureBuilder(
            future: _imageFile,
            builder: (context, snap) {
              if (snap.hasData) {
                return Image.file(
                  snap.data!,
                  height: 400.h,
                );
              } else {
                return Icon(
                  Icons.image,
                  size: 400.h,
                  color: Colors.grey,
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () async => await getProfileImage(false),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.camera_alt),
                Text('Ambil Dengan Kamera')
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => getProfileImage(true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.photo), Text('Ambil Dengan Galeri')],
            ),
          ),
        ],
      ),
    );
  }
}
