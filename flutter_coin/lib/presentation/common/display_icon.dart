import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget displayIcon(String? link) {
  String imageUrl = link ?? 'https://site-that-takes-a-while.com/image.svg';
  String newString = imageUrl.substring(imageUrl.length - 4);
  if (newString == ".svg") {
    final Widget networkSvg = SvgPicture.network(
      imageUrl,
      semanticsLabel: 'A shark?!',
      placeholderBuilder: (BuildContext context) => Container(
        padding: const EdgeInsets.all(8.0),
        child: const CircularProgressIndicator(),
      ),
      fit: BoxFit.cover,
    );
    return networkSvg;
  }
  return CachedNetworkImage(
    placeholder: (context, url) => const CircularProgressIndicator(),
    imageUrl: imageUrl,
    fit: BoxFit.cover,
  );
}
