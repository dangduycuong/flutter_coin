import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coin/presentation/list_coins/ui/list_coins_screen.dart';
import 'package:flutter_coin/utils/di/injection.dart';

import '../../domain/coins/repositories/list_coins_repository.dart';
import '../../domain/coins/use_cases/list_coins_usecase.dart';
import 'bloc/list_coins_bloc.dart';

class ListCoinsRoute {
  static Widget get route => BlocProvider(
        create: (context) => ListCoinsBloc(
          CoinsUseCase(
            getIt<CoinsRepository>(),
          ),
        ),
        child: const ListCoinsScreen(),
      );
}
