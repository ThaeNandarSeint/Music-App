import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/core/widgets/custom_text_field.dart';
import 'package:music_app/features/song/util.dart';
import 'package:music_app/features/song/view/widgets/audio_wave.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;

  @override
  void dispose() {
    songNameController.dispose();
    artistController.dispose();
    super.dispose();
  }

  void selectAudio() async {
    final result = await pickFile(FileType.audio);
    if (result != null) {
      setState(() {
        selectedAudio = result;
      });
    }
  }

  void selectImage() async {
    final result = await pickFile(FileType.image);
    if (result != null) {
      setState(() {
        selectedImage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: selectedImage != null
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(selectedImage!, fit: BoxFit.cover),
                        ),
                      )
                    : DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          color: Pallete.borderColor,
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          radius: const Radius.circular(10),
                        ),
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open, size: 40),
                              SizedBox(height: 15),
                              Text(
                                "Select the thumbnail for your song",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 40),
              selectedAudio != null
                  ? AudioWave(audioPath: selectedAudio!.path)
                  : CustomTextField(
                      hintText: 'Pick Song',
                      controller: null,
                      isReadOnly: true,
                      onTap: selectAudio,
                    ),
              const SizedBox(height: 20),
              CustomTextField(hintText: 'Artist', controller: artistController),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Song Name',
                controller: songNameController,
              ),
              const SizedBox(height: 20),
              ColorPicker(
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
                color: selectedColor,
                pickersEnabled: {ColorPickerType.wheel: true},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
