import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../data/coins/models/response/list_coins/coins.dart';
import '../../../utils/multi-languages/multi_languages_utils.dart';
import '../../../utils/route/app_routing.dart';
import '../../common/loading_data.dart';
import '../bloc/coin_detail_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'candlesticks_chart.dart';

class CoinDetailInfoScreen extends StatefulWidget {
  final Coins? coin;

  const CoinDetailInfoScreen({Key? key, this.coin}) : super(key: key);

  @override
  _CoinDetailInfoScreenState createState() => _CoinDetailInfoScreenState();
}

class _CoinDetailInfoScreenState extends State<CoinDetailInfoScreen> {
  late CoinDetailBloc _bloc;
  final RefreshController _controller = RefreshController();

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

  Text _displayPrice(String? price) {
    // final price = _bloc.coin.price;
    double priceValue = 0.0;
    if (price != null) {
      double value = double.parse(price);
      priceValue = double.parse((value).toStringAsFixed(3));
    }

    var formatter = NumberFormat('#,###.###');

    return Text(
      '\$${formatter.format(priceValue).replaceAll(',', ' ')}',
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline4,
        fontSize: 12.r,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.teal,
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

  String _convertToTime(int timeStamp) {
    final dateFormat = DateFormat('HH:mm');
    return dateFormat
        .format(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000));
  }

  String _convertIntToDateTime(int timeStamp) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat
        .format(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000));
  }

  Text _setTitleText(String title) {
    return Text(
      title,
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline4,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Text _setHeaderTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline4,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Text _setDataText(String text, bool isNumber) {
    var formatter = NumberFormat('#,###');
    if (isNumber && text.contains('.')) {
      formatter = NumberFormat('#,###.###');

      double doubleValue = 0.0;
      double value = double.parse(text);
      doubleValue = double.parse((value).toStringAsFixed(3));

      return Text(
        formatter.format(doubleValue).replaceAll(',', ' '),
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 12.r,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ),
      );
    }
    return Text(
      isNumber
          ? formatter.format(int.parse(text).toInt()).replaceAll(',', ' ')
          : text,
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline4,
        fontSize: 12.r,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        color: Colors.black,
      ),
    );
  }

  Text _textMarketCap(int price) {
    var formatter = NumberFormat('#,###');
    return Text(
      '\$${formatter.format(price.toInt()).replaceAll(',', ' ')}',
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline4,
        fontSize: 12.r,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.teal,
      ),
    );
  }

  Widget _displayInterViewCoin() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1.w)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _setTitleText(
                      'Price at ${_convertToTime(_bloc.coin.priceAt ?? 0)}'),
                  _heightSpacing(8.h),
                  _displayPrice(_bloc.coin.price),
                  _heightSpacing(8.h),
                  _setTitleText('High price'),
                  _heightSpacing(8.h),
                  _displayPrice(_bloc.coin.allTimeHigh?.price),
                  _heightSpacing(8.h),
                  _setTitleText('MarketCap'),
                  _heightSpacing(8.h),
                  _textMarketCap(int.parse(_bloc.coin.marketCap ?? '')),
                  _heightSpacing(8.h),
                  _setTitleText('24h Volume'),
                  _heightSpacing(8.h),
                  _setDataText(_bloc.coin.volume ?? '0', true),
                  _heightSpacing(8.h),
                  _setTitleText('Circulating'),
                  _heightSpacing(8.h),
                  _setDataText(_bloc.coin.supply?.circulating ?? '0', true),
                ],
              ),
              _widthSpacing(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _setTitleText('24h change'),
                  _heightSpacing(8.h),
                  Text(
                    _changeValue(),
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 12.r,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: _colorChange(),
                    ),
                  ),
                  _heightSpacing(8.h),
                  _setTitleText('Total'),
                  _heightSpacing(8.h),
                  _setDataText(_bloc.coin.supply?.total ?? '0', true),
                  _heightSpacing(8.h),
                  _setTitleText('Listed At'),
                  _heightSpacing(8.h),
                  _setDataText(
                      _convertIntToDateTime(_bloc.coin.listedAt ?? 0), false),
                  _heightSpacing(8.h),
                  _setTitleText('Number Of Exchanges'),
                  _heightSpacing(8.h),
                  _setDataText('${_bloc.coin.numberOfExchanges}', true),
                  _heightSpacing(8.h),
                  _setTitleText('Number Of Markets'),
                  _heightSpacing(8.h),
                  _setDataText('${_bloc.coin.numberOfMarkets}', true),
                ],
              ),
              _widthSpacing(10.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _oneItem() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            _heightSpacing(16),
            SizedBox(
              width: 32,
              height: 32,
              child: _displayIcon(_bloc.coin.iconUrl),
            ),
            _heightSpacing(16),
            _setHeaderTitle(
                '${_bloc.coin.name ?? ''} (${_bloc.coin.symbol ?? ''})'),
            _heightSpacing(16),
            _displayInterViewCoin(),
            _heightSpacing(16),
            _setHeaderTitle('${_bloc.coin.symbol} 50 days Chart'),
            _heightSpacing(16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 0.75 * (MediaQuery.of(context).size.height).h,
                child: CandlesticksChart(
                  ohlcList: _bloc.ohlcList,
                ),
              ),
            ),
            _heightSpacing(32),
            _setHeaderTitle('What is ${_bloc.coin.name ?? ''}'),
            _heightSpacing(16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HtmlWidget(_bloc.coin.description ?? ''),
            ),
            _heightSpacing(32),
          ],
        );
      },
      itemCount: 1,
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

      if (state is LoadCoinPriceHistorySuccessState) {
        bodyView = _oneItem();
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
        body: SmartRefresher(
          controller: _controller,
          child: bodyView,
          enablePullUp: false,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            _controller.refreshCompleted();
            _bloc.add(LoadDetailCoinEvent('${widget.coin?.uuid}'));
          },
        ),
      );
    }, listener: (context, state) {
      if (state is LoadCoinDetailSuccessState) {
        _bloc.add(GetCoinPriceHistoryEvent());
      }

      if (state is LoadingCoinPriceHistoryState) {}

      if (state is LoadCoinPriceHistorySuccessState) {}
    });
  }
}
