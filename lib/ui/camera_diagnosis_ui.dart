import 'dart:io';

import 'package:camera/camera.dart';
import 'package:farmers_guide/constants/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

const _tempImagePath = 'Temp';

/// CameraDiagnosisUi is the Main Application.
class CameraDiagnosisUi extends StatefulWidget {
  /// Default Constructor
  const CameraDiagnosisUi({super.key});

  static const routeName = '/camera_diagnosis';

  @override
  State<CameraDiagnosisUi> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraDiagnosisUi> {
  late CameraController controller;
  bool flashOn = false;

  String imagePath = '';

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.veryHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    MediaQuery.platformBrightnessOf(context) == Brightness.dark
        ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark)
        : SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Stack(
            children: [
              imagePath.isEmpty
                  ? CameraPreview(controller)
                  : imagePath == _tempImagePath
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(top: 120, bottom: 150),
                          alignment: Alignment.center,
                          child: Image.file(
                            File(imagePath),
                          ),
                        ),
              // Bottom buttons
              Positioned(
                bottom: 0,
                width: constraints.maxWidth,
                child: Container(
                  height: 150,
                  color: Colors.black,
                  alignment: Alignment.center,
                  // padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(width: (constraints.maxWidth / 2 - 60)),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  OutlinedButton(
                                    onPressed: () async {
                                      final image =
                                          await controller.takePicture();
                                      setState(() {
                                        imagePath = image.path;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 2.0, color: Colors.white),
                                      shape: const CircleBorder(),
                                      // fixedSize: const Size.square(60),
                                    ),
                                    child: Container(
                                      margin: imagePath.isNotEmpty
                                          ? null
                                          : const EdgeInsets.all(6),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: imagePath.isNotEmpty
                                            ? const Icon(
                                                Icons.check,
                                                size: 32,
                                                color: Colors.black,
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                  if (imagePath.isNotEmpty)
                                    const Text(
                                      "Send",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  OutlinedButton(
                                    onPressed: () async {
                                      if (imagePath.isNotEmpty) {
                                        setState(() {
                                          imagePath = '';
                                        });
                                      } else {
                                        setState(() {
                                          imagePath = _tempImagePath;
                                        });
                                        final image =
                                            await handleImagePicker(context);
                                        setState(() {
                                          imagePath = image;
                                        });
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 2.0, color: Colors.white),
                                      shape: const CircleBorder(),
                                      // fixedSize: const Size.square(60),
                                    ),
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Icon(
                                        imagePath.isEmpty
                                            ? Icons.upload
                                            : Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  if (imagePath.isNotEmpty)
                                    const Text(
                                      "Retake",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Top buttons
              Positioned(
                top: 0,
                width: constraints.maxWidth,
                child: Container(
                  height: 175,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(width: 2.0, color: Colors.white),
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "Crop Disease",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: imagePath.isEmpty
                            ? () {
                                if (flashOn) {
                                  controller.setFlashMode(FlashMode.off);
                                  setState(() {
                                    flashOn = false;
                                  });
                                } else {
                                  controller.setFlashMode(FlashMode.always);
                                  setState(() {
                                    flashOn = true;
                                  });
                                }
                              }
                            : null,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 2.0,
                            color: imagePath.isEmpty
                                ? Colors.white
                                : Colors.white54,
                          ),
                          shape: const CircleBorder(),
                        ),
                        child: Icon(
                          flashOn
                              ? CupertinoIcons.bolt
                              : CupertinoIcons.bolt_slash,
                          color:
                              imagePath.isEmpty ? Colors.white : Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<String> handleImagePicker(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    return image?.path ?? '';
  }
}
