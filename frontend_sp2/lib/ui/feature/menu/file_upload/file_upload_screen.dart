import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:frontend_sp2/core/theming/img_paths.dart';
import 'package:flutter/foundation.dart';

class FileUploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Animate(
        effects: const [FadeEffect()],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25.0),
            Text(
              "Sube tu archivo",
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 8.0),
            Text(
              "El archivo debería ser un excel",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 25.0),
            SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  DropzoneView(
                    operation: DragOperation.copy,
                    cursor: CursorType.Default,
                    onLoaded: () => print('Zone loaded'),
                    onError: (String? ev) => print('Error: $ev'),
                    onHover: () => print('Zone hovered'),
                    onDrop: (dynamic ev) => print('Drop: $ev'),
                    onLeave: () => print('Zone left'),
                  ),
                  _UploadFileContainer()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _UploadFileContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return GestureDetector(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
      },
      child: DottedBorder(
          dashPattern: const [6, 3, 2, 3],
          child: Container(
              height: media.size.height / 4,
              width: media.size.width / 3,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(ImgPaths.folderIcon),
                  ),
                  SizedBox(height: 8.0),
                  Text("Puede arrastar tu archivo acá")
                ],
              ))),
    );
  }
}
