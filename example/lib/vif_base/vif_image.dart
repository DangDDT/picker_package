// ignore_for_file: unused_import

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:vif_flutter_base/vif_flutter_base.dart';
import 'package:flutter/material.dart';

class VIFImage extends VIFImageDataSource {
  @override
  Widget asset(String name, {BoxFit? fit, double? width, double? height}) => Image.asset(
        name,
        fit: fit,
        width: width,
        height: height,
      );

  @override
  Widget memory(Uint8List bytes, {BoxFit? fit, double? width, double? height}) => Image.memory(
        bytes,
        fit: fit,
        width: width,
        height: height,
      );

  @override
  Widget file(File file, {BoxFit? fit, double? width, double? height}) => Image.file(
        file,
        fit: fit,
        width: width,
        height: height,
      );

  @override
  Widget network(String src, {BoxFit? fit, double? width, double? height}) => Image.network(
        src,
        fit: fit,
        width: width,
        height: height,
      );
}
