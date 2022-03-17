import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time/time.dart';

part 'list_user_event.dart';

part 'list_user_state.dart';

class ListUserBloc extends Bloc<ListUserEvent, ListUserState> {
  List<String> items = [];

  ListUserBloc() : super(ListUserInitial());

  ///Please using new version implement of bloc
  Stream<ListUserState> mapEventToState(
    ListUserEvent event,
  ) async* {
    if (event is GetListUser) {
      yield* _mapGetListUserToState();
    }
    if (event is LoadMoreUser) {
      yield* _mapLoadMoreListUserToState();
    }
  }

  Stream<ListUserState> _mapGetListUserToState() async* {
    yield LoadingListUser();
    await 500.milliseconds.delay;
    items = ["1", "2", "3", "4", "5", "6", "7", "8"];
    yield ShowListUser(items);
  }

  Stream<ListUserState> _mapLoadMoreListUserToState() async* {
    yield LoadingListUser();
    await 2.seconds.delay;
    var lastItem = int.parse(items.last);
    items.addAll(
      [
        (lastItem + 1).toString(),
        (lastItem + 2).toString(),
        (lastItem + 3).toString(),
      ],
    );
    yield ShowListUser(items);
  }
}
