import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/coins/models/response/list_coins/coins.dart';
import '../list_coins/ui/list_coins_screen.dart';
import 'display_icon.dart';

typedef FavoriteChangValue = Function(bool value);

SizedBox widthSpacing(double width) {
  return SizedBox(
    width: width,
  );
}

SizedBox heightSpacing(double height) {
  return SizedBox(
    height: height,
  );
}

Card displayItemCoin({
  required Coins coin,
  required BuildContext context,
  required List<double> sparkline,
  required bool isFavorite,
  required FavoriteChangValue onchange,
}) {
  return Card(
    color: HexColor.fromHex(coin.color ?? '#2DCFCC'),
    elevation: 8,
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        widthSpacing(8),
        SizedBox(
          width: 32,
          height: 32,
          child: displayIcon(coin.iconUrl),
        ),
        widthSpacing(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpacing(8),
            Row(
              children: [
                Text(
                  '${(coin.name)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                widthSpacing(8),
                Text(
                  '${coin.symbol}',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            heightSpacing(8),
            Row(
              children: [
                const Text(
                  "\$",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${coin.price}'),
              ],
            ),
            heightSpacing(8),
          ],
        ),
        Expanded(
            child: Sparkline(
          data: sparkline,
        )),
        InkWell(
          onTap: () {
            onchange(!isFavorite);
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
            semanticLabel: isFavorite ? 'Remove from saved' : 'Save',
          ),
        ),
      ],
    ),
  );
}
