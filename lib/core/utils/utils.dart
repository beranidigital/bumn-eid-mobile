import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bumn_eid/core/exceptions/unexpected_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {

  Future<bool> assetExists(String assetPath) async {
    final Uint8List encoded =
    utf8.encoder.convert(Uri(path: Uri.encodeFull(assetPath)).path);
    final ByteData asset = await defaultBinaryMessenger.send(
        'flutter/assets', encoded.buffer.asByteData());

    return asset != null;
  }

  T checkForNull<T>(T field) {
    if (field == null) throw CustomException(null, Exception("Field ${T.toString()} is empty!"));
    return field;
  }

  String convertImageFileToBase64(String assetPath) {
    File profilePictureFile = File(assetPath);
    List<int> profilePictureInt = profilePictureFile.readAsBytesSync();
    return base64Encode(profilePictureInt);
  }

}

Color getColorByJumlah( num jumlah) {
  if (jumlah >= 100) return Colors.green;
  if (jumlah >= 80) return Color(0xFF0D8B005);
  return Colors.redAccent;
}