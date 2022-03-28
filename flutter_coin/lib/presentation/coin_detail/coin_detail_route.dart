import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coin/presentation/coin_detail/ui/coin_detail_info_screen.dart';

import '../../data/coins/models/response/list_coins/coins.dart';
import '../../domain/coins/repositories/coins_repository.dart';
import '../../domain/coins/use_cases/list_coins_usecase.dart';
import '../../utils/di/injection.dart';
import 'bloc/coin_detail_bloc.dart';

class CoinDetailRoute {
  static Widget route({required Coins coin}) => BlocProvider(
        create: (context) => CoinDetailBloc(
          CoinsUseCase(
            getIt<CoinsRepository>(),
          ),
        ),
        child: CoinDetailInfoScreen(
          coin: coin,
        ),
      );
}
