import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/search_folder_manager.dart';
import 'widgets/browser_widget.dart';
import 'widgets/folder_title_widget.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({super.key});

  static const String routeName = '/browser';

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchFolderManager>(builder: (c, manager, __) => _buildWidget(c, manager));
  }

  Widget _buildWidget(BuildContext context, SearchFolderManager manager) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: FolderTitleWidget(folderName: manager.currentPath.replaceAll("\\", "/")),
      ),
      body: const BrowserWidget(),
    );
  }
}
