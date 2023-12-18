import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as libpath;

import 'media_item.dart';

class SearchFolder {
  const SearchFolder({required this.path});
  final String path;

  bool contains(String path) {
    return this.path == path || libpath.isWithin(this.path, path);
  }
}

class SearchFolderManager extends ChangeNotifier {
  SearchFolderManager() {
    mediaItems.addListener(() {
      if (mediaItems.selectedIndex >= 0) {
        _indexInFolders[_currentPath] = mediaItems.selectedIndex;
      }
    });
  }

  final mediaItems = MediaItems();

  String get currentPath => _currentPath;

  String _currentPath = "";
  final List<SearchFolder> _folders = [];
  final Map<String, int> _indexInFolders = {};

  void addFolder(String path) {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      throw Exception("Folder does not exist: $path");
    }

    path = libpath.absolute(dir.absolute.path);

    for (final folder in _folders) {
      if (folder.path == path) {
        return;
      }
    }

    _folders.add(SearchFolder(path: path));
  }

  void removeFolder(String path) {
    path = libpath.absolute(path);

    for (var i = 0; i < _folders.length; i++) {
      if (_folders[i].path == path) {
        _folders.removeAt(i);
        return;
      }
    }
  }

  void openFolder(String path) {
    mediaItems.clear();

    if (path == "/") {
      _openRootFolder();
    } else if (path == "..") {
      _openParentFolder();
    } else {
      _openSpecifiedFolder(path);
    }
  }

  void _openRootFolder() {
    for (var folder in _folders) {
      mediaItems.append(MediaItem(type: MediaItemType.folder, name: folder.path));
    }

    _currentPath = "/";

    if (_indexInFolders.containsKey("/")) {
      mediaItems.setSelected(_indexInFolders["/"]!);
    } else {
      _indexInFolders["/"] = 0;
      mediaItems.setSelected(0);
    }

    notifyListeners();
  }

  void _openParentFolder() {
    if (_currentPath == "/") {
      _openRootFolder();
      return;
    }

    final parentFolder = Directory(_currentPath).parent.path;
    for (final folder in _folders) {
      if (folder.contains(parentFolder)) {
        _openSpecifiedFolder(folder.path);
        return;
      }
    }

    _openRootFolder();
  }

  void _openSpecifiedFolder(String path) async {
    final folders = List<MediaItem>.empty(growable: true);
    final files = List<MediaItem>.empty(growable: true);

    final entries = Directory(path).listSync(recursive: false, followLinks: false);
    for (final entity in entries) {
      if (entity is File) {
        files.add(MediaItem(type: MediaItemType.video, name: entity.path));
      } else if (entity is Directory) {
        folders.add(MediaItem(type: MediaItemType.folder, name: entity.path));
      }
    }

    mediaItems.append(MediaItem(type: MediaItemType.parentFolder, name: ".."));

    for (var folder in folders) {
      mediaItems.append(folder);
    }
    for (var file in files) {
      mediaItems.append(file);
    }

    _currentPath = path;

    if (_indexInFolders.containsKey(path)) {
      mediaItems.setSelected(_indexInFolders[path]!);
    } else {
      _indexInFolders[path] = 0;
      mediaItems.setSelected(0);
    }

    notifyListeners();
  }
}
