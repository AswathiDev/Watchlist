import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<WatchlistEvent>((event, emit) {
    });
  }
}
