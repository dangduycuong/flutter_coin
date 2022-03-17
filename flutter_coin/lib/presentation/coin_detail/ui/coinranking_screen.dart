import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/coins/models/response/list_coins/coins.dart';

class CoinRankingWebViewScreen extends StatefulWidget {
  const CoinRankingWebViewScreen({Key? key, required this.coin})
      : super(key: key);

  final Coins coin;

  @override
  _CoinRankingWebViewScreenState createState() =>
      _CoinRankingWebViewScreenState();
}

class _CoinRankingWebViewScreenState extends State<CoinRankingWebViewScreen> {
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("${widget.coin.name}",
              style: const TextStyle(fontWeight: FontWeight.w700)),
          centerTitle: true),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: "${widget.coin.coinrankingUrl}",
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? const Center(
                  // child: CircularProgressIndicator(),
                  child: CupertinoActivityIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
