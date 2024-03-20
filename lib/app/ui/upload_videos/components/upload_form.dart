import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field_model.dart';
import 'package:tiktok_clone/app/ui/upload_videos/upload_videos_controller.dart';
import 'package:tiktok_clone/app/utils/validations.dart';
import 'package:video_player/video_player.dart';

import '../../../components/button_enter.dart';

// ignore: must_be_immutable
class UploadForm extends StatefulWidget {
  UploadForm({
    super.key,
    required this.videoFile,
    required this.videoPath,
  });

  final File videoFile;
  final String videoPath;

  UploadVideosController uploadVideosController = Get.put(UploadVideosController());
  TextEditingController titleVideoController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  GlobalKey<FormState> uploadFormKey = GlobalKey<FormState>(debugLabel: 'UploadFormKey');
  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  VideoPlayerController? playerController;

  @override
  initState() {
    super.initState();
    setState(() {
      playerController = VideoPlayerController.file(widget.videoFile);
    });
    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(false);
  }

  @override
  void dispose() {
    super.dispose();
    playerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.8,
                child: VideoPlayer(playerController!),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: widget.uploadFormKey,
                  child: Column(
                    children: [
                      InputTextField(
                        model: InputTextFieldModel(
                          controller: widget.titleVideoController,
                          text: 'Titulo do Video',
                          isPassword: false,
                          type: TextInputType.visiblePassword,
                          validator: Validations.nameuploadFormText,
                          formatters: [],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InputTextField(
                        model: InputTextFieldModel(
                          controller: widget.tagsController,
                          text: 'Tags',
                          isPassword: false,
                          type: TextInputType.visiblePassword,
                          validator: Validations.nameuploadFormText,
                          formatters: [],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Obx(() {
                        return ButtonEnter(
                          onTap: () {
                            final isValidForm = widget.uploadFormKey.currentState!.validate();
                            if (isValidForm) {
                              widget.uploadVideosController.saveVideoInformationToFirebaseDatabase(
                                widget.titleVideoController.text,
                                widget.tagsController.text,
                                widget.videoPath,
                                context,
                              );
                            }
                          },
                          isLoading: widget.uploadVideosController.isLoading.value,
                          titleButton: 'Salvar / Enviar',
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
