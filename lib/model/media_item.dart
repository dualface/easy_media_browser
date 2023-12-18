import 'react_list.dart';

enum MediaItemType { video, folder, parentFolder }

class MediaItem extends ReactItem {
  MediaItem({required this.type, required this.name, this.thumb = "", super.isSelected = false});

  MediaItemType type;
  String name = "";
  String thumb = "";
}

typedef MediaItems = ReactList<MediaItem>;
