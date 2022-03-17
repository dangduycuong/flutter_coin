import 'package:cached_network_image/cached_network_image.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/coins/models/response/list_coins/coins.dart';
import '../../../utils/route/app_routing.dart';
import '../../common/loading_data.dart';
import '../bloc/coin_detail_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinDetailScreen extends StatefulWidget {
  final Coins? coin;

  const CoinDetailScreen({Key? key, required this.coin}) : super(key: key);

  @override
  _CoinDetailScreenState createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  late CoinDetailBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<CoinDetailBloc>();
    _bloc.add(LoadDetailCoinEvent('${widget.coin?.uuid}'));
    super.initState();
  }

  Widget _displayIcon(String? link) {
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
        fit: BoxFit.fill,
      );
      return networkSvg;
    }
    return CachedNetworkImage(
      placeholder: (context, url) => const CircularProgressIndicator(),
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );
  }

  Widget _heightSpacing(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _widthSpacing(double width) {
    return SizedBox(
      width: width,
    );
  }

  Text _displayPrice() {
    final price = _bloc.coin.price;
    double priceValue = 0.0;
    if (price != null) {
      double value = double.parse(price);
      priceValue = double.parse((value).toStringAsFixed(3));
    }

    return Text(
      '\$$priceValue',
      style: GoogleFonts.lato(
        fontSize: 16.r,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _pushToWebView() {
    Navigator.pushNamed(
      context,
      RouteDefine.coinRankingWebViewScreen.name,
      arguments: _bloc.coin,
    );
  }

  Color _colorChange() {
    if (_bloc.coin.change != null) {
      final change = _bloc.coin.change ?? '';
      if (change.contains('-')) {
        return Colors.red;
      }
    }

    return Colors.green;
  }

  String _changeValue() {
    final change = _bloc.coin.change;
    if (change != null) {
      if (change.contains('-')) {
        return '$change%';
      }
    }
    return '+$change%';
  }

  Widget _displayCoinDetail(List<double> sparkline) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _heightSpacing(16),
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: _displayIcon(_bloc.coin.iconUrl),
                  ),
                  _heightSpacing(16),
                  Text(
                    '${_bloc.coin.name ?? ''} (${_bloc.coin.symbol ?? ''}) price',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  _heightSpacing(16),
                  Text('${_bloc.coin.symbol ?? ''} price chart'),
                  _heightSpacing(16),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.35),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.w)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price to USD',
                                style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              _heightSpacing(8.h),
                              _displayPrice(),
                            ],
                          ),
                          _widthSpacing(32.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '24h change',
                                style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              _heightSpacing(8.h),
                              Text(
                                _changeValue(),
                                style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 12.r,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  color: _colorChange(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _heightSpacing(32),
                  Sparkline(
                    lineWidth: 3,
                    fallbackHeight: (MediaQuery.of(context).size.height) / 4,
                    gridLineAmount: 7,
                    data: sparkline,
                    gridLinelabelPrefix: '\$',
                    gridLineLabelPrecision: 2,
                    enableGridLines: true,
                    fillMode: FillMode.none,
                  ),
                  _heightSpacing(64),
                  Text(
                    'What is ${_bloc.coin.name ?? ''}',
                    style: GoogleFonts.lato(
                      fontSize: 16.r,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _heightSpacing(16),
                  HtmlWidget(_bloc.coin.description ?? ''),
                  _heightSpacing(32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoinDetailBloc, CoinDetailState>(
        builder: (context, state) {
          Widget? bodyView;
          if (state is LoadingCoinDetailState) {
            bodyView = loadingData(context, 'Data loading...');
          }

          if (state is LoadCoinDetailSuccessState) {
            final List<double> sparkline = <double>[];
            if (_bloc.coin.sparkline != null) {
              for (final element in _bloc.coin.sparkline!) {
                double value = double.parse(element);
                double priceValue = double.parse((value).toStringAsFixed(3));
                sparkline.add(priceValue);
              }
            }
            bodyView = _displayCoinDetail(sparkline);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('${widget.coin?.name}'),
              actions: [
                IconButton(
                  onPressed: _pushToWebView,
                  icon: const Icon(Icons.description),
                ),
              ],
            ),
            body: bodyView,
          );
        },
        listener: (context, state) {});
  }
}
