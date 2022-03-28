import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coin/presentation/common/search_bar_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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

  String get titleAppBar {
    String result = '';
    switch (_selectedIndex) {
      case 0:
        result = 'List Coins';
        break;
      default:
        result = 'Favorite Coins';
        break;
    }
    return result;
  }

  static const List<Widget> _widgetOptions = <Widget>[
    ListAllCoinsView(),
    ListFavoriteCoinsView(),
  ];
  late ListCoinsBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<ListCoinsBloc>();
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
        title: Text(titleAppBar),
        actions: [
          CoinsOverviewFilterButton(
            onSelect: (filter) {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_selectedIndex == 0) {
                _bloc.add(CoinSortEvent(filter));
              } else {
                _bloc.add(SortFavoriteCoinsEvent(filter));
              }
            },
            defaultText: _selectedIndex == 0 ? 'Market cap' : 'Date Created',
          ),
        ],
      ),
      body: Center(
        // child: _widgetOptions.elementAt(_selectedIndex),
        child: Column(
          children: [
            SearchBarItem(
              textChangValue: (text) {
                if (_selectedIndex == 0) {
                  _bloc.add(SearchCoinsSuggestionsEvent(text));
                } else {
                  _bloc.add(SearchCoinsInLocalEvent(text));
                }
              },
            ),
            Expanded(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.select_all),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
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
  final String defaultText;

  const CoinsOverviewFilterButton(
      {Key? key, required this.onSelect, required this.defaultText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CoinsViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      onSelected: (filter) {
        onSelect(filter);
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: CoinsViewFilter.marketCap,
            child: Text(
              defaultText,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 16.r,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          PopupMenuItem(
            value: CoinsViewFilter.increment,
            child: Text(
              'Price: lowest first',
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 16.r,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          PopupMenuItem(
            value: CoinsViewFilter.decrement,
            child: Text(
              'Price: highest first',
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 16.r,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}

enum CoinsViewFilter {
  increment,
  decrement,
  marketCap,
}
