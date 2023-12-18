import 'package:easy_media_browser/const.dart';
import 'package:flutter/material.dart';

class FolderTitleWidget extends StatelessWidget {
  const FolderTitleWidget({super.key, required this.folderName});

  final String folderName;

  @override
  Widget build(BuildContext context) {
    return Text(folderName, style: folderTitleTextStyle);
  }
}
