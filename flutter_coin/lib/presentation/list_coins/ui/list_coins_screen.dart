import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coin/utils/multi-languages/multi_languages_utils.dart';
import '../bloc/list_coins_bloc.dart';
import 'list_all_coins_view.dart';
import 'list_favorite_coins_view.dart';

typedef ViewFilterType = Function(CoinsViewFilter value);

class ListCoinsScreen extends StatefulWidget {
  const ListCoinsScreen({Key? key}) : super(key: key);

  @override
  _ListCoinsScreenState createState() => _ListCoinsScreenState();
}

class _ListCoinsScreenState extends State<ListCoinsScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ListAllCoinsView(),
    ListFavoriteCoinsView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coin Market"),
        actions: [
          CoinsOverviewFilterButton(
            onSelect: (filter) {
              context.read<ListCoinsBloc>().add(CoinSortEvent(filter));
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.select_all),
            label: LocaleKeys.allCoins,
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: LocaleKeys.favoriteCoins,
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class CoinsOverviewFilterButton extends StatelessWidget {
  final ViewFilterType onSelect;

  const CoinsOverviewFilterButton({Key? key, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;

    // final activeFilter =
    // context.select((TodosOverviewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<CoinsViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      // initialValue: activeFilter,
      // tooltip: l10n.todosOverviewFilterTooltip, price,
      //   marketCap,
      //   volume24h,
      //   change,
      //   listedAt,
      onSelected: (filter) {
        onSelect(filter);
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: CoinsViewFilter.marketCap,
            child: Text('Mặc định'),
          ),
          const PopupMenuItem(
            value: CoinsViewFilter.price_increment,
            child: Text('Giá tăng dần'),
          ),
          const PopupMenuItem(
            value: CoinsViewFilter.price_decrement,
            child: Text('Giá giảm dần'),
          ),
          const PopupMenuItem(
            value: CoinsViewFilter.volume24h,
            child: Text('volume24h'),
          ),
          const PopupMenuItem(
            value: CoinsViewFilter.change,
            child: Text('change'),
          ),
          const PopupMenuItem(
            value: CoinsViewFilter.listedAt,
            child: Text('listedAt'),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}

enum CoinsViewFilter {
  price_increment,
  price_decrement,
  marketCap,
  volume24h,
  change,
  listedAt,
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
