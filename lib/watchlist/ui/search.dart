import 'package:create_watchlist/watchlist/ui/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:create_watchlist/watchlist/bloc/symbols_bloc/symbols_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.groupName, required this.bloc});
  final String groupName;
  final SymbolsBloc bloc;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // SymbolsBloc symbols_bloc = SymbolsBloc();

  @override
  void initState() {
    super.initState();
    widget.bloc.add(SymbolInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Symbols'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Symbols 1'),
              Tab(text: 'Symbols 2'),
              Tab(text: 'Symbols 3'),
              Tab(text: 'Symbols 4'),
              Tab(text: 'Symbols 5'),
            ],
          ),
        ),
        body: TabBarView(children: [
          tabItemScreen(0, 20),
          tabItemScreen(20, 40),
          tabItemScreen(40, 60),
          tabItemScreen(60, 80),
          tabItemScreen(80, 100),
        ]),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          widget.bloc.add(SymbolSearchEvent(searchText: value));
        },
        decoration: const InputDecoration(
          labelText: 'Search',
          hintText: 'Search for something...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
void _showValidationMsg(){

showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Symbols not Selected'),
                content:
                    const Text('Select atleast 1 symbol to create a group'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // NavigationHelper.navigatePop(context);
                      },
                      child: const Text('Ok'))
                ],
              ));
}
  Widget tabItemScreen(int a, int b) {
    return Column(children: [
      _buildSearchBar(),
      BlocConsumer<SymbolsBloc, SymbolsBlocState>(
        bloc: widget.bloc,
        listener: (context, state) {
              // if(state is SymbolsAddedToGroupSuccessState){

              // }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case SymbolsBlocInitialFetchLoadingState:
              return const Center(child: CircularProgressIndicator());
            case SymbolsBlocInitialFetchSuccessState:
              final successState = state as SymbolsBlocInitialFetchSuccessState;
              final dataList = successState.symbols.sublist(a, b);

              // print(successState.symbols);
              return Expanded(
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 164, 231, 221),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataList[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(dataList[index].contacts),
                                ],
                              ),
                            ),
                          ],
                        ),
                        dataList[index].checkedNew
                            ? IconButton(
                                onPressed: () {
                                  widget.bloc.add(SymbolAddToListEvent(
                                      groupModel: dataList[index],
                                      checked: false));
                                },
                                icon: const Icon(
                                  Icons.check_circle_sharp,
                                  size: 30,
                                ))
                            : IconButton(
                                onPressed: () {
                                  widget.bloc.add(SymbolAddToListEvent(
                                      groupModel: dataList[index],
                                      checked: true));
                                },
                                icon: const Icon(
                                  Icons.check_circle_outline_sharp,
                                  size: 30,
                                ))
                        // ElevatedButton(onPressed: onPressed, child: Text('Click'))
                      ],
                    ),
                  ),
                ),
              );
            default:
              return const SizedBox(
                height: 10,
              );
          }
        },
      ),
      //  Container(
      //     padding: const EdgeInsets.all(1.0),
      //     child:

      ElevatedButton(
        onPressed: () {
          // Handle button press here
          if (widget.bloc.symbolLocalList.isNotEmpty) {
            widget.bloc.add(SymbolsAddToGroupEvent(
                groupName: widget.groupName,
                symbolLocalList: widget.bloc.symbolLocalList));
Navigator.of(context).pop();
                // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const WatchlistScreen()));
          } else {
_showValidationMsg();
            // print("no items found");
          }
        },
        child: const Text('Create Group'),
      ),
      // ),
    ]);
  }
}
