import 'package:flutter/material.dart';

var bodyInsets = const EdgeInsets.fromLTRB(0, 80, 0, 80);

var folderTitleTextStyle = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white70);

var mediaBrowserPadding = const EdgeInsets.fromLTRB(20, 20, 20, 30);
var mediaItemMargin = const EdgeInsets.fromLTRB(20, 0, 20, 0);
var mediaItemSelectedBorder = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.yellow, style: BorderStyle.solid, width: 6));
var mediaItemNormalBorder = BoxDecoration(border: Border.all(style: BorderStyle.none));
var medidItemThumbMargin = const EdgeInsets.all(10);
var mediaTitlePadding = const EdgeInsets.fromLTRB(20, 10, 20, 10);
var mediaTitleBackgroundColor = const Color.fromARGB(64, 255, 255, 255);
var mediaTitleTextStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70);

var videoFileDefaultThumb = const Image(image: AssetImage('assets/images/video_file_default_thumb.png'));
var folderDefaultThumb = const Image(image: AssetImage('assets/images/folder_default_thumb.png'));
var parentFolderDefaultThumb = const Image(image: AssetImage('assets/images/parent_folder_default_thumb.png'));
