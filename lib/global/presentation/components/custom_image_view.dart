import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageView extends StatefulWidget {
  //AmirHamza
  // final String? imageUrl;
  // final String? assetsPath;
  // final String? filePath;
  final CustomImageType imageType;
  final String? imageData;
  final double? height;
  final double? width;
  final double clipBorderRadius;
  final bool isOval;
  final Color borderColor;
  final double borderWidth;
  final BoxFit? boxFit;
  final FilterQuality filterQuality;
  final PlaceHolderType placeHolderType;
  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;
  final double? iconWeight;

  const CustomImageView(
      {required this.imageType,
      //   this.imageUrl,
      // this.assetsPath,
      // this.filePath,
      this.imageData,
      this.height,
      this.width,
      this.clipBorderRadius = 0.0,
      this.isOval = false,
      this.borderColor = Colors.white,
      this.borderWidth = 0.0,
      this.boxFit,
      this.filterQuality = FilterQuality.low,
      this.placeHolderType = PlaceHolderType.regular,
      this.iconData,
      this.iconSize,
      this.iconColor,
      this.iconWeight,
      super.key});

  @override
  State<CustomImageView> createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  @override
  Widget build(BuildContext context) {
    if (widget.imageType == CustomImageType.network &&
        widget.imageData == null) {
      throw ArgumentError('imageData is null, Image Url is required');
    } else if (widget.imageType == CustomImageType.assets &&
        widget.imageData == null) {
      throw ArgumentError('imageData is null, Asset Path is required');
    } else if (widget.imageType == CustomImageType.file &&
        widget.imageData == null) {
      throw ArgumentError('imageData is null, File path is required');
    } else if (widget.imageType == CustomImageType.icon &&
        widget.iconData == null) {
      throw ArgumentError('iconData is null, IconData is required');
    }
    return widget.borderWidth == 0
        ? (widget.isOval
            ? ClipOval(
                child: imageBody(),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(widget.clipBorderRadius),
                child: imageBody(),
              ))
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(widget.clipBorderRadius),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 0)),
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 0)),
              ],
            ),
            child: (widget.isOval
                ? ClipOval(
                    child: imageBody(),
                  )
                : ClipRRect(
                    borderRadius:
                        BorderRadius.circular(widget.clipBorderRadius),
                    child: imageBody(),
                  )));
  }

  Widget imageBody() {
    return widget.imageType == CustomImageType.network
        ? widget.imageData == null
            ? placeholder()
            : CachedNetworkImage(
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: widget.imageData!,
                height: widget.height,
                width: widget.width,
                fit: widget.boxFit,
                filterQuality: widget.filterQuality,
                errorWidget: (context, a, b) => placeholder(),
              )
        // Image.network(
        //             widget.imageUrl!,
        //             height: widget.height,
        //             width: widget.width,
        //             fit: widget.boxFit,
        //             errorBuilder: (context, a, b) => placeholder(),
        //           )
        : widget.imageType == CustomImageType.icon
            ? widget.iconData == null
                ? placeholder()
                : Icon(
                    widget.iconData,
                    size: widget.iconSize,
                    color: widget.iconColor,
                    weight: widget.iconWeight,
                  )
            : widget.imageType == CustomImageType.file
                ? widget.imageData == null
                    ? placeholder()
                    : Image.file(
                        File(widget.imageData!),
                        height: widget.height,
                        width: widget.width,
                        fit: widget.boxFit,
                        errorBuilder: (context, a, b) => placeholder(),
                        filterQuality: widget.filterQuality,
                      )
                : widget.imageType == CustomImageType.assets
                    ? widget.imageData == null
                        ? placeholder()
                        : Image.asset(
                            widget.imageData!,
                            height: widget.height,
                            width: widget.width,
                            fit: widget.boxFit,
                            filterQuality: widget.filterQuality,
                            errorBuilder: (context, a, b) => placeholder(),
                          )
                    : placeholder();
  }

  String regularAsset = 'assets/images/person.jpg';
  String profileAsset = 'assets/images/person.jpg';

  Widget placeholder() => Image.asset(
        height: widget.height,
        width: widget.width,
        fit: widget.boxFit,
        widget.placeHolderType == PlaceHolderType.regular
            ? regularAsset
            : profileAsset,
        filterQuality: widget.filterQuality,
      );
}

enum CustomImageType { assets, network, file, icon }

enum PlaceHolderType { regular, person }
