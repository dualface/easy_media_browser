import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/media_item.dart';

class StatusBarWidget extends StatelessWidget {
  const StatusBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MediaItems>(builder: (_, mediaItems, __) => _buildWidget(context, mediaItems));
  }

  Widget _buildWidget(BuildContext context, MediaItems mediaItems) {
    return SizedBox(
        height: 40,
        child: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white30,
            child: Center(
                child: Text(
              "Items: ${mediaItems.selectedIndex + 1} / ${mediaItems.length}",
              style: const TextStyle(fontSize: 20),
            ))));
  }
}
