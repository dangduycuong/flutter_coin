// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// import '../../../utils/multi-languages/multi_languages_utils.dart';
//
// class CoinPriceHistoryLineChart extends StatefulWidget {
//   final List<FlSpot> spots;
//
//   const CoinPriceHistoryLineChart({Key? key, required this.spots})
//       : super(key: key);
//
//   @override
//   _CoinPriceHistoryLineChartState createState() =>
//       _CoinPriceHistoryLineChartState();
// }
//
// class _CoinPriceHistoryLineChartState extends State<CoinPriceHistoryLineChart> {
//   List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];
//
//   bool showAvg = false;
//
//   double _intervalHorizontalAxis = 1; //khoang cach giua cac item truc hoanh
//   double _intervalVerticalAxis = 1; //khoang cach giua cac item truc tung
//
//   double _maxX = 0;
//   double _maxY = 0;
//   double _minX = 0;
//   double _minY = 0;
//   List<FlSpot> _dataChart = [];
//
//   void _setupDataForLineChart() {
//     _dataChart = widget.spots.reversed.toList();
//
//     double tempValue = 0;
//
//     List<double> tempList = [];
//     tempList = _dataChart.map((e) => e.x).toList();
//     tempList.sort((a, b) => a.compareTo(b));
//     _minX = tempList.first;
//     _maxX = tempList.last;
//     // tempValue = _maxX / tempList.length;
//     // _intervalHorizontalAxis = double.parse((tempValue).toStringAsFixed(0));
//
//     tempList = _dataChart.map((e) => e.y).toList();
//     tempList.sort((a, b) => a.compareTo(b));
//     _minY = tempList.first;
//     _maxY = tempList.last;
//     tempValue = _maxY / tempList.length;
//     _intervalVerticalAxis = double.parse((tempValue).toStringAsFixed(0));
//
//     print('cdd cac gia tri tinh toan duoc\n'
//         'mang data co ${_dataChart.length} phan tu\n$_dataChart\n'
//         '_maxX $_maxX\n'
//         '_maxY $_maxY\n'
//         '_intervalHorizontalAxis $_intervalHorizontalAxis\n'
//         '_intervalVerticalAxis $_intervalVerticalAxis');
//
//     for (final element in _dataChart) {
//       int timestamp = element.x.toInt();
//       print(_readTimestamp(timestamp));
//     }
//   }
//
//   String _convertTimeStampToHumanHour(int timeStamp) {
//     var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
//     return DateFormat('HH:mm').format(dateToTimeStamp);
//   }
//
//   String _readTimestamp(int timestamp) {
//     var now = DateTime.now();
//     var format = DateFormat('HH:mm a');
//     var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//     var diff = now.difference(date);
//     var time = '';
//
//     if (diff.inSeconds <= 0 ||
//         diff.inSeconds > 0 && diff.inMinutes == 0 ||
//         diff.inMinutes > 0 && diff.inHours == 0 ||
//         diff.inHours > 0 && diff.inDays == 0) {
//       time = format.format(date);
//     } else if (diff.inDays > 0 && diff.inDays < 7) {
//       if (diff.inDays == 1) {
//         time = diff.inDays.toString() + ' DAY AGO';
//       } else {
//         time = diff.inDays.toString() + ' DAYS AGO';
//       }
//     } else {
//       if (diff.inDays == 7) {
//         time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
//       } else {
//         time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
//       }
//     }
//
//     return time;
//   }
//
//   @override
//   void initState() {
//     _setupDataForLineChart();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 1.70,
//           child: Container(
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(18),
//                 ),
//                 color: Color(0xff232d37)),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   right: 18.0, left: 12.0, top: 24, bottom: 12),
//               child: LineChart(
//                 showAvg ? avgData() : mainData(),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 60,
//           height: 34,
//           child: TextButton(
//             onPressed: () {
//               setState(() {
//                 showAvg = !showAvg;
//               });
//             },
//             child: Text(
//               'avg',
//               style: TextStyle(
//                   fontSize: 12,
//                   color:
//                       showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   LineChartData mainData() {
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: SideTitles(showTitles: false),
//         topTitles: SideTitles(showTitles: false),
//         bottomTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 22,
//           interval: _intervalHorizontalAxis,
//           getTextStyles: (context, value) => const TextStyle(
//               color: Color(0xff68737d),
//               fontWeight: FontWeight.bold,
//               fontSize: 16),
//           getTitles: (value) {
//             // return _readTimestamp(value.toInt());
//             return _convertTimeStampToHumanHour(value.toInt());
//             switch (value.toInt()) {
//               case 2:
//                 return 'MAR';
//               case 5:
//                 return 'JUN';
//               case 8:
//                 return 'SEP';
//             }
//             return '';
//           },
//           margin: 8,
//         ),
//         leftTitles: SideTitles(
//           //ve truc tung
//           showTitles: true,
//           interval: _intervalVerticalAxis,
//           //cdd y
//           getTextStyles: (context, value) => const TextStyle(
//             color: Color(0xff67727d),
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//           ),
//           getTitles: (value) {
//             return '${value.toInt()}';
//             switch (value.toInt()) {
//               case 1:
//                 return '10k';
//               case 3:
//                 return '30k';
//               case 5:
//                 return '50k';
//             }
//             return '';
//           },
//           reservedSize: 32,
//           margin: 12,
//         ),
//       ),
//       borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: const Color(0xff37434d), width: 1)),
//       minX: _minX,
//       maxX: _maxX,
//       minY: _minY,
//       maxY: _maxY,
//       lineBarsData: [
//         LineChartBarData(
//           spots: _dataChart,
//           isCurved: true,
//           colors: gradientColors,
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             colors:
//                 gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   LineChartData avgData() {
//     return LineChartData(
//       lineTouchData: LineTouchData(enabled: false),
//       gridData: FlGridData(
//         show: true,
//         drawHorizontalLine: true,
//         verticalInterval: 1,
//         horizontalInterval: 1,
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 22,
//           getTextStyles: (context, value) => const TextStyle(
//               color: Color(0xff68737d),
//               fontWeight: FontWeight.bold,
//               fontSize: 16),
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 2:
//                 return 'MAR';
//               case 5:
//                 return 'JUN';
//               case 8:
//                 return 'SEP';
//             }
//             return '';
//           },
//           margin: 8,
//           interval: 1,
//         ),
//         leftTitles: SideTitles(
//           showTitles: true,
//           getTextStyles: (context, value) => const TextStyle(
//             color: Color(0xff67727d),
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//           ),
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 1:
//                 return '10k';
//               case 3:
//                 return '30k';
//               case 5:
//                 return '50k';
//             }
//             return '';
//           },
//           reservedSize: 32,
//           interval: 1,
//           margin: 12,
//         ),
//         topTitles: SideTitles(showTitles: false),
//         rightTitles: SideTitles(showTitles: false),
//       ),
//       borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: const Color(0xff37434d), width: 1)),
//       minX: 0,
//       maxX: 11,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 3.44),
//             FlSpot(2.6, 3.44),
//             FlSpot(4.9, 3.44),
//             FlSpot(6.8, 3.44),
//             FlSpot(8, 3.44),
//             FlSpot(9.5, 3.44),
//             FlSpot(11, 3.44),
//           ],
//           isCurved: true,
//           colors: [
//             ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                 .lerp(0.2)!,
//             ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                 .lerp(0.2)!,
//           ],
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             colors: [
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!
//                   .withOpacity(0.1),
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!
//                   .withOpacity(0.1),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
