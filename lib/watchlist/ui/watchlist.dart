import 'package:flutter/material.dart';
import 'package:create_watchlist/watchlist/helpers/navigation_helper.dart';
import  'package:create_watchlist/watchlist/ui/search.dart';
import 'package:create_watchlist/watchlist/bloc/symbols_bloc/symbols_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late final SymbolsBloc _symbolBloc;

  TextEditingController groupNameController=TextEditingController();
    List<String> tabNames = ['Tab 1', 'Tab 2', 'Tab 3'];


    // List<String> groupNames = _symbolBloc?.result.map((group) => group["group_name"] as String).toList();

  void _dismissBottomSheet(BuildContext context) {


  NavigationHelper.closeCurrentScreen(context);
}
@override
  void initState() {
    super.initState();
    print('init state');
        _symbolBloc = BlocProvider.of<SymbolsBloc>(context); // Access the SymbolsBloc instance

  }
  void _createWatchlist() {
    groupNameController.clear();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(margin: const EdgeInsets.symmetric(vertical: 20),height:200,
              
              child:  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
               const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Create Watchlist',textAlign: TextAlign.left,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                ),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal:10.0),
                  child: TextField(
                    controller: groupNameController,
                    decoration: const InputDecoration(
                      label: Text('Enter watchlist name'),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.teal), onPressed:(){
                    _dismissBottomSheet(context);

                    Navigator.of(context).push(MaterialPageRoute(builder: (cntx)=> SearchScreen(groupName: groupNameController.text,bloc: _symbolBloc,)));
               
                // NavigationHelper.navigateToScreen(context, SearchScreen(groupName: groupNameController.text,));
                  } , child:const Text('Create',style: TextStyle(color: Colors.white),)),
                )
          
                
              ]),
            ),
          );
        });
  }

//   @override
//   Widget build(BuildContext context) {

//     return DefaultTabController(
//         length:_symbolBloc.result.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Watchlist',
//             style: TextStyle(color: Colors.white),
//           ),  bottom: TabBar(
//             tabs: tabNames.map((String tabName) {
//               return Tab(text: tabName);
//             }).toList(),

            
//           ),
//           backgroundColor: const Color.fromARGB(255, 10, 153, 132),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   _createWatchlist();
//                 },
//                 icon: const Icon(
//                   Icons.add,
//                   color: Colors.white,
//                 ))
//           ],
//         ),
//  body: TabBarView(
//           children: tabNames.map((String tabName) {
//             return Center(child: Text('Content of $tabName'));
//           }).toList(),
//         ),        
//       ),
//     );
//   }
@override
  Widget build(BuildContext context) {
    return BlocConsumer<SymbolsBloc, SymbolsBlocState>(
      bloc: _symbolBloc,
      listener: (context, state) {
        // ... listener code
      },
      builder: (context, state) {
        if (state is SymbolsAddedToGroupSuccessState) {
           final successState = state as SymbolsAddedToGroupSuccessState;
  tabNames = state.result.map((group) => group["group_name"] as String).toList();

          return DefaultTabController(
            length: state.result.length,
            child: Scaffold(
             appBar: AppBar(
          title: const Text(
            'Watchlist',
            style: TextStyle(color: Colors.white),
          ),  bottom: TabBar(
            // tabs: tabNames.map((String tabName) {
            //   return Tab(text: tabName);
            // }).toList(),
tabs:state.result.map((group){
return Tab(text:group["group_name"]);
}).toList(),
            
          ),
          backgroundColor: const Color.fromARGB(255, 10, 153, 132),
          actions: [
            IconButton(
                onPressed: () {
                  _createWatchlist();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
              body: TabBarView(
                children: state.result.map((group){
                  // return Center(child: Text(group["symbols"]));
                  return ListView.builder(
                  itemCount: group["symbols"].length,
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
                                    group["symbols"][index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(group["symbols"][index].contacts),
                                ],
                              ),
                            ),
                          ],
                        ),
                       
                        // ElevatedButton(onPressed: onPressed, child: Text('Click'))
                      ],
                    ),
                  ),
                );
                }).toList(),
              ),
            ),
          );
        } else {
           return  Scaffold(  appBar: AppBar(
          title: const Text(
            'Watchlist',
            style: TextStyle(color: Colors.white),
          ), 
           

            
          
          backgroundColor: const Color.fromARGB(255, 10, 153, 132),
          actions: [
            IconButton(
                onPressed: () {
                  _createWatchlist();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ), body: Text('Watchlist is empty')); // Loading state
        }
      },
    );
  }
}
