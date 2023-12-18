import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../const.dart';
import '../model/media_item.dart';
import '../model/search_folder_manager.dart';
import 'media_item_widget.dart';
import 'status_bar_widget.dart';

class BrowserWidget extends StatefulWidget {
  const BrowserWidget({super.key});

  @override
  State<BrowserWidget> createState() => _BrowserWidgetState();
}

class _BrowserWidgetState extends State<BrowserWidget> {
  final FocusNode _textNode = FocusNode();
  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();
  bool _lastKeyWasFunction = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchFolderManager>(builder: (c, manager, __) => _buildWidget(c, manager));
  }

  Widget _buildWidget(BuildContext context, SearchFolderManager manager) {
    final browserContents = Consumer<MediaItems>(
        builder: (_, mediaItems, __) => Container(
            color: Theme.of(context).colorScheme.surface,
            constraints: const BoxConstraints.expand(),
            child: ScrollablePositionedList.builder(
              itemCount: mediaItems.length,
              itemScrollController: _itemScrollController,
              itemPositionsListener: _itemPositionsListener,
              padding: mediaBrowserPadding,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                var item = mediaItems.get(index);
                return ChangeNotifierProvider(create: (_) => item, child: MediaItemWidget(item: item));
              },
            )));

    final contents = Column(children: [
      Expanded(child: browserContents),
      const StatusBarWidget(),
    ]);

    return KeyboardListener(
        focusNode: _textNode, autofocus: true, onKeyEvent: (e) => handleKey(e, manager), child: contents);
  }

  handleKey(KeyEvent e, SearchFolderManager manager) {
    if (e is! KeyDownEvent) {
      _lastKeyWasFunction = false;
      return;
    }

    if (_lastKeyWasFunction) {
      return;
    }

    final mediaItems = manager.mediaItems;
    final selectedIndex = mediaItems.selectedIndex;
    var newIndex = selectedIndex;

    switch (e.logicalKey) {
      case LogicalKeyboardKey.arrowRight:
        _lastKeyWasFunction = true;
        newIndex++;
        break;
      case LogicalKeyboardKey.arrowLeft:
        _lastKeyWasFunction = true;
        newIndex--;
        break;
      case LogicalKeyboardKey.space || LogicalKeyboardKey.enter:
        _lastKeyWasFunction = true;
        manager.openFolder(mediaItems.selected.name);
        Future.delayed(const Duration(milliseconds: 100), () {
          _itemScrollController.scrollTo(index: mediaItems.selectedIndex, duration: const Duration(milliseconds: 150));
        });
        break;
      case LogicalKeyboardKey.backspace:
        _lastKeyWasFunction = true;
        manager.openFolder("..");
        Future.delayed(const Duration(milliseconds: 100), () {
          _itemScrollController.scrollTo(index: mediaItems.selectedIndex, duration: const Duration(milliseconds: 150));
        });
        break;
    }

    if (newIndex != selectedIndex && newIndex >= 0 && newIndex < mediaItems.length) {
      mediaItems.setSelected(newIndex);
      _itemScrollController.scrollTo(
          index: newIndex, duration: const Duration(milliseconds: 150), curve: Curves.easeInOutCubic);
    }
  }
}
