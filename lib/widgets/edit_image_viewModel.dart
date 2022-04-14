import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editor/models/text_info.dart';
import 'package:image_editor/screens/edit_image.dart';
import 'package:image_editor/widgets/default_buttons.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../utils/utils.dart';

abstract class EditImageViewModel extends State<EditImage> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> texts = [];
  int currentIndex = 0;
  SaveToGallery(BuildContext context) {
    screenshotController.capture().then((Uint8List? image) {
      SaveImage(image!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Image Saved to gallery",
        style: TextStyle(fontSize: 16),
      )));
    }).catchError((err) {
      print(err);
    });
  }

  SaveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    final name = "screenshot-$time";
    await RequestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "Selected For Styling",
      style: TextStyle(fontSize: 16),
    )));
  }

  ChangeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  IncreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  SetTextAlignment(TextAlign textAlign) {
    setState(() {
      texts[currentIndex].textAlign = textAlign;
    });
  }

  SetTextWeight() {
    setState(() {
      texts[currentIndex].fontWeight == FontWeight.normal
          ? texts[currentIndex].fontWeight = FontWeight.bold
          : texts[currentIndex].fontWeight = FontWeight.normal;
    });
  }

  SetTextfontStyle() {
    setState(() {
      texts[currentIndex].fontStyle == FontStyle.normal
          ? texts[currentIndex].fontStyle = FontStyle.italic
          : texts[currentIndex].fontStyle = FontStyle.normal;
    });
  }

  AddLinesToText() {
    setState(() {
      texts[currentIndex].text.contains("\n")
          ? texts[currentIndex].text =
              texts[currentIndex].text.replaceAll("\n", " ")
          : texts[currentIndex].text =
              texts[currentIndex].text.replaceAll(" ", "\n");
    });
  }

  DecreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  RemoveText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "Deleted",
      style: TextStyle(fontSize: 16),
    )));
  }

  addNewText(context) {
    setState(() {
      texts.add(TextInfo(
          text: textEditingController.text,
          left: 0,
          top: 0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left));
      Navigator.pop(context);
    });
  }

  addNewDialoge(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Add New Text....."),
            content: TextField(
              controller: textEditingController,
              maxLines: 5,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  filled: true,
                  hintText: "your text here....."),
            ),
            actions: <Widget>[
              DefaultButton(
                  onPress: () => Navigator.pop(context),
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.white,
                  textColor: Colors.black),
              DefaultButton(
                  onPress: () => addNewText(context),
                  child: Text("Add Text"),
                  color: Colors.red,
                  textColor: Colors.white)
            ],
          ));
}
