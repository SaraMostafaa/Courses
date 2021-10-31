// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:courses/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  String imagePath;
  final void Function(File pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn, [this.imagePath = ""]);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _imgFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    print(pickedImage.path);
    setState(() {
      if (widget.imagePath != "") widget.imagePath = "";
      if (widget.imagePath == "") _pickedImage = pickedImageFile as File;
    });
    widget.imagePickFn(pickedImageFile);
  }

  void _imgFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile as File;
    });
    widget.imagePickFn(pickedImageFile);
  }

  _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text(S.of(context).pickFromGallery),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text(S.of(context).camera),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          if (widget.imagePath == "")
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  _pickedImage != null ? FileImage(_pickedImage!) : null,
            ),
          if (widget.imagePath != "")
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.imagePath),
            ),
          FlatButton.icon(
            icon: Icon(
              Icons.image,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => _showPicker(context),
            label: Text(
              S.of(context).addImage,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
