import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/anim_paths.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/core/theming/img_paths.dart';
import 'package:frontend_sp2/ui/feature/menu/state/file_upload_cubit.dart';
import 'package:lottie/lottie.dart';

class FileUploadScreen extends StatelessWidget {
  const FileUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FileUploadCubit>(),
      child: FileUploadScreenBody(),
    );
  }

}

class _FileUploadLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
            AnimPaths.fileUploadAnim
        ),
        Text(
          "Espera por favor, estamos cargando y procesando el archivo",
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

}

class _FileUploadResultScreen extends StatelessWidget{
  final String message;
  final String buttonMessage;
  final IconData icon;
  final Color color;

  const _FileUploadResultScreen({
    super.key,
    required this.message,
    required this.buttonMessage,
    required this.icon,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: 200,
        ),
        const SizedBox(height: Dimens.itemSeparationHeight),
        Text(
          message,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: Dimens.itemSeparationHeight),
        ElevatedButton(
            onPressed: () {
              context.read<FileUploadCubit>().resetView();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white
            ),
            child: Text(
              buttonMessage,
              style: Theme.of(context).textTheme.bodyText2,
            )
        )
      ],
    );
  }

}

class FileUploadScreenBody extends StatelessWidget {
  late DropzoneViewController dropzoneViewController;
  FileUploadScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileUploadCubit, FileUploadScreenState>(
      builder: (BuildContext context, state) {
        return state.when(
            initial: () {
              return SingleChildScrollView(
                child: Animate(
                  effects: const [FadeEffect()],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimens.topSeparation),
                      Text(
                        "Sube tu archivo",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "El archivo debe ser un excel",
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
                              onCreated: (ctrl) {
                                dropzoneViewController = ctrl;
                              },
                              cursor: CursorType.Default,
                              onLoaded: () => print('Zone loaded'),
                              onError: (String? ev) => print('Error: $ev'),
                              onHover: () => print('Zone hovered'),
                              onDrop: (dynamic ev) {
                                dropzoneViewController.getFileData(ev).then((bytes) {
                                  uploadFile(bytes, context);
                                });
                              },
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
            },
            loading: () {
              return Animate(
                  effects: const [FadeEffect()],
                  child: _FileUploadLoadingScreen()
              );
            },
            error: () {
              return Animate(
                effects: const [FadeEffect()],
                child: const _FileUploadResultScreen(
                    message: "Ha ocurrido un error al subir el archivo",
                    buttonMessage: "Intentar nuevamente",
                    icon: Icons.error,
                    color: Colors.red
                ),
              );
            },
            success: () {
              return Animate(
                effects: const [FadeEffect()],
                child: const _FileUploadResultScreen(
                    message: "Se ha procesado el archivo",
                    buttonMessage: "Subir otro",
                    icon: Icons.check_circle,
                    color: Colors.green
                ),
              );
            }
        );
      },
    );

  }

  void uploadFile(Uint8List bytes, BuildContext context) {
    context.read<FileUploadCubit>().uploadFileBytes(bytes);
  }

}

class _UploadFileContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        uploadFromFilePicker(context);
      },
      child: DottedBorder(
          dashPattern: const [6, 3, 2, 3],
          child: SizedBox(
              height: media.size.height / 4,
              width: media.size.width / 3,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(ImgPaths.folderIcon),
                  ),
                  SizedBox(height: 8.0),
                  Text("Puede arrastar tu archivo acá o puedes hacer click")
                ],
              ))),
    );
  }

  void uploadFromFilePicker(BuildContext context)  {
    FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xls'],
        allowMultiple: false
    ).then((result) {
      if (result != null) {
        var bytes = result.files.single.bytes!;
        uploadFile(bytes, context);
      }
    });

  }

  void uploadFile(Uint8List bytes, BuildContext context) {
    context.read<FileUploadCubit>().uploadFileBytes(bytes);
  }

}
