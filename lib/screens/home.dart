import 'package:flutter/material.dart';
import 'package:image_editor/screens/edit_image.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.upload_file),
          onPressed: () async {
            XFile? file =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (file != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditImage(selectedImage: file.path)));
            }
          },
        ),
      ),
    );
  }
}
