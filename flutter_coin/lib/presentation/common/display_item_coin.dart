import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

Text _displayPrice(String? price, Color textColor) {
  double priceValue = 0.0;
  if (price != null) {
    double value = double.parse(price);
    priceValue = double.parse((value).toStringAsFixed(3));
  }

  return Text(
    '$priceValue',
    style: GoogleFonts.lato(
      fontSize: 16.r,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
  );
}

String getSymbol(String? symbol) {
  if (symbol != null) {
    if (symbol.length > 5) {
      String result = symbol.substring(0, 4);
      result += '...';
      return result;
    } else {
      return symbol;
    }
  }
  return '';
}

Color colorChange(Coins coin) {
  if (coin.change != null) {
    final change = coin.change ?? '';
    if (change.contains('-')) {
      return Colors.red;
    }
  }

  return Colors.green;
}

String changeValue(Coins coin) {
  final change = coin.change;
  if (change != null) {
    if (change.contains('-')) {
      return '$change%';
    }
  }
  return '+$change%';
}

Text valueChangeText(Coins coin, BuildContext context) {
  return Text(
    changeValue(coin),
    style: GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.headline4,
      fontSize: 16.r,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      color: colorChange(coin),
    ),
  );
}

Text coinNameText({required Coins coin, required Color textColor}) {
  String coinName = coin.name ?? '';
  if (coinName.length > 15) {
    coinName = coinName.substring(0, 14);
    coinName += '...';
  }
  return Text(
    coinName,
    style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
  );
}

Card displayItemCoin({
  required Coins coin,
  required BuildContext context,
  required List<double> sparkline,
  required bool isFavorite,
  required FavoriteChangValue onchange,
}) {
  Color symbolColor = coin.color == '#000000' || coin.color == '#0e0436'
      ? Colors.white
      : Colors.black54;
  Color textColor = coin.color == '#000000' || coin.color == '#0e0436'
      ? Colors.white
      : Colors.black;
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
                coinNameText(coin: coin, textColor: textColor),
                widthSpacing(8),
                Text(
                  getSymbol('${coin.symbol}'),
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: symbolColor,
                  ),
                ),
              ],
            ),
            heightSpacing(8),
            Row(
              children: [
                Text(
                  "\$",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: textColor),
                ),
                _displayPrice(coin.price, textColor),
                widthSpacing(8),
                valueChangeText(coin, context),
              ],
            ),
            heightSpacing(8),
          ],
        ),
        widthSpacing(4),
        Expanded(
            child: Column(
          children: [
            heightSpacing(4),
            Sparkline(
              data: sparkline,
            ),
            heightSpacing(4),
          ],
        )),
        widthSpacing(4),
        InkWell(
          onTap: () {
            onchange(!isFavorite);
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
            color: isFavorite ? Colors.red : Colors.white,
            semanticLabel: isFavorite ? 'Remove from saved' : 'Save',
          ),
        ),
        widthSpacing(4),
      ],
    ),
  );
}
