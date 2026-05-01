import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_web/data/providers/search_provider/search_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

//search controller
TextEditingController search=TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context,provider,child) {
        return Scaffold(

            body:
             ListView(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: Row(
                     children: [
                       Expanded(
                         child: Card(
                           //search text form field

                           child: TextFormField(
                             controller: search,
                             decoration: InputDecoration(
                                 hintText: '   Search Any City or Country',
                                 border: InputBorder.none,
                               prefixIcon: Icon(Icons.search),
                               suffixIcon: IconButton(
                                   onPressed: (){
                                     search.clear();
                                   },
                                   icon:  Icon(CupertinoIcons.clear,size: 15,))
                             ),
                           ),
                         ),
                       ),
                       InkWell(
                         onTap: (){
                               if(search.text.isNotEmpty){
                               provider.getSearchRieger(search.text);
                               }
                         },
                         child: Card(
                           child: SizedBox(
                             height: 50,
                             width: 50,
                             child: Icon(CupertinoIcons.search,size: 30,),
                             //search outline button
                           
                           ),
                         ),
                       )
                     ],
                   ),
                 ),

                 SizedBox(height: 15,),

                 provider.isLoading? Center(child: CircularProgressIndicator(),) : SizedBox(),
                 
                 for(var item in provider.items)
                   ListTile(
                     onTap: (){
                       context.goNamed('weather',extra: item);
                     },
                     title: Text(item.name??''),
                     subtitle: Text(item.region??''),
                   )
               ],
             )
        );
      }
    );
  }
}
