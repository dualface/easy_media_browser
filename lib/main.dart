import 'package:easy_media_browser/browser_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/search_folder_manager.dart';

void main() {
  runApp(EasyMediaBrowserApp());
}

class EasyMediaBrowserApp extends StatelessWidget {
  EasyMediaBrowserApp({super.key}) {
    _manager.addFolder("E:\\dualface\\Downloads\\Movies");
    _manager.openFolder("/");
  }

  final _manager = SearchFolderManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Media Browser',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => _manager),
        ChangeNotifierProvider(create: (_) => _manager.mediaItems),
      ], child: const BrowserPage()),
    );
  }
}
