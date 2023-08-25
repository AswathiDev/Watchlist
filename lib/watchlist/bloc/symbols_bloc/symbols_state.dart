part of 'symbols_bloc.dart';

@immutable
abstract class SymbolsBlocState {


}
abstract class SymbolsBlocActionState {}


final class SymbolsBlocInitial extends SymbolsBlocState {}

final class SymbolsBlocInitialFetchSuccessState extends SymbolsBlocState {
 final List<GroupModel> symbols;

  SymbolsBlocInitialFetchSuccessState({required this.symbols});
}
final class SymbolsBlocInitialFetchLoadingState extends SymbolsBlocState {

}

final class SymbolsSearchState extends SymbolsBlocActionState {}
final class SymbolsAddedToListState extends SymbolsBlocState {
 final bool status;

  SymbolsAddedToListState({required this.status});
}final class SymbolsAddedToGroupSuccessState extends SymbolsBlocState {
  final List<Map<String, dynamic>> result;
SymbolsAddedToGroupSuccessState({required this.result});
}