import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/widgets/edit_image_viewModel.dart';
import 'package:screenshot/screenshot.dart';

import '../widgets/appbar_icon_button.dart';
import '../widgets/image_text.dart';

class EditImage extends StatefulWidget {
  final String selectedImage;
  const EditImage({Key? key, required this.selectedImage}) : super(key: key);

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          child: Stack(
            children: [
              _selectedImage,
              for (int i = 0; i < texts.length; i++)
                Positioned(
                  left: texts[i].left,
                  top: texts[i].top,
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        currentIndex = i;
                        RemoveText(context);
                      });
                    },
                    onTap: () => setCurrentIndex(context, i),
                    child: Draggable(
                      feedback: ImageText(textInfo: texts[i]),
                      child: ImageText(textInfo: texts[i]),
                      onDragEnd: (drag) {
                        final renderBox =
                            context.findRenderObject() as RenderBox;
                        Offset off = renderBox.globalToLocal(drag.offset);
                        setState(() {
                          texts[i].top = off.dy - 96;
                          texts[i].left = off.dx;
                        });
                      },
                    ),
                  ),
                ),
              creatorText.text.isNotEmpty
                  ? Positioned(
                      left: 0,
                      bottom: 0,
                      child: Text(
                        creatorText.text,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.3)),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        )),
      ),
      floatingActionButton: _addNewText,
    );
  }

  Widget get _selectedImage => Center(
        child: Image.file(
          File(widget.selectedImage),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );
  Widget get _addNewText => FloatingActionButton(
        onPressed: () => addNewDialoge(context),
        backgroundColor: Colors.white,
        tooltip: "Add New Text",
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );
  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              AppBarIconButton(
                press: () => SaveToGallery(context),
                tooltip: "Save Image",
                icon: Icons.save,
                color: Colors.black,
              ),
              AppBarIconButton(
                press: IncreaseFontSize,
                tooltip: "Increase Font Size",
                icon: Icons.add,
                color: Colors.black,
              ),
              AppBarIconButton(
                press: DecreaseFontSize,
                tooltip: "Decrease Font Size",
                icon: Icons.remove,
                color: Colors.black,
              ),
              AppBarIconButton(
                press: () => SetTextAlignment(TextAlign.left),
                tooltip: "Align Left",
                icon: Icons.format_align_left,
                color: Colors.black,
              ),
              AppBarIconButton(
                press: () => SetTextAlignment(TextAlign.center),
                tooltip: "Align Center",
                icon: Icons.format_align_center,
                color: Colors.black,
              ),
              AppBarIconButton(
                press: () => SetTextAlignment(TextAlign.right),
                tooltip: "Align Right",
                icon: Icons.format_align_right,
                color: Colors.black,
              ),
              AppBarIconButton(
                press: SetTextWeight,
                tooltip: "Bold",
                icon: Icons.format_bold,
                color: Colors.black,
              ),
              AppBarIconButton(
                press: SetTextfontStyle,
                tooltip: "Italic",
                icon: Icons.format_italic,
                color: Colors.black,
              ),
              AppBarIconButton(
                press: AddLinesToText,
                tooltip: "Add New Line",
                icon: Icons.space_bar,
                color: Colors.black,
              ),
              Tooltip(
                message: "Red",
                child: GestureDetector(
                  onTap: () => ChangeTextColor(Colors.red),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "White",
                child: GestureDetector(
                  onTap: () => ChangeTextColor(Colors.white),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Blue",
                child: GestureDetector(
                  onTap: () => ChangeTextColor(Colors.blue),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Black",
                child: GestureDetector(
                  onTap: () => ChangeTextColor(Colors.black),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Yellow",
                child: GestureDetector(
                  onTap: () => ChangeTextColor(Colors.yellow),
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Green",
                child: GestureDetector(
                  onTap: () => ChangeTextColor(Colors.green),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Orange",
                child: GestureDetector(
                  onTap: () => ChangeTextColor(Colors.orange),
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Pink",
                child: GestureDetector(
                  onTap: () => ChangeTextColor(Colors.pink),
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
        ),
      );
}
