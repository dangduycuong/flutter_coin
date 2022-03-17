import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_coin/data/login/models/request/login_request.dart';
import 'package:flutter_coin/data/login/models/response/coin.dart';
import 'package:flutter_coin/data/utils/exceptions/api_exception.dart';
import 'package:flutter_coin/domain/login/usecases/login_usecase.dart';
import 'package:flutter_coin/presentation/login/ui/login_screen.dart';

import '../../../data/login/models/request/coin_header_request.dart';
import '../../../data/login/models/request/coin_params_request.dart';
import '../../../data/login/models/response/coin_response_model.dart';

part 'login_event.dart';

part 'login_state.dart';


