import 'package:flutter/material.dart';
import '../../../utils/external_package/candlesticks/lib/candlesticks.dart';

class CandlesticksChart extends StatefulWidget {
  final List<Candle> candles;

  const CandlesticksChart({Key? key, required this.candles}) : super(key: key);

  @override
  _CandlesticksChartState createState() => _CandlesticksChartState();
}

class _CandlesticksChartState extends State<CandlesticksChart> {
  @override
  Widget build(BuildContext context) {
    return Candlesticks(
      candles: widget.candles,
    );
  }
}
