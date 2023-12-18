import 'package:easy_media_browser/const.dart';
import 'package:easy_media_browser/model/media_item.dart';
import 'package:flutter/material.dart';

class MediaItemWidget extends StatelessWidget {
  const MediaItemWidget({super.key, required this.item});
  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    String titleText = item.name;
    late Image thumbImage;
    double aspectRatio = 16 / 10;

    if (item.thumb.isNotEmpty) {
      thumbImage = Image(image: AssetImage(item.thumb));
    } else {
      switch (item.type) {
        case MediaItemType.folder:
          titleText = "[ $titleText ]";
          thumbImage = folderDefaultThumb;
          aspectRatio = 3 / 4;
          break;
        case MediaItemType.parentFolder:
          titleText = "[ $titleText ]";
          thumbImage = parentFolderDefaultThumb;
          aspectRatio = 3 / 4;
          break;
        case MediaItemType.video:
          thumbImage = videoFileDefaultThumb;
      }
    }

    final title = FittedBox(child: Text(titleText, textAlign: TextAlign.center, style: mediaTitleTextStyle));
    final titleBox = Container(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
            height: 60,
            child: Container(
                constraints: const BoxConstraints.expand(),
                padding: mediaTitlePadding,
                color: mediaTitleBackgroundColor,
                child: title)));

    return Container(
        margin: mediaItemMargin,
        child: DecoratedBox(
          decoration: item.isSelected ? mediaItemSelectedBorder : mediaItemNormalBorder,
          child: Container(
            margin: medidItemThumbMargin,
            color: Colors.black45,
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Stack(children: [
                thumbImage,
                titleBox,
              ]),
            ),
          ),
        ));
  }
}
