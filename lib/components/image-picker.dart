import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerSet extends StatefulWidget {
  void Function(File image) _setUserImage;
  ImagePickerSet(this._setUserImage);
  @override
  _ImagePickerSetState createState() => _ImagePickerSetState();
}

class _ImagePickerSetState extends State<ImagePickerSet> {
  File? _image;
  ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 150, imageQuality: 50);
    if (image != null) {
      print('file path: ${image.path}');
      setState(() {
        _image = File(image.path);
      });
      widget._setUserImage(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Select Image'))
      ],
    );
  }
}
