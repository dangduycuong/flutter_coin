import 'package:flutter/material.dart';

import '../../../data/coins/models/response/coin_ohlc_data/ohlc.dart';
import '../../../utils/external_package/candlesticks/lib/candlesticks.dart';
import '../../../utils/multi-languages/multi_languages_utils.dart';

class CandlesticksChart extends StatefulWidget {
  final List<OHLCItem> ohlcList;

  const CandlesticksChart({Key? key, required this.ohlcList}) : super(key: key);

  @override
  _CandlesticksChartState createState() => _CandlesticksChartState();
}

class _CandlesticksChartState extends State<CandlesticksChart> {
  List<Candle> candles = [];
  bool themeIsDark = false;

  String _convertTimeStampToHumanHour(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('MM:dd').format(dateToTimeStamp);
  }

  String formatStringToDateTime(String substring) {
    final DateFormat format = DateFormat('yyyy-MM-ddTHH:MM:ss');
    final dateFormat = format.parse(substring);
    final datePayment = DateFormat('yMMMMEEEEd').format(dateFormat);
    return datePayment;
  }

  DateTime _parseStringToDateTime(String dateString, String format) {
    return DateFormat(format).parse(dateString);
  }

  String _convertIntToDateTime(int timeStamp) {
    final dateFormat = DateFormat('dd-MM-yyyy hh:mm a');
    return dateFormat
        .format(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000));
  }

  void _settingDataChart() {
    for (final element in widget.ohlcList) {
      String dateString = _convertIntToDateTime(element.startingAt ?? 0);
      DateTime time = _parseStringToDateTime(dateString, 'dd-MM-yyyy hh:mm a');

      double high = double.parse(element.high ?? '');

      double low = double.parse(element.low ?? '');

      double open = double.parse(element.open ?? '');

      double close = double.parse(element.close ?? '');

      double avg = double.parse(element.avg ?? '');
      final Candle item = Candle(
        date: time,
        high: high,
        low: low,
        open: open,
        close: close,
        volume: avg,
      );

      candles.add(item);
    }
  }

  void _setupData() {
    for (final element in widget.ohlcList) {
      String dateString = _convertIntToDateTime(element.startingAt ?? 0);
      DateTime time = _parseStringToDateTime(dateString, 'dd-MM-yyyy hh:mm a');

      double high = double.parse(element.high ?? '');
      high = double.parse((high).toStringAsFixed(3));

      double low = double.parse(element.low ?? '');
      low = double.parse((low).toStringAsFixed(3));

      double open = double.parse(element.open ?? '');
      open = double.parse((open).toStringAsFixed(3));

      double close = double.parse(element.close ?? '');
      close = double.parse((close).toStringAsFixed(3));

      double avg = double.parse(element.avg ?? '');
      avg = double.parse((avg).toStringAsFixed(3));
      final Candle item = Candle(
        date: time,
        high: high,
        low: low,
        open: open,
        close: close,
        volume: avg,
      );

      candles.add(item);
    }
  }

  @override
  void initState() {
    // _setupData();
    _settingDataChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Candlesticks(
      candles: candles,
    );
  }
}
