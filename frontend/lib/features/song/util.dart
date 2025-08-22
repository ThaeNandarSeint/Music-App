import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickFile(FileType type) async {
  try {
    final result = await FilePicker.platform.pickFiles(type: type);
    if (result != null && result.files.isNotEmpty) {
      return File(result.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
