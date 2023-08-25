part of 'symbols_bloc.dart';

@immutable
abstract class SymbolsBlocEvent {}
class SymbolInitialFetchEvent extends SymbolsBlocEvent{
}
class SymbolLoadingEvent extends SymbolsBlocEvent{}

class SymbolSearchEvent extends SymbolsBlocEvent{
 final String searchText;
  SymbolSearchEvent({required this.searchText});
}

class SymbolAddToListEvent extends SymbolsBlocEvent{
final  GroupModel groupModel;
 final bool checked;
  SymbolAddToListEvent({required this.groupModel,required this.checked});
}
class SymbolsAddToGroupEvent extends SymbolsBlocEvent{
 final String groupName;
    List<GroupModel> symbolLocalList = [];
    // List<Map<String, dynamic>> result = [];

  SymbolsAddToGroupEvent({required this.groupName,required this.symbolLocalList});
}
class SymbolsAddToGroupSuccessEvent extends SymbolsBlocEvent{}
