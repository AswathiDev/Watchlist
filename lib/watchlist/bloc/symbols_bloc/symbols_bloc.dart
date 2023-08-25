import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:create_watchlist/watchlist/models/group_model.dart';
import 'package:create_watchlist/watchlist/respos/symbols_repo.dart';
import 'package:flutter/material.dart';

part 'symbols_event.dart';
part 'symbols_state.dart';

class SymbolsBloc extends Bloc<SymbolsBlocEvent, SymbolsBlocState> {
  List<GroupModel> _symbolsList = [];
  List<GroupModel> symbolLocalList = [];
    List<Map<String, dynamic>> result = [];
    List<String>name=['w','r','r'];


  SymbolsBloc() : super(SymbolsBlocInitial()) {
    on<SymbolInitialFetchEvent>(symbolInitialFetchEvent);
    on<SymbolSearchEvent>(symbolSearchEvent);
    on<SymbolAddToListEvent>(symbolAddToGroupEvent);
    on<SymbolsAddToGroupEvent>(symbolsAddToGroupEvent);
  }

 
  FutureOr<void> symbolInitialFetchEvent(
      SymbolInitialFetchEvent event, Emitter<SymbolsBlocState> emit) async {
    emit(SymbolsBlocInitialFetchLoadingState());

    _symbolsList = await SymbolsRepo.fetchPost();
    emit(SymbolsBlocInitialFetchSuccessState(symbols: _symbolsList));
  }

  FutureOr<void> symbolSearchEvent(
      SymbolSearchEvent event, Emitter<SymbolsBlocState> emit) {
  }

  FutureOr<void> symbolAddToGroupEvent(
      SymbolAddToListEvent event, Emitter<SymbolsBlocState> emit) {
    final existingCartItemIndex =
        _symbolsList.indexWhere((items) => items.id == event.groupModel.id);

    if (existingCartItemIndex != -1) {
      final updatedSymbol = _symbolsList;
      updatedSymbol[existingCartItemIndex] = GroupModel(
        id: event.groupModel.id,
        url: event.groupModel.url,
        checkedNew: event.checked,
        name: event.groupModel.name,
        contacts: event.groupModel.contacts,
      );

      _symbolsList = updatedSymbol;
    }

    if (event.checked) {
      if (!symbolLocalList.contains(event.groupModel)) {
        symbolLocalList.add(event.groupModel);
      }
    } else {
      symbolLocalList.remove(event.groupModel);

    }

    emit(SymbolsBlocInitialFetchSuccessState(symbols: _symbolsList));
  }

  FutureOr<void> symbolsAddToGroupEvent(SymbolsAddToGroupEvent event, Emitter<SymbolsBlocState> emit) {
// List<GroupModel> groupModels = event.symbolLocalList;
//  Map<String, List<String>> groupedData = {};
    //  List<Map<String, dynamic>> resultAll = event.result;

  // for (var groupModel in groupModels) {
  //   if (!groupedData.containsKey(groupModel.name)) {
  //     groupedData[groupModel.name] = [];
  //   }
  //   groupedData[groupModel.name]!.add(groupModel.id);
  // }
   symbolLocalList =[];

  Map<String, dynamic> groupMap = {
      'group_name': event.groupName,
      'symbols': event.symbolLocalList,
    };

      bool groupExists = result.any((item) => item['group_name'] == event.groupName);

    if (!groupExists) {
      result.add(groupMap);
    }
emit(SymbolsAddedToGroupSuccessState(result: result));
  // print(result);

  }
}
